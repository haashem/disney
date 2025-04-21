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
      scaffoldBackgroundColor: Color(0xFF1a1c28),
      sliderTheme: SliderThemeData(
        valueIndicatorShape: RectangularSliderValueIndicatorShape(),
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorColor: Colors.white,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return Colors.white;
            }
            return Colors.white10;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return Colors.black;
            }
            return Colors.white;
          }),
          padding: WidgetStatePropertyAll(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          minimumSize: WidgetStatePropertyAll(
            const Size(100, 52),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
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
