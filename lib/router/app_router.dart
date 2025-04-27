import 'package:disney/home_page/home_page_scaffold.dart';
import 'package:disney/models/movie.dart';
import 'package:disney/playback/ui/playback_page.dart';
import 'package:disney/profile_selection_page.dart';
import 'package:disney/search_page.dart';
import 'package:disney/show_page/show_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String profileSelection = 'profile-selection';
  static const String home = 'browse';
  static const String playback = 'playback';
  static const String showPage = 'showpage';
  static const String search = 'search';
  static const String watchlist = 'watchlist';

  // Add more routes as needed

  static final GoRouter router =
      GoRouter(debugLogDiagnostics: true, routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePageScaffold();
      },
      routes: <RouteBase>[
        GoRoute(
          path: profileSelection,
          builder: (BuildContext context, GoRouterState state) {
            return const ProfileSelectionPage();
          },
        ),
        GoRoute(
            path: showPage,
            builder: (BuildContext context, GoRouterState state) {
              return ShowPage(
                movie:
                    categories.expand((element) => element.movies).firstWhere(
                          (movie) => movie.title
                              .contains(state.uri.queryParameters['movie']!),
                        ),
              );
            },
            routes: [
              GoRoute(
                path: playback,
                builder: (BuildContext context, GoRouterState state) {
                  return const PlaybackPage();
                },
              ),
            ]),
        GoRoute(
          path: search,
          builder: (BuildContext context, GoRouterState state) {
            return const SearchPage();
          },
        ),
      ],
    ),
  ]);
}
