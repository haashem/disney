import 'package:disney/router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DisneyApp());
}

class DisneyApp extends StatelessWidget {
  const DisneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData.dark();

    themeData = themeData.copyWith(
      sliderTheme: SliderThemeData(
        valueIndicatorShape: RectangularSliderValueIndicatorShape(),
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorColor: Colors.white,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          // foregroundColor: WidgetStatePropertyAll(Colors.white),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return const BorderSide(
                color: Colors.white,
                width: 2,
              );
            }
            return null;
          }),
        ),
      ),
    );

    return MaterialApp.router(
      theme: themeData,
      routerConfig: AppRouter.router,
    );
  }
}
