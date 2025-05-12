/*
import 'package:flutter/material.dart';

import 'dock_with_audio.dart';

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

class DockBounceNavigationBar extends StatefulWidget {
  final List<DockBounceNavigationItem> items;
  final Duration bounceDuration;
  final double bounceHeight;
  final int bounceCount;
  final Duration bounceInterval;
  final Curve bounceOutCurve;

  const DockBounceNavigationBar({
    super.key,
    required this.items,
    this.bounceDuration = const Duration(milliseconds: 500),
    this.bounceHeight = 20,
    this.bounceCount = 1,
    this.bounceInterval = const Duration(milliseconds: 100),
    this.bounceOutCurve = Curves.bounceOut,
  });

  @override
  State<DockBounceNavigationBar> createState() =>
      _DockBounceNavigationBarState();
}

class _DockBounceNavigationBarState extends State<DockBounceNavigationBar> {
  int _currentIndex = 0;
  bool _isLoading = false;

  void _onItemTapped(int index) async {
    if (_isLoading || index == _currentIndex) return;

    setState(() {
      _isLoading = true;
    });

    // Wait for bounce to finish before changing page
    await Future.delayed(widget.bounceDuration * widget.bounceCount +
        widget.bounceInterval * (widget.bounceCount - 1));

    setState(() {
      _currentIndex = index;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = widget.items[_currentIndex].page;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: currentPage),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.1),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.items.length, (index) {
            final item = widget.items[index];
            return DockBounceIcon(
              bounceHeight: widget.bounceHeight,
              duration: widget.bounceDuration,
              bounceCount: widget.bounceCount,
              bounceInterval: widget.bounceInterval,
              bounceOutCurve: widget.bounceOutCurve,
              soundAsset: item.soundAsset,
              onTap: () => _onItemTapped(index),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: item.icon,
              ),
            );
          }),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';

import 'dock_with_audio.dart'; // This is the file where DockBounceIcon is defined

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

class DockBounceNavigationBar extends StatefulWidget {
  final List<DockBounceNavigationItem> items;
  final Duration bounceDuration;
  final double bounceHeight;
  final int bounceCount;
  final double bottomNavigationBarElevation;
  final Color bottomNavigationBarColor;
  final Duration bounceInterval;
  final Curve bounceOutCurve;

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
  });

  @override
  State<DockBounceNavigationBar> createState() =>
      _DockBounceNavigationBarState();
}

class _DockBounceNavigationBarState extends State<DockBounceNavigationBar> {
  int _currentIndex = 0;
  bool _isLoading = false;

  late final List<GlobalKey<DockBounceIconState>> _iconKeys;

  @override
  void initState() {
    super.initState();
    _iconKeys = List.generate(
      widget.items.length,
      (_) => GlobalKey<DockBounceIconState>(),
    );
  }

  void _onItemTapped(int index) async {
    if (_isLoading || index == _currentIndex) return;

    // Stop the previous bouncing animation and audio
    _iconKeys[_currentIndex].currentState?.stop();

    setState(() {
      _isLoading = true;
    });

    // Wait for bounce duration
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
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: widget.bottomNavigationBarElevation,
        color: widget.bottomNavigationBarColor,
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
                padding: const EdgeInsets.all(12.0),
                child: item.icon,
              ),
            );
          }),
        ),
      ),
    );
  }
}
