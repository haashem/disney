import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileSelectionPage extends StatelessWidget {
  const ProfileSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xFF1a1c28),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Whose watching?',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileAvatar(
                    name: 'Minnie',
                    imageUrl: 'assets/images/profile/02.png',
                    autoFocus: true,
                    onPressed: () => context.go('/')),
                ProfileAvatar(
                    name: 'Mickey',
                    imageUrl: 'assets/images/profile/01.png',
                    autoFocus: false,
                    onPressed: () => context.go('/'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatefulWidget {
  final String name;
  final String imageUrl;
  final bool autoFocus;
  final VoidCallback onPressed;

  const ProfileAvatar({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.autoFocus,
    required this.onPressed,
  });

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  late bool isFocused = widget.autoFocus;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: widget.onPressed,
          autofocus: widget.autoFocus,
          onFocusChange: (value) {
            setState(() {
              isFocused = value;
            });
          },
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(CircleBorder()),
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            side: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.focused) ||
                  states.contains(WidgetState.pressed)) {
                return BorderSide(
                  color: Colors.white,
                  width: 3,
                );
              }
              return null;
            }),
            backgroundBuilder: (context, states, child) {
              return AnimatedScale(
                  scale: isFocused ? 1.1 : 1,
                  duration: Duration(milliseconds: 200),
                  child: child);
            },
          ),
          child: ClipOval(
            child: Image.asset(
              widget.imageUrl,
              fit: BoxFit.cover,
              width: 140,
              height: 140,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          widget.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: isFocused ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ],
    );
  }
}
