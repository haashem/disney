import 'package:flutter/material.dart';

class ProfileSelectionPage extends StatelessWidget {
  const ProfileSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Selection'),
        leading: BackButton(),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(color: Colors.black),
        child: Center(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileAvatar(
                      name: 'Minnie',
                      imageUrl:
                          'https://pixabay.com/get/g951294c1bbcad89f5f87102c04cf971c7327f6410e8f01bfefe8fcacc60e7d630d8a5508b8bc2e0d7e94d3c93c3ff406111989628c4dab77d142fa4ee595da92_1280.jpg',
                      isSelected: false,
                      // focusNode: focusNode,
                      onTap: () {}),
                  ProfileAvatar(
                      name: 'Minnie',
                      imageUrl:
                          'https://pixabay.com/get/gfb2b52826840da24f613c2b99f2621a841a4f3799afb2d22a6dc0faf96de467e2c14f143fce1a46e28075885235f05ca74f31a4ee518a52c314d7608df4221fc_1280.jpg',
                      isSelected: false,
                      // focusNode: focusNode,
                      onTap: () {})
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isSelected;
  // final FocusNode focusNode;
  final VoidCallback onTap;

  const ProfileAvatar({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.isSelected,
    // required this.focusNode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
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
      ),

      // ElevatedButton.styleFrom(
      //   backgroundColor: isSelected ? Colors.blue : Colors.grey,
      //   shape: const CircleBorder(),
      //   padding: const EdgeInsets.all(8),
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: 140,
              height: 140,
            ),
          ),
          // const SizedBox(height: 16),
          // Text(
          //   name,
          //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
          //         color: Colors.white,
          //         fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          //       ),
          // ),
        ],
      ),
    );
  }
}
