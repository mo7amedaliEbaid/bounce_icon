import 'package:dock_bounce_icon/dock_bounce.dart';
import 'package:flutter/material.dart';

// Entry point of the application
void main() => runApp(const MyApp());

// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      home: DockBounceNavigationBar(
        bounceCount: 3,
        // Number of bounce repetitions when an icon is tapped
        bounceHeight: 40,
        // Height of the bounce animation
        bottomNavigationBarElevation: 0,
        // No shadow under the bottom navigation bar
        iconPadding: const EdgeInsets.only(
          bottom: 25,
        ),
        // Padding to raise icons visually
        items: [
          // First navigation item (Home)
          DockBounceNavigationItem(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
              size: 50,
            ),
            soundAsset: 'sounds/home.wav', // Path to the bounce sound asset
            page: Container(
              color: Colors.white,
              child: const Center(
                child: Text('Home Page'), // Content of the Home Page
              ),
            ),
          ),

          // Second navigation item (Settings)
          DockBounceNavigationItem(
            icon: Container(
              color: Colors.white,
              child: Icon(
                Icons.settings,
                color: Colors.green,
                size: 50,
              ),
            ),
            soundAsset: 'sounds/settings.wav', // Path to the bounce sound asset
            page: const Center(
              child: Text('Settings Page'), // Content of the Settings Page
            ),
          ),

          // Third navigation item (Profile with custom bouncing icon)
          DockBounceNavigationItem(
            icon: Container(
              color: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.purple,
                size: 50,
              ),
            ),
            soundAsset:
                'sounds/heartbeat.mp3', // Sound when navigation item is tapped
            page: Center(
              // Page content includes a bouncing heart icon
              child: DockBounceIcon(
                bounceHeight: 40,
                // Height of the bounce
                duration: const Duration(milliseconds: 600),
                // Duration per bounce
                soundAsset: 'sounds/heartbeat.mp3',
                // Sound played during bounce
                bounceCount: 12,
                // Repeats the bounce 12 times
                onBounceStart: () => debugPrint("Bounce started"),
                // Optional callback
                onBounceEnd: () => debugPrint("Bounce ended"),
                // Optional callback
                onTap: () => debugPrint("Icon tapped"),
                // Optional callback
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      )
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
}
