import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../components/desktop/desktop_table_data_content.dart';
import '../components/tablet/table_header.dart';
import '../utils/constants.dart';
import '../utils/dimension.dart';
import '../utils/glow_circle.dart';

class ArchiveDesktop extends StatefulWidget {
  final double multiplierSize;

  const ArchiveDesktop({Key? key, required this.multiplierSize})
      : super(key: key);

  @override
  State<ArchiveDesktop> createState() => _ArchiveDesktopState();
}

class _ArchiveDesktopState extends State<ArchiveDesktop>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  double xPosition = 0.0;
  double yPosition = 0.0;
  late AnimationController _animationController;
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  bool isHover = false;
  late double multiplierSize;

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
    setState(() {
      multiplierSize = widget.multiplierSize;
    });
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
    double width = widget.multiplierSize;
    if (size.width > maxLaptopWidth && size.width < maxLargeWidth) {
      setState(() {
        width = 0.75 +
            (size.width - maxLaptopWidth) *
                (1 - 0.75) /
                (maxLargeWidth - maxLaptopWidth);
      });
    }

    width = width.clamp(0.75, 1.0);

    return Scaffold(
      backgroundColor: bgColor,
      body: Listener(
        onPointerMove: _updateLocation,
        onPointerHover: _updateLocation,
        child: CustomPaint(
          painter: GlowingCirclePainter(
            center: Offset(xPosition, yPosition),
          ),
          child: FutureBuilder(builder: (context, snapshot) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 1155 * width,
                  height: double.infinity,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: ScrollablePositionedList.builder(
                      itemCount: 2,
                      itemScrollController: _scrollController,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return StickyHeader(
                            header: const SizedBox.shrink(),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 90),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        opaque: false,
                                        onEnter: (event) {
                                          setState(() {
                                            isHover = true;
                                          });
                                        },
                                        onExit: (event) {
                                          setState(() {
                                            isHover = false;
                                          });
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushReplacementNamed("/");
                                          },
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: SizedBox(
                                                      width: 40,
                                                      child: AnimatedPadding(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    100),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: isHover
                                                                    ? 0
                                                                    : 15),
                                                        child: SvgPicture.asset(
                                                          'assets/images/angle-left-solid.svg',
                                                          colorFilter:
                                                              ColorFilter.mode(
                                                            neonBlue,
                                                            BlendMode.srcIn,
                                                          ),
                                                          height: 15.68,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                WidgetSpan(
                                                  child: SizedBox(
                                                    height: 15.68,
                                                    child: Text(
                                                      'NIHAAL SHIRKAR',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: neonBlue,
                                                          fontFamily:
                                                              'SFProBold',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          letterSpacing: 1.2),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, top: 8, bottom: 48),
                                  child: Text(
                                    'All Projects',
                                    style: TextStyle(
                                        fontSize: 46,
                                        color: white,
                                        fontFamily: 'SFProMedium',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.2),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: StickyHeader(
                              header: Padding(
                                padding: const EdgeInsets.only(bottom: 1.0),
                                child: DesktopTableHeaderContent(
                                    multiplierSize: width),
                              ),
                              content: DesktopTableData(multiplierSize: width),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
