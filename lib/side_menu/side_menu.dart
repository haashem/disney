import 'package:disney/side_menu/side_menu_focus_traversal_policy2.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  final ValueChanged<int> onItemSelected;
  const SideMenu({super.key, required this.onItemSelected});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isFocused = false;
  int selectedIndex = 1;
  final FocusNode focusNode = FocusNode(debugLabel: 'SideMenu Focus Node');
  final List<FocusNode> sideMenuNodes = List.generate(
    4,
    (index) => FocusNode(debugLabel: 'SideMenuItem $index'),
  );

  void itemSelected(int index) {
    selectedIndex = index;
    widget.onItemSelected(index);
    focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      skipTraversal: true,
      focusNode: focusNode,
      onFocusChange: (isFocused) {
        setState(() {
          this.isFocused = isFocused;
        });
        if (isFocused) {
          sideMenuNodes[selectedIndex].requestFocus();
        }
      },
      child: FocusTraversalGroup(
        policy: SideMenuFocusTraversalPolicy2(sideMenuNodes: sideMenuNodes),
        child: AnimatedContainer(
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
          width: isFocused ? 240 : 66,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFF1a1c28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(isFocused ? 100 : 0),
                blurRadius: 20,
                spreadRadius: 10,
                offset: const Offset(10, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 32,
            children: [
              _SideMenuButton.search(
                isSelected: false,
                showLabel: isFocused,
                focusNode: sideMenuNodes[0],
                onPressed: () => itemSelected(0),
              ),
              _SideMenuButton.home(
                isSelected: false,
                showLabel: isFocused,
                focusNode: sideMenuNodes[1],
                onPressed: () => itemSelected(1),
              ),
              _SideMenuButton.watchlist(
                isSelected: false,
                showLabel: isFocused,
                focusNode: sideMenuNodes[2],
                onPressed: () => itemSelected(2),
              ),
              _SideMenuButton.settings(
                isSelected: false,
                showLabel: isFocused,
                focusNode: sideMenuNodes[3],
                onPressed: () => itemSelected(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SideMenuButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isSelected;
  final IconData icon;
  final String label;
  final bool showLabel;
  final FocusNode focusNode;

  const _SideMenuButton.search({
    required this.onPressed,
    this.isSelected = false,
    this.showLabel = false,
    required this.focusNode,
  })  : icon = Icons.search,
        label = 'SEARCH';

  const _SideMenuButton.home({
    required this.onPressed,
    this.isSelected = false,
    this.showLabel = true,
    required this.focusNode,
  })  : icon = Icons.home,
        label = 'HOME';

  const _SideMenuButton.watchlist({
    required this.onPressed,
    this.isSelected = false,
    this.showLabel = false,
    required this.focusNode,
  })  : icon = Icons.add,
        label = 'WATCHLIST';

  const _SideMenuButton.settings({
    required this.onPressed,
    this.isSelected = false,
    this.showLabel = false,
    required this.focusNode,
  })  : icon = Icons.settings,
        label = 'SETTINGS';

  @override
  State<_SideMenuButton> createState() => _SideMenuButtonState();
}

class _SideMenuButtonState extends State<_SideMenuButton> {
  bool showLabel = false;

  @override
  void didUpdateWidget(covariant _SideMenuButton oldWidget) {
    if (widget.showLabel == false) {
      setState(() {
        showLabel = false;
      });
    } else {
      Future.delayed(const Duration(milliseconds: 250), () {
        if (mounted) {
          setState(() {
            showLabel = widget.showLabel;
          });
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Icon(
          widget.icon,
          color: widget.isSelected ? Colors.white : Colors.white54,
          size: 24,
        ),
        TextButton(
          onPressed: widget.onPressed,
          focusNode: widget.focusNode,
          style: ButtonStyle(
            padding: WidgetStateProperty.resolveWith((states) {
              return showLabel
                  ? const EdgeInsets.symmetric(horizontal: 12)
                  : EdgeInsets.zero;
            }),
            minimumSize: WidgetStatePropertyAll(
              Size.zero,
            ),
            backgroundBuilder: (context, states, child) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: states.contains(WidgetState.focused)
                          ? Colors.white
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: child,
              );
            },
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(),
            ),
            overlayColor: WidgetStatePropertyAll(
              Colors.transparent,
            ),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.focused)) {
                return Colors.white;
              }
              return Colors.white54;
            }),
            textStyle: WidgetStatePropertyAll(
              const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w400, letterSpacing: 1),
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: showLabel
                ? Text(
                    widget.label,
                  )
                : const SizedBox.shrink(),
          ),
        )
      ],
    );
  }
}
