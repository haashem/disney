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
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            return Colors.white;
          }),
          surfaceTintColor: WidgetStateProperty.resolveWith((states) {
            return Colors.transparent;
          }),
          // overlayColor: WidgetStateProperty.resolveWith((states) {
          //   return Colors.transparent;
          // }),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          backgroundBuilder: (context, states, child) {
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
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

          // padding: WidgetStatePropertyAll(
          //   const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          // ),
          // minimumSize: WidgetStatePropertyAll(
          //   const Size(130, 52),
          // ),
        ),
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
            const Size(130, 52),
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
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
