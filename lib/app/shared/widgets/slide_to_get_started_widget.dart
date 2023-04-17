import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_task/app/shared/helpers/color_constants.dart';

class SlideToGetStartedWidget extends StatefulWidget {
  final VoidCallback onConfirm;
  final Widget confirmWidget;

  const SlideToGetStartedWidget({Key key, this.onConfirm, this.confirmWidget})
      : super(key: key);

  @override
  _SlideToGetStartedWidgetState createState() =>
      _SlideToGetStartedWidgetState();
}

class _SlideToGetStartedWidgetState extends State<SlideToGetStartedWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  double maxSlide = 135;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    super.initState();
  }

  void toggle() =>
      _controller.isDismissed ? _controller.forward() : _controller.reverse();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onDragUpdate(DragUpdateDetails details) {
    double delta = details.primaryDelta / maxSlide;
    setState(() {
      _controller.value += delta;
    });
  }

  onDragEnd(DragEndDetails details) async {
    if (_controller.value < 0.95) {
      _controller.reverse();
    } else {
      _controller.forward();
      await Future.delayed(Duration(milliseconds: 200));
      setState(() {
        _controller.value = 1.0;
      });
      HapticFeedback.heavyImpact();

      widget.onConfirm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: 200,
        child: Row(
          children: [
            Stack(
              children: [
                Center(
                  child: Row(
                    children: [
                      Opacity(
                        opacity: 0,
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: blackColor,
                          ),
                        ),
                      ),
                      Text(
                        'Get started',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(maxSlide * _controller.value, 0),
                        child: child,
                      );
                    },
                    child: GestureDetector(
                      onHorizontalDragUpdate: onDragUpdate,
                      onHorizontalDragEnd: onDragEnd,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: _controller.value >= 1
                              ? blackColor.withOpacity(0.4)
                              : blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color:
              _controller.value >= 1 ? blackColor.withOpacity(0.4) : blackColor,
        ),
      ),
    );
  }
}
