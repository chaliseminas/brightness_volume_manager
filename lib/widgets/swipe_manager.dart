import 'package:flutter/material.dart';

enum SlideDirection { vertical, horizontal }

typedef ChangeCallback = void Function(double newValue, double oldValue);
typedef FinishCallback = void Function(double value);
typedef ChildBuilder = Widget Function(BuildContext context, double value);

class SwipeManager extends StatefulWidget {
  final double initialValue;
  final ChangeCallback? onChange;
  final FinishCallback? onFinish;
  final SlideDirection direction;
  final double height;
  final double width;
  final Color color;
  final Color fillColor;
  final ChildBuilder? childBuilder;
  final Widget? child;

  const SwipeManager(
      {super.key,
        this.initialValue = 1.0,
        this.onChange,
        this.onFinish,
        this.direction = SlideDirection.vertical,
        this.color = const Color.fromRGBO(46, 45, 36, 0.5),
        this.fillColor = Colors.white,
        this.child,
        this.childBuilder,
        this.width = 20,
        this.height = 200});

  @override
  State<SwipeManager> createState() => _SwipeManagerState();
}

class _SwipeManagerState extends State<SwipeManager> {
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

  double getMainAxisSize() {
    return widget.direction == SlideDirection.horizontal
        ? widget.width
        : widget.height;
  }

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
        color: Colors.black.withOpacity(0),
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    widget.color,
                    widget.fillColor
                  ],
                  stops: [
                    1 - stateValue!,
                    0,
                  ]),
              borderRadius: BorderRadiusDirectional.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.child == null ? Container() : widget.child!,
              widget.childBuilder == null
                  ? Container()
                  : widget.childBuilder!(context, stateValue!),
              const Padding(padding: EdgeInsets.only(bottom: 12))
            ],
          ),
        ),
      ),
    );
  }
}
