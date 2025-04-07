
import 'package:disney/router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DisneyApp());
}

class DisneyApp extends StatelessWidget {
  const DisneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
    );
  }
}
