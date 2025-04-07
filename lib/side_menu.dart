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
        duration: const Duration(milliseconds: 300),
        width: isFocused ? 200 : 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(onPressed: () {}, child: Icon(Icons.search)),
            ElevatedButton(onPressed: () {}, child: Icon(Icons.home)),
            ElevatedButton(onPressed: () {}, child: Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
