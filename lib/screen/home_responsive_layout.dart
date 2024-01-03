import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/loader.dart';
import '../utils/constants.dart';
import '../utils/dimension.dart';
import '../utils/glow_circle.dart';
import 'portfolio_desktop.dart';
import 'portfolio_tablet.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({super.key});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _animationController;
  double xPosition = 0.0;
  double yPosition = 0.0;

  double loading = 0;
  Timer? valueUpdateTimer;
  double i = 0;

  List<String> aboutData = [];
  List<Map<String, dynamic>> experienceData = [];
  List<Map<String, dynamic>> projectData = [];
  List<Map<String, dynamic>> contactData = [];

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
    getData();
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

  void startValueUpdateTimer() {
    valueUpdateTimer =
        Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (loading == 25 && i != 25) {
        setState(() {
          i++;
        });
      } else if (loading == 50 && i != 50) {
        setState(() {
          i++;
        });
      } else if (loading == 75 && i != 75) {
        setState(() {
          i++;
        });
      } else if (loading == 100 && i != 100) {
        setState(() {
          i++;
        });
      } else {
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 2500), () {
          setState(() {
            loading++;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (loading == 101)
        ? LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth <= maxMobileWidth) {
              return PortfolioTablet(
                multiplierSize: 0.3,
                aboutData: aboutData,
                experienceData: experienceData,
                projectData: projectData,
                contactData: contactData,
              );
            } else if (maxMobileWidth < constraints.maxWidth &&
                constraints.maxWidth <= maxLaptopWidth) {
              return PortfolioTablet(
                multiplierSize: 0.75,
                aboutData: aboutData,
                experienceData: experienceData,
                projectData: projectData,
                contactData: contactData,
              );
            } else if (maxLaptopWidth < constraints.maxWidth &&
                constraints.maxWidth <= maxLargeWidth) {
              return PortfolioDesktop(
                multiplierSize: 0.75,
                aboutData: aboutData,
                experienceData: experienceData,
                projectData: projectData,
                contactData: contactData,
              );
            } else {
              return PortfolioDesktop(
                multiplierSize: 1.0,
                aboutData: aboutData,
                experienceData: experienceData,
                projectData: projectData,
                contactData: contactData,
              );
            }
          })
        : Scaffold(
            backgroundColor: bgColor,
            body: Listener(
              onPointerMove: _updateLocation,
              onPointerHover: _updateLocation,
              child: CustomPaint(
                painter: GlowingCirclePainter(
                  center: Offset(xPosition, yPosition),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: BreatheAnimation()),
                  ],
                ),
              ),
            ),
          );
  }

  Future<void> getData() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    loading = 0;

    try {
      final querySnapshot = await db.collection('about').get();
      for (var docSnapshot in querySnapshot.docs) {
        aboutData.add(docSnapshot.data()['para']);
      }
      loading += 25;
      startValueUpdateTimer();
    } catch (_) {}

    try {
      final querySnapshot = await db.collection('experience').get();
      for (var docSnapshot in querySnapshot.docs) {
        experienceData.add(docSnapshot.data());
      }
      loading += 25;
    } catch (_) {}

    try {
      final querySnapshot = await db.collection('projects').get();
      for (var docSnapshot in querySnapshot.docs) {
        projectData.add(docSnapshot.data());
      }
      loading += 25;
    } catch (_) {}

    try {
      final querySnapshot = await db.collection('contact').get();
      for (var docSnapshot in querySnapshot.docs) {
        contactData.add({
          'para': docSnapshot.data()['para'],
          'mail': docSnapshot.data()['mail'],
        });
      }
      loading += 25;
    } catch (_) {}
  }
}
