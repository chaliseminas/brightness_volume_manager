import 'package:flutter/material.dart';

/// Enum to define the slide direction of the swipe manager.
enum SlideDirection { vertical, horizontal }

/// Callback function type to handle value changes during the swipe.
typedef ChangeCallback = void Function(double newValue, double oldValue);

/// Callback function type to handle the final value when swipe ends.
typedef FinishCallback = void Function(double value);

/// Function type to build child widgets dynamically based on the swipe value.
typedef ChildBuilder = Widget Function(BuildContext context, double value);

/// A customizable widget that allows vertical or horizontal swipe interaction.
///
/// The widget supports configurable colors, size, and child elements,
/// and allows users to listen to value changes during the swipe interaction.
class SwipeManager extends StatefulWidget {
  /// Initial value of the swipe, ranging from 0 to 1.
  final double initialValue;

  /// Callback function triggered when the value changes.
  final ChangeCallback? onChange;

  /// Callback function triggered when the swipe interaction ends.
  final FinishCallback? onFinish;

  /// Direction of the swipe, either [SlideDirection.vertical] or [SlideDirection.horizontal].
  final SlideDirection direction;

  /// Height of the swipe area.
  final double height;

  /// Width of the swipe area.
  final double width;

  /// Background color of the swipe container.
  final Color color;

  /// Fill color that represents the swipe progress.
  final Color fillColor;

  /// Function to build child elements dynamically based on the swipe value.
  final ChildBuilder? childBuilder;

  /// Optional static child widget.
  final Widget? child;

  /// Creates a [SwipeManager] widget.
  const SwipeManager({
    super.key,
    this.initialValue = 1.0,
    this.onChange,
    this.onFinish,
    this.direction = SlideDirection.vertical,
    this.color = const Color.fromRGBO(46, 45, 36, 0.5),
    this.fillColor = Colors.white,
    this.child,
    this.childBuilder,
    this.width = 20,
    this.height = 200,
  });

  @override
  State<SwipeManager> createState() => _SwipeManagerState();
}

class _SwipeManagerState extends State<SwipeManager> {
  /// Current state value representing the swipe progress.
  double? stateValue;

  @override
  void initState() {
    stateValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.direction == SlideDirection.vertical
        ? getVertical()
        : getHorizontal();
  }

  /// Updates the swipe progress based on user interaction.
  void updateData(double position) {
    double currentValue =
        double.parse((1 - (position / getMainAxisSize())).toStringAsFixed(2));
    if (currentValue > 1) {
      currentValue = 1;
    } else if (currentValue < 0) {
      currentValue = 0;
    }
    if (widget.onChange != null) {
      widget.onChange!(currentValue, stateValue!);
    }
    setState(() {
      stateValue = currentValue;
    });
  }

  /// Returns the main axis size based on the swipe direction.
  double getMainAxisSize() {
    return widget.direction == SlideDirection.horizontal
        ? widget.width
        : widget.height;
  }

  /// Builds the horizontal swipe interface.
  Widget getHorizontal() {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        updateData(widget.width - details.localPosition.dx);
      },
      onHorizontalDragEnd: (details) {
        if (widget.onFinish != null) {
          widget.onFinish!(stateValue!);
        }
      },
      onTapUp: (details) {
        updateData(widget.width - details.localPosition.dx);
        if (widget.onFinish != null) {
          widget.onFinish!(stateValue!);
        }
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              widget.color,
              widget.fillColor,
            ],
            stops: [
              1 - stateValue!,
              0,
            ],
          ),
          borderRadius: BorderRadiusDirectional.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.child == null ? Container() : widget.child!,
            widget.childBuilder == null
                ? Container()
                : widget.childBuilder!(context, stateValue!),
            const Padding(padding: EdgeInsets.only(left: 12)),
          ],
        ),
      ),
    );
  }

  /// Builds the vertical swipe interface.
  Widget getVertical() {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        updateData(details.localPosition.dy);
      },
      onVerticalDragEnd: (details) {
        if (widget.onFinish != null) {
          widget.onFinish!(stateValue!);
        }
      },
      onTapUp: (details) {
        updateData(details.localPosition.dy);
        if (widget.onFinish != null) {
          widget.onFinish!(stateValue!);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        color: Colors.black.withAlpha(0),
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [widget.color, widget.fillColor],
              stops: [
                1 - stateValue!,
                0,
              ],
            ),
            borderRadius: BorderRadiusDirectional.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.child == null ? Container() : widget.child!,
              widget.childBuilder == null
                  ? Container()
                  : widget.childBuilder!(context, stateValue!),
              const Padding(padding: EdgeInsets.only(bottom: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
