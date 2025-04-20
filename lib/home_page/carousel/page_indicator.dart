import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {

  final TabController? tabController;

  const PageIndicator({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return TabPageSelector(
      controller: tabController,
      indicatorSize: 8,
      selectedColor: Colors.white,
      color: Colors.white10,
      borderStyle: BorderStyle.none,
    );
  }
}
