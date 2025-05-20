import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

/// A widget that provides a bouncing animation effect with optional sound when tapped.
/// Can be used to give a dock-style animation, similar to macOS dock icons.
class DockBounceIcon extends StatefulWidget {
  final Widget child;
  final Duration duration; // Duration of a single bounce animation
  final double bounceHeight; // Vertical distance of the bounce
  final VoidCallback? onTap; // Callback when the icon is tapped
  final VoidCallback? onBounceStart; // Callback before bounce sequence starts
  final VoidCallback? onBounceEnd; // Callback after bounce sequence ends
  final bool
      enableQueue; // Allow queuing bounce animations if one is in progress
  final String? soundAsset; // Path to the asset sound to play with bounce
  final AudioPlayer? audioPlayer; // Optional external audio player
  final int bounceCount; // Number of bounces in one trigger
  final Duration bounceInterval; // Interval between bounces
  final Curve bounceOutCurve; // Custom curve for bounce-down animation

  const DockBounceIcon({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.bounceHeight = 20,
    this.onTap,
    this.onBounceStart,
    this.onBounceEnd,
    this.enableQueue = true,
    this.soundAsset,
    this.audioPlayer,
    this.bounceCount = 1,
    this.bounceInterval = const Duration(milliseconds: 100),
    this.bounceOutCurve = Curves.bounceOut,
  });

  @override
  State<DockBounceIcon> createState() => DockBounceIconState();
}

class DockBounceIconState extends State<DockBounceIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isBouncing = false;
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();

    // Animation controller for bounce effect
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Defines the bounce animation sequence: up and then down
    _animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -widget.bounceHeight)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 0.25,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -widget.bounceHeight, end: 0.0)
            .chain(CurveTween(curve: widget.bounceOutCurve)),
        weight: 0.75,
      ),
    ]).animate(_controller);

    // Use passed audio player or create a new one
    _player = widget.audioPlayer ?? AudioPlayer();
  }

  // Handles bounce sequence logic including delay and sound playback
  Future<void> _startBounceSequence(int count) async {
    if (_isBouncing && !widget.enableQueue) return;

    _isBouncing = true;
    widget.onBounceStart?.call();

    for (int i = 0; i < count; i++) {
      if (!mounted) break;

      await _controller.forward(from: 0.0);

      // Play sound if asset is specified
      if (widget.soundAsset != null) {
        try {
          await _player.play(AssetSource(widget.soundAsset!));
        } catch (e) {
          debugPrint('Error playing sound: $e');
        }
      }

      // Wait before next bounce
      if (i < count - 1) {
        await Future.delayed(widget.bounceInterval);
      }
    }

    _isBouncing = false;
    await _player.stop();
    widget.onBounceEnd?.call();
  }

  // Triggers the bounce sequence externally or on tap
  void _triggerBounce() {
    _startBounceSequence(widget.bounceCount);
  }

  // Manually stop the animation and audio
  void stop() {
    _controller.stop();
    _player.stop();
    _isBouncing = false;
  }

  @override
  void dispose() {
    if (widget.audioPlayer == null) {
      _player.dispose();
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
        _triggerBounce();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animation.value),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
