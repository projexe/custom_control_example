import 'package:flutter/material.dart';

import 'circle_painter.dart';

class PulsingButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final IconData icon;

  const PulsingButton({required this.onPressed, required this.icon});

  @override
  State<StatefulWidget> createState() => _PulsingButtonState();
}

class _PulsingButtonState extends State<PulsingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _btnAnimController;
  late CurvedAnimation _btnAnim;

  @override
  void initState() {
    super.initState();
    _btnAnimController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2500))
          ..repeat();
    _btnAnim =
        CurvedAnimation(curve: Curves.linear, parent: _btnAnimController);
  }

  @override
  void dispose() {
    _btnAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        FadeTransition(
          opacity: Tween<double>(begin: .7, end: 0).animate(_btnAnim),
          child: ScaleTransition(
            scale: Tween<double>(begin: .5, end: 1).animate(_btnAnim),
            child: CustomPaint(
              painter: CirclePainter(
                radius: 150,
                color: Color(0xff7f8384
                ),
              ),
              //Add a sizedbox child to the CustomPaint, to give the button more hit area
              child: SizedBox(
                width: 10,
                height: 10,
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _btnAnimController,
          builder: (BuildContext context, Widget? child) {
            double opacity =
                Tween<double>(begin: .7, end: .9).transform(_btnAnim.value);
            return MaterialButton(
              height: 200,
              minWidth: 150,
              splashColor: Color(0xff1d1f1f
              ),
              hoverColor: Color(0xff65696c
              ),
              color: Color(0xff676a6a
              ).withOpacity(opacity),
              textColor: Colors.white,
              child: Text('Searching ...'), //Icon(widget.icon),
              shape: CircleBorder(),
              onPressed: widget.onPressed,
            );
          },
        )
      ],
    );
  }
}
