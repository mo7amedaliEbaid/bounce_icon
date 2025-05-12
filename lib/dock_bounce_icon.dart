import 'package:flutter/material.dart';

class DockBounceIcon extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double bounceHeight;
  final VoidCallback? onTap;
  final VoidCallback? onBounceStart;
  final VoidCallback? onBounceEnd;
  final bool enableQueue;

  const DockBounceIcon({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.bounceHeight = 120,
    this.onTap,
    this.onBounceStart,
    this.onBounceEnd,
    this.enableQueue = true,
  });

  @override
  State<DockBounceIcon> createState() => _DockBounceIconState();
}

class _DockBounceIconState extends State<DockBounceIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isBouncing = false;

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
          weight: 0.25),
      TweenSequenceItem(
          tween: Tween(begin: -widget.bounceHeight, end: 0.0)
              .chain(CurveTween(curve: Curves.bounceOut)),
          weight: 0.75),
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        widget.onBounceEnd?.call();
        _isBouncing = false;
      }
    });
  }

  void _triggerBounce() {
    if (_isBouncing && !widget.enableQueue) return;

    widget.onBounceStart?.call();
    _isBouncing = true;
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
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
