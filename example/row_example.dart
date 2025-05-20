import 'dart:ui'; // For Backdrop blur

import 'package:dock_bounce_icon/dock_bounce.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    _frostedPage('Android Studio', 'Welcome to Android Studio'),
    _frostedPage('Figma', 'Design with Figma'),
    _frostedPage('Xcode', 'Build iOS apps with Xcode'),
    _bouncingHeartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Main content
            Positioned.fill(child: _pages[_selectedIndex]),

            // Custom Dock Row
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _dockButton(
                        imagePath: 'assets/images/android_studio.png',
                        //   soundAsset: 'sounds/home.wav',
                        index: 0,
                      ),
                      _dockButton(
                        imagePath: 'assets/images/figma.png',
                        //  soundAsset: 'sounds/settings.wav',
                        index: 1,
                      ),
                      _dockButton(
                        imagePath: 'assets/images/xcode.png',
                        //   soundAsset: 'sounds/heartbeat.mp3',
                        index: 2,
                      ),
                      _dockButton(
                        imagePath: 'assets/images/safari.png',
                        //  soundAsset: 'sounds/heartbeat.mp3',
                        index: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Dock icon widget with bounce behavior
  Widget _dockButton({
    required String imagePath,
    //  required String soundAsset,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DockBounceIcon(
        bounceHeight: 35,
        bounceCount: 5,
        duration: const Duration(milliseconds: 400),
        // soundAsset: soundAsset,
        onTap: () => setState(() => _selectedIndex = index),
        child: SizedBox(
          height: 70,
          width: 70,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  /// Standard frosted background content
  static Widget _frostedPage(String title, String message) {
    return Stack(
      fit: StackFit.expand,
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            color: Colors.white.withOpacity(0.65),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Safari-style bounce demo
  static Widget _bouncingHeartPage() {
    return Center(
      child: DockBounceIcon(
        bounceHeight: 40,
        bounceCount: 10,
        duration: const Duration(milliseconds: 500),
        soundAsset: 'sounds/heartbeat.mp3',
        onTap: () => debugPrint('Safari icon tapped'),
        onBounceStart: () => debugPrint('Bounce started'),
        onBounceEnd: () => debugPrint('Bounce ended'),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 40,
          ),
        ),
      ),
    );
  }
}
