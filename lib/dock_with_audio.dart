/*
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class DockBounceIcon extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double bounceHeight;
  final VoidCallback? onTap;
  final VoidCallback? onBounceStart;
  final VoidCallback? onBounceEnd;
  final bool enableQueue;
  final String? soundAsset;
  final AudioPlayer? audioPlayer;
  final int bounceCount;
  final Duration bounceInterval; // delay between bounces
  final Curve bounceOutCurve;

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
  State<DockBounceIcon> createState() => _DockBounceIconState();
}

class _DockBounceIconState extends State<DockBounceIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isBouncing = false;
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -widget.bounceHeight).chain(
          CurveTween(curve: Curves.easeOut),
        ),
        weight: 0.25,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -widget.bounceHeight, end: 0.0).chain(
          CurveTween(curve: widget.bounceOutCurve),
        ),
        weight: 0.75,
      ),
    ]).animate(_controller);

    _player = widget.audioPlayer ?? AudioPlayer();
  }

  Future<void> _startBounceSequence(int count) async {
    if (_isBouncing && !widget.enableQueue) return;

    _isBouncing = true;
    widget.onBounceStart?.call();

    for (int i = 0; i < count; i++) {
      await _controller.forward(from: 0.0);

      if (widget.soundAsset != null) {
        try {
          await _player.play(AssetSource(widget.soundAsset!));
        } catch (e) {
          debugPrint('Error playing sound: $e');
        }
      }

      if (i < count - 1) {
        await Future.delayed(widget.bounceInterval);
      }
    }

    // Stop audio playback after bouncing finishes
    try {
      await _player.stop();
    } catch (e) {
      debugPrint('Error stopping audio: $e');
    }

    _isBouncing = false;
    widget.onBounceEnd?.call();
  }

  */
/*Future<void> _startBounceSequence(int count) async {
    if (_isBouncing && !widget.enableQueue) return;

    _isBouncing = true;
    widget.onBounceStart?.call();

    for (int i = 0; i < count; i++) {
      await _controller.forward(from: 0.0);

      if (widget.soundAsset != null) {
        try {
          await _player.play(AssetSource(widget.soundAsset!));
        } catch (e) {
          debugPrint('Error playing sound: $e');
        }
      }

      // Delay between bounces, except after the last one
      if (i < count - 1) {
        await Future.delayed(widget.bounceInterval);
      }
    }

    _isBouncing = false;
    widget.onBounceEnd?.call();
  }*/ /*


  void _triggerBounce() {
    _startBounceSequence(widget.bounceCount);
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
*/
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class DockBounceIcon extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double bounceHeight;
  final VoidCallback? onTap;
  final VoidCallback? onBounceStart;
  final VoidCallback? onBounceEnd;
  final bool enableQueue;
  final String? soundAsset;
  final AudioPlayer? audioPlayer;
  final int bounceCount;
  final Duration bounceInterval;
  final Curve bounceOutCurve;

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

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

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

    _player = widget.audioPlayer ?? AudioPlayer();
  }

  Future<void> _startBounceSequence(int count) async {
    if (_isBouncing && !widget.enableQueue) return;

    _isBouncing = true;
    widget.onBounceStart?.call();

    for (int i = 0; i < count; i++) {
      if (!mounted) break;
      await _controller.forward(from: 0.0);

      if (widget.soundAsset != null) {
        try {
          await _player.play(AssetSource(widget.soundAsset!));
        } catch (e) {
          debugPrint('Error playing sound: $e');
        }
      }

      if (i < count - 1) {
        await Future.delayed(widget.bounceInterval);
      }
    }

    _isBouncing = false;
    await _player.stop();
    widget.onBounceEnd?.call();
  }

  void _triggerBounce() {
    _startBounceSequence(widget.bounceCount);
  }

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
