import 'package:disney/home_page/home_page.dart';
import 'package:disney/home_page/scrollable_enusure_alignment.dart';

import 'package:disney/search_page.dart';
import 'package:disney/side_menu/side_menu.dart';
import 'package:disney/watch_list_page.dart';
import 'package:flutter/material.dart';

class HomePageScaffold extends StatefulWidget {
  const HomePageScaffold({super.key});

  @override
  State<HomePageScaffold> createState() => _HomePageScaffoldState();
}

class _HomePageScaffoldState extends State<HomePageScaffold> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF1a1c28),
      child: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                width: 74,
              ),
              FocusTraversalGroup(
                policy: ReadingOrderTraversalPolicy(
                  requestFocusCallback: (node,
                      {alignment, alignmentPolicy, duration, curve}) {
                    final nodeContext = node.context;
                    if (nodeContext == null) {
                      return;
                    }
                    node.requestFocus();
                    ScrollableX.ensureDirectionalAlignment(
                      nodeContext,
                      (axisDirection) => switch (axisDirection) {
                        AxisDirection.down || AxisDirection.up => 0.6,
                        AxisDirection.left || AxisDirection.right => 0.06
                      },
                      duration: duration ?? const Duration(milliseconds: 300),
                      curve: Curves.easeInOutQuad,
                    );
                  },
                ),
                child: Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: [
                    SearchPage(),
                    HomePage(),
                    WatchListPage(),
                  ]),
                ),
              ),
            ],
          ),
          SideMenu(
            onItemSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          )
          // FocusScope(
          //     debugLabel: 'SideMenuScope',
          //     onKeyEvent: (node, event) {
          //       if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
          //           event.logicalKey == LogicalKeyboardKey.arrowRight) {
          //         final x = node.focusInDirection(TraversalDirection.right);
          //         node.
          //         print(x);
          //         return KeyEventResult.handled;
          //       }

          //       return KeyEventResult.ignored;
          //     },
          //     child: SideMenu()),
        ],
      ),
    );
  }
}

// /// An [Action] that moves the focus to the focusable node in the direction
// /// configured by the associated [DirectionalFocusIntent.direction].
// ///
// /// This is the [Action] associated with [DirectionalFocusIntent] and bound by
// /// default to the [LogicalKeyboardKey.arrowUp], [LogicalKeyboardKey.arrowDown],
// /// [LogicalKeyboardKey.arrowLeft], and [LogicalKeyboardKey.arrowRight] keys in
// /// the [WidgetsApp], with the appropriate associated directions.
// class DirectionalFocusAction2 extends Action<DirectionalFocusIntent> {
//   /// Creates a [DirectionalFocusAction].
//   DirectionalFocusAction2();

//   @override
//   void invoke(DirectionalFocusIntent intent) {
//     print(intent);
//     primaryFocus!.focusInDirection(intent.direction);
//   }
// }
