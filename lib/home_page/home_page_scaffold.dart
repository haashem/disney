import 'package:disney/home_page/browse_traversal_policy.dart';
import 'package:disney/home_page/home_page.dart';

import 'package:disney/search_page.dart';
import 'package:disney/side_menu/side_menu.dart';
import 'package:disney/side_menu/side_menu_traversal_policy.dart';
import 'package:disney/watch_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePageScaffold extends StatefulWidget {
  const HomePageScaffold({super.key});

  @override
  State<HomePageScaffold> createState() => _HomePageScaffoldState();
}

class _HomePageScaffoldState extends State<HomePageScaffold> {
  int _selectedIndex = 0;
  final FocusScopeNode _sideMenuScopeNode =
      FocusScopeNode(debugLabel: 'SideMenuScope');
  final FocusScopeNode _homePageScopeNode =
      FocusScopeNode(debugLabel: 'HomePageScope');
  final FocusScopeNode _searchPageScopeNode =
      FocusScopeNode(debugLabel: 'SearchPageScope');
  final FocusScopeNode _watchListPageScopeNode =
      FocusScopeNode(debugLabel: 'WatchListPageScope');

  late final rightPanelScopeNodes = [
    _searchPageScopeNode,
    _homePageScopeNode,
    _watchListPageScopeNode,
  ];
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
              Expanded(
                child: IndexedStack(index: _selectedIndex, children: [
                  FocusScope(
                      node: _searchPageScopeNode,
                      skipTraversal: true,
                      onKeyEvent: (node, event) {
                        if (event is KeyUpEvent) {
                          return KeyEventResult.handled;
                        }
                        if (event.logicalKey != LogicalKeyboardKey.arrowLeft) {
                          return KeyEventResult.ignored;
                        }

                        if (!_searchPageScopeNode
                            .focusInDirection(TraversalDirection.left)) {
                          _sideMenuScopeNode.requestFocus();
                        }
                        return KeyEventResult.handled;
                      },
                      child: SearchPage()),
                  FocusTraversalGroup(
                    policy: BrowseTraversalPolicy(),
                    child: FocusScope(
                      node: _homePageScopeNode,
                      autofocus: true,
                      skipTraversal: true,
                      onKeyEvent: (node, event) {
                        if (event is KeyUpEvent) {
                          return KeyEventResult.handled;
                        }
                        if (event.logicalKey != LogicalKeyboardKey.arrowLeft) {
                          return KeyEventResult.ignored;
                        }

                        if (!_homePageScopeNode
                            .focusInDirection(TraversalDirection.left)) {
                          _sideMenuScopeNode.requestFocus();
                        }
                        return KeyEventResult.handled;
                      },
                      child: HomePage(),
                    ),
                  ),
                  WatchListPage(),
                ]),
              ),
            ],
          ),
          FocusScope(
            node: _sideMenuScopeNode,
            skipTraversal: true,
            onKeyEvent: (node, event) {
              if (event is KeyUpEvent &&
                  event.logicalKey == LogicalKeyboardKey.arrowRight) {
                rightPanelScopeNodes[_selectedIndex].requestFocus();

                return KeyEventResult.handled;
              }
              return KeyEventResult.ignored;
            },
            child: SideMenu(
              focusNode: _sideMenuScopeNode,
              selectedIndex: _selectedIndex,
              onItemSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                  final targetScopeNode = rightPanelScopeNodes[_selectedIndex];

                  print(targetScopeNode.focusedChild);
                  targetScopeNode.requestFocus();
                });
              },
            ),
          )
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
