import 'package:flutter/material.dart';

import 'dock_bounce_icon.dart';

/// Represents a navigation item with an icon, associated page, and optional sound.
class DockBounceNavigationItem {
  final Widget icon;
  final String? soundAsset;
  final Widget page;

  DockBounceNavigationItem({
    required this.icon,
    required this.page,
    this.soundAsset,
  });
}

/// A bottom navigation bar that uses bouncing icons with optional sound on tap.
/// Also includes a loading indicator during page transitions.
class DockBounceNavigationBar extends StatefulWidget {
  final List<DockBounceNavigationItem> items; // List of navigation items
  final Duration bounceDuration;
  final double bounceHeight;
  final int bounceCount;
  final double bottomNavigationBarElevation;
  final double bottomNavigationBarHeight;
  final Color bottomNavigationBarColor;
  final Duration bounceInterval;
  final Curve bounceOutCurve;
  final EdgeInsets iconPadding;
  final Widget loadingWidget;

  const DockBounceNavigationBar({
    super.key,
    required this.items,
    this.bounceDuration = const Duration(milliseconds: 500),
    this.bounceHeight = 20,
    this.bounceCount = 1,
    this.bottomNavigationBarElevation = 2,
    this.bottomNavigationBarColor = Colors.white,
    this.bounceInterval = const Duration(milliseconds: 100),
    this.bounceOutCurve = Curves.bounceOut,
    this.iconPadding = const EdgeInsets.all(12.0),
    this.loadingWidget = const Center(child: CircularProgressIndicator()),
    this.bottomNavigationBarHeight = 80,
  });

  @override
  State<DockBounceNavigationBar> createState() =>
      _DockBounceNavigationBarState();
}

class _DockBounceNavigationBarState extends State<DockBounceNavigationBar> {
  int _currentIndex = 0; // Tracks the current selected index
  bool _isLoading = false; // Whether the loading overlay is active

  late final List<GlobalKey<DockBounceIconState>> _iconKeys;

  @override
  void initState() {
    super.initState();
    // Creates a global key for each bounce icon to control them
    _iconKeys = List.generate(
      widget.items.length,
      (_) => GlobalKey<DockBounceIconState>(),
    );
  }

  // Called when a navigation item is tapped
  void _onItemTapped(int index) async {
    if (_isLoading || index == _currentIndex) return;

    // Stop previous animation
    _iconKeys[_currentIndex].currentState?.stop();

    setState(() {
      _isLoading = true;
    });

    // Simulate bounce + delay
    await Future.delayed(
      widget.bounceDuration * widget.bounceCount +
          widget.bounceInterval * (widget.bounceCount - 1),
    );

    setState(() {
      _currentIndex = index;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = widget.items[_currentIndex].page;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(child: currentPage),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.white,
                child: widget.loadingWidget,
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: widget.bottomNavigationBarElevation,
        color: widget.bottomNavigationBarColor,
        child: SizedBox(
          height: widget.bottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(widget.items.length, (index) {
              final item = widget.items[index];
              return DockBounceIcon(
                key: _iconKeys[index],
                bounceHeight: widget.bounceHeight,
                duration: widget.bounceDuration,
                bounceCount: widget.bounceCount,
                bounceInterval: widget.bounceInterval,
                bounceOutCurve: widget.bounceOutCurve,
                soundAsset: item.soundAsset,
                onTap: () => _onItemTapped(index),
                child: Padding(
                  padding: widget.iconPadding,
                  child: item.icon,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
