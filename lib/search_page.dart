import 'package:disney/home_page/focuse_tile.dart';
import 'package:disney/models/search_categories.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      slivers: [
        SliverPadding(padding: EdgeInsets.only(top: 32)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: textFieldController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white10,
                hintText: 'Search by title, character, or genre',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide.none,
                ),
              ),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Explore',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: GridView.count(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            childAspectRatio: 1.3,
            children: List.generate(searchCategories.length, (index) {
              return Padding(
                padding: EdgeInsets.all(8),
                child: IntereactiveTile(
                    imageUrl: searchCategories[index], onPressed: () {}),
              );
            }),
          ),
        ),
      ],
    ));
  }
}
