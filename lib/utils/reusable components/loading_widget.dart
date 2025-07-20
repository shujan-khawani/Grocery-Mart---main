// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

/// Reusable loading widget with different styles
class LoadingWidget extends StatelessWidget {
  final String? message;
  final double size;
  final Color? color;
  final LoadingStyle style;

  const LoadingWidget({
    super.key,
    this.message,
    this.size = 40.0,
    this.color,
    this.style = LoadingStyle.circular,
  });

  /// Small loading indicator for buttons
  const LoadingWidget.small({
    super.key,
    this.message,
    this.color,
    this.style = LoadingStyle.circular,
  }) : size = 20.0;

  /// Large loading indicator for full screen
  const LoadingWidget.large({
    super.key,
    this.message,
    this.color,
    this.style = LoadingStyle.circular,
  }) : size = 60.0;

  /// Full screen loading overlay
  const LoadingWidget.overlay({
    super.key,
    this.message,
    this.color,
    this.style = LoadingStyle.circular,
  }) : size = 40.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loadingColor = color ?? theme.primaryColor;

    Widget loadingIndicator;
    switch (style) {
      case LoadingStyle.circular:
        loadingIndicator = SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            color: loadingColor,
            strokeWidth: size > 30 ? 4.0 : 2.0,
          ),
        );
        break;
      case LoadingStyle.linear:
        loadingIndicator = SizedBox(
          width: size * 3,
          child: LinearProgressIndicator(
            color: loadingColor,
            backgroundColor: loadingColor.withOpacity(0.2),
          ),
        );
        break;
      case LoadingStyle.dots:
        loadingIndicator = DotsLoadingIndicator(
          size: size,
          color: loadingColor,
        );
        break;
      case LoadingStyle.pulse:
        loadingIndicator = PulseLoadingIndicator(
          size: size,
          color: loadingColor,
        );
        break;
    }

    if (message != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          loadingIndicator,
          const SizedBox(height: 16),
          Text(
            message!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return loadingIndicator;
  }
}

/// Full screen loading overlay
class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? message;
  final Color? backgroundColor;

  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.message,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: backgroundColor ?? Colors.black.withOpacity(0.5),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: LoadingWidget(
                  message: message ?? 'Loading...',
                  style: LoadingStyle.circular,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Custom dots loading indicator
class DotsLoadingIndicator extends StatefulWidget {
  final double size;
  final Color color;

  const DotsLoadingIndicator({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  State<DotsLoadingIndicator> createState() => _DotsLoadingIndicatorState();
}

class _DotsLoadingIndicatorState extends State<DotsLoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size * 2,
      height: widget.size / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final delay = index * 0.2;
              final progress = (_controller.value - delay).clamp(0.0, 1.0);
              final scale =
                  0.5 +
                  (0.5 * (1 - (progress - 0.5).abs() * 2).clamp(0.0, 1.0));

              return Transform.scale(
                scale: scale,
                child: Container(
                  width: widget.size / 4,
                  height: widget.size / 4,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

/// Custom pulse loading indicator
class PulseLoadingIndicator extends StatefulWidget {
  final double size;
  final Color color;

  const PulseLoadingIndicator({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  State<PulseLoadingIndicator> createState() => _PulseLoadingIndicatorState();
}

class _PulseLoadingIndicatorState extends State<PulseLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}

/// Loading styles enum
enum LoadingStyle { circular, linear, dots, pulse }

/// Loading button that shows loading state
class LoadingButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;
  final ButtonStyle? style;

  const LoadingButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading ? const LoadingWidget.small() : icon!,
        label: Text(label),
        style: style,
      );
    }

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: style,
      child: isLoading ? const LoadingWidget.small() : Text(label),
    );
  }
}
