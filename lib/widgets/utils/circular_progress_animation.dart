import 'dart:async';

import 'package:agaquiz/core/colors/colors.dart';
import 'package:agaquiz/core/utils/styles/font_style.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  final Duration animationDuration;

  final Function onFinished;

  const CustomCircularProgressIndicator({
    super.key,
    required this.animationDuration,
    required this.onFinished,
  });

  @override
  _CustomCircularProgressIndicatorState createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Color?>? _colorAnimation;
  int _countdownController = 0;
  Timer? contDownTimer;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _controller = AnimationController(
        vsync: this,
        value: 1.0,
        duration: widget.animationDuration,
      )..repeat();

      _colorAnimation = ColorTween(
        begin: AqColors.bg_active_success, // Cambia el color inicial aquí
        end: AqColors.bg_active_error, // Cambia el color final aquí
      ).animate(_controller!);

      _countdownController = widget.animationDuration.inSeconds;
      setState(() {});
      startCountdown();
    });
  }

  void startCountdown() {
    contDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _countdownController = _countdownController - 1;
      setState(() {});
      if (_countdownController == 0) {
        _countdownController = widget.animationDuration.inSeconds;
        widget.onFinished();
        _controller!.reset();
        _controller!.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    contDownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (context) {
              return ElasticIn(
                child: Text(
                  '$_countdownController',
                  style: AqTextStyle.primaryTextStyle,
                ),
              );
            },
          ),
        ),
        _controller != null
            ? SizedBox(
                height: 130,
                width: 130,
                child: CircularProgressIndicator(
                  value: _controller?.value,
                  strokeWidth: 18.0,
                  valueColor: _colorAnimation,
                  strokeCap: StrokeCap.round,
                  // Customize other properties as needed
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
