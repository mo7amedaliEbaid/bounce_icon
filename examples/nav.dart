import 'package:dock_bounce_icon/dock_bounce_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DockBounceNavigationBar(
        bounceCount: 2,
        bounceHeight: 30,
        bottomNavigationBarElevation: 0,
        items: [
          DockBounceNavigationItem(
            icon: Icon(Icons.home, color: Colors.blue),
            soundAsset: 'sounds/heartbeat.mp3',
            page: Container(
                color: Colors.white,
                child: const Center(child: Text('Home Page'))),
          ),
          DockBounceNavigationItem(
            icon: Container(
                color: Colors.white,
                child: Icon(Icons.settings, color: Colors.green)),
            soundAsset: 'sounds/heartbeat.mp3',
            page: const Center(child: Text('Settings Page')),
          ),
          DockBounceNavigationItem(
            icon: Container(
                color: Colors.white,
                child: Icon(Icons.person, color: Colors.purple)),
            soundAsset: 'sounds/heartbeat.mp3',
            page: const Center(child: Text('Profile Page')),
          ),
        ],
      ),
    );
  }
}
