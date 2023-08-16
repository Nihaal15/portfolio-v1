import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../utils/constants.dart';
import '../utils/glow_circle.dart';

class PageNotFound extends StatefulWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  State<PageNotFound> createState() => _PageNotFoundState();
}

class _PageNotFoundState extends State<PageNotFound>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  double xPosition = 0.0;
  double yPosition = 0.0;
  late AnimationController _animationController;
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  bool isHover = false;

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      xPosition = details.position.dx;
      yPosition = details.position.dy;
      _animationController.reset();
      _animationController.forward();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      body: Listener(
        onPointerMove: _updateLocation,
        onPointerHover: _updateLocation,
        child: CustomPaint(
          painter: GlowingCirclePainter(
            center: Offset(xPosition, yPosition),
          ),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                SvgPicture.asset(
                  'images/404.svg',
                  height: min(size.height * 0.5, size.width * 0.5),
                ),
                Text(
                  'Whoops!',
                  style: TextStyle(
                      fontSize: min(size.width * 0.05, size.height * 0.1),
                      color: const Color(0xFFd2dfff),
                      fontFamily: 'SFProMedium',
                      fontWeight:
                      FontWeight.bold,
                      letterSpacing: 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
