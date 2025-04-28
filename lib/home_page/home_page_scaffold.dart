import 'package:disney/home_page/grid_traversal_policy.dart';
import 'package:disney/home_page/home_page.dart';

import 'package:disney/search_page.dart';
import 'package:disney/side_menu/side_menu.dart';
import 'package:disney/watch_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePageScaffold extends StatefulWidget {
  const HomePageScaffold({super.key});

  @override
  State<HomePageScaffold> createState() => _HomePageScaffoldState();
}

class _HomePageScaffoldState extends State<HomePageScaffold> {
  int _selectedIndex = 1;
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
      child: Actions(
        actions: {
          DismissIntent: CallbackAction<DismissIntent>(
            onInvoke: (intent) => _sideMenuScopeNode.requestFocus(),
          ),
        },
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
                        onKeyEvent: (node, event) {
                          return _focusOnSideMenuIfNeeded(
                              rightPanelScopeNodes[_selectedIndex], event);
                        },
                        child: SearchPage()),
                    FocusTraversalGroup(
                      policy: GridTraversalPolicy(),
                      child: FocusScope(
                        node: _homePageScopeNode,
                        onKeyEvent: (node, event) {
                          return _focusOnSideMenuIfNeeded(
                              rightPanelScopeNodes[_selectedIndex], event);
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
              onKeyEvent: (node, event) {
                return _focusOnMainPanel(event);
              },
              child: SideMenu(
                focusNode: _sideMenuScopeNode,
                selectedIndex: _selectedIndex,
                onItemSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                    final targetScopeNode =
                        rightPanelScopeNodes[_selectedIndex];
                    targetScopeNode.requestFocus();
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  KeyEventResult _focusOnMainPanel(KeyEvent event) {
    if (event is KeyUpEvent &&
        event.logicalKey == LogicalKeyboardKey.arrowRight) {
      rightPanelScopeNodes[_selectedIndex].requestFocus();

      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  KeyEventResult _focusOnSideMenuIfNeeded(FocusScopeNode node, KeyEvent event) {
    if (event is KeyUpEvent) {
      return KeyEventResult.handled;
    }
    if (event.logicalKey != LogicalKeyboardKey.arrowLeft) {
      return KeyEventResult.ignored;
    }

    if (!node.focusInDirection(TraversalDirection.left)) {
      if (_sideMenuScopeNode.focusedChild == null) {
        _sideMenuScopeNode.focusInDirection(TraversalDirection.left);
      } else {
        _sideMenuScopeNode.requestFocus();
      }
    }
    return KeyEventResult.handled;
  }
}
