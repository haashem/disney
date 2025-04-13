import 'package:disney/home_page.dart';
import 'package:disney/playback/ui/playback_page.dart';
import 'package:disney/profile_selection_page.dart';
import 'package:disney/search_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String profileSelection = 'profile-selection';
  static const String home = 'browse';
  static const String playback = 'playback';
  static const String search = 'search';
  static const String watchlist = 'watchlist';

  // Add more routes as needed

  static final GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: profileSelection,
          builder: (BuildContext context, GoRouterState state) {
            return const ProfileSelectionPage();
          },
        ),
        GoRoute(
          path: playback,
          builder: (BuildContext context, GoRouterState state) {
            return const PlaybackPage();
          },
        ),
        GoRoute(
          path: playback,
          builder: (BuildContext context, GoRouterState state) {
            return const SearchPage();
          },
        ),
      ],
    ),
  ]);
}
