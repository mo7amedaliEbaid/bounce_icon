import 'package:dock_bounce_icon/dock_bounce.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dock Bounce Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const BounceHomePage(),
    );
  }
}

class BounceHomePage extends StatelessWidget {
  const BounceHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dock Bounce Demo'),
      ),
      body: Center(
        child: DockBounceIcon(
          bounceHeight: 40,
          duration: const Duration(milliseconds: 600),
          soundAsset: 'sounds/heartbeat.mp3',
          bounceCount: 12,
          onBounceStart: () => debugPrint("Bounce started"),
          onBounceEnd: () => debugPrint("Bounce ended"),
          onTap: () => debugPrint("Icon tapped"),
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
            child: const Icon(Icons.favorite, color: Colors.red, size: 40),
          ),
        ),
      ),
    );
  }
}
