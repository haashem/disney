import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isFocused = false;
  @override
  Widget build(BuildContext context) {
    return Focus(
      skipTraversal: true,
      onFocusChange: (isFocused) {
        setState(() {
          this.isFocused = isFocused;
        });
      },
      child: AnimatedContainer(
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
        width: isFocused ? 240 : 66,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff141414),
            Color(0xff141414),
            // Colors.transparent,
          ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 32,
          children: [
            _SideMenuButton.search(
              isSelected: false,
              showLabel: isFocused,
              onPressed: () {},
            ),
            _SideMenuButton.home(
              isSelected: false,
              showLabel: isFocused,
              onPressed: () {},
            ),
            _SideMenuButton.watchlist(
              isSelected: false,
              showLabel: isFocused,
              onPressed: () {},
            ),
            _SideMenuButton.settings(
              isSelected: false,
              showLabel: isFocused,
              onPressed: () {},
            ),
          ],
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

  const _SideMenuButton.search({
    required this.onPressed,
    this.isSelected = false,
    this.showLabel = false,
  })  : icon = Icons.search,
        label = 'SEARCH';

  const _SideMenuButton.home({
    required this.onPressed,
    this.isSelected = false,
    this.showLabel = true,
  })  : icon = Icons.home,
        label = 'HOME';

  const _SideMenuButton.watchlist({
    required this.onPressed,
    this.isSelected = false,
    this.showLabel = false,
  })  : icon = Icons.add,
        label = 'WATCHLIST';

  const _SideMenuButton.settings({
    required this.onPressed,
    this.isSelected = false,
    this.showLabel = false,
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
