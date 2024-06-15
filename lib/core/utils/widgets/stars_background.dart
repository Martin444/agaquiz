import 'package:agaquiz/core/colors/colors.dart';
import 'package:agaquiz/core/utils/widgets/bling_background.dart';
import 'package:flutter/material.dart';

class BackgroundStars extends StatefulWidget {
  const BackgroundStars({
    super.key,
  });

  @override
  State<BackgroundStars> createState() => _BackgroundStarsState();
}

class _BackgroundStarsState extends State<BackgroundStars>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(gradient: AqColors.backgroundColorLinear),
        ),
        CustomPaint(
          painter: StarPainter(animation: _controller!),
          child: Container(),
        )
      ],
    );
  }
}
