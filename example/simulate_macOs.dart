import 'dart:ui'; // For backdrop blur

import 'package:dock_bounce_icon/dock_bounce.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DockBounceNavigationBar(
        bounceCount: 5,
        bounceHeight: 35,
        bottomNavigationBarHeight: 260,
        bounceDuration: const Duration(milliseconds: 500),
        bottomNavigationBarElevation: 0,
        iconPadding: const EdgeInsets.only(bottom: 30),
        bottomNavigationBarColor: Colors.white,
        items: [
          // Android Studio Icon
          _dockItem(
            imagePath: 'assets/images/android_studio.png',
            soundAsset: 'sounds/home.wav',
            label: 'Android Studio',
            content: 'Welcome to Android Studio',
          ),

          // Figma Icon
          _dockItem(
            imagePath: 'assets/images/figma.png',
            soundAsset: 'sounds/settings.wav',
            label: 'Figma',
            content: 'Design with Figma',
          ),

          // Xcode Icon
          _dockItem(
            imagePath: 'assets/images/xcode.png',
            soundAsset: 'sounds/heartbeat.mp3',
            label: 'Xcode',
            content: 'Build iOS apps with Xcode',
          ),

          // Safari Icon with bouncing heart on page
          DockBounceNavigationItem(
            icon: _dockIcon('assets/images/safari.png'),
            soundAsset: 'sounds/heartbeat.mp3',
            page: Center(
              child: DockBounceIcon(
                bounceHeight: 40,
                duration: const Duration(milliseconds: 600),
                bounceCount: 10,
                soundAsset: 'sounds/heartbeat.mp3',
                onTap: () => debugPrint("Safari icon tapped"),
                onBounceStart: () => debugPrint("Safari bounce start"),
                onBounceEnd: () => debugPrint("Safari bounce end"),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
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
            ),
          ),
        ],
      ),
    );
  }

  /// Helper to create dock navigation item with image
  static DockBounceNavigationItem _dockItem({
    required String imagePath,
    required String soundAsset,
    required String label,
    required String content,
  }) {
    return DockBounceNavigationItem(
      icon: _dockIcon(imagePath),
      soundAsset: soundAsset,
      page: _frostedPage(label, content),
    );
  }

  /// Creates an image widget styled like macOS Dock icon
  static Widget _dockIcon(String path) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: SizedBox(
        height: 100,
        width: 100,
        child: Image.asset(
          path,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  /// Styled frosted background content page
  static Widget _frostedPage(String title, String message) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/figma.png',
          fit: BoxFit.cover,
          opacity: const AlwaysStoppedAnimation(0.05),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withOpacity(0.6),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87)),
                  const SizedBox(height: 12),
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
}
