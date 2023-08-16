import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:universal_html/html.dart' as html;


import '../components/desktop/desktop_experience_card.dart';
import '../components/desktop/desktop_project_card.dart';
import '../components/nav_button.dart';
import '../utils/constants.dart';
import '../utils/dimension.dart';
import '../utils/glow_circle.dart';

class PortfolioDesktop extends StatefulWidget {
  final double multiplierSize;

  const PortfolioDesktop({super.key, required this.multiplierSize});

  @override
  State<PortfolioDesktop> createState() => _PortfolioDesktopState();
}

class _PortfolioDesktopState extends State<PortfolioDesktop>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  double xPosition = 0.0;
  double yPosition = 0.0;
  late AnimationController _animationController;
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  late int activeIndex = 0;

  List<String> buttonTitles = ['ABOUT', 'EXPERIENCE', 'PROJECTS'];
  late List<Widget> sectionContent;
  bool isHover = false;
  bool isHoverProject = false;
  bool gitHover = false;
  bool linkedinHover = false;
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
    itemPositionsListener.itemPositions.addListener(() {
      final indices = itemPositionsListener.itemPositions.value
          .where((item) {
            final isTopVisible = item.itemLeadingEdge >= 0;
            final isBottomVisible = item.itemTrailingEdge <= 2;

            return isTopVisible && isBottomVisible;
          })
          .map((item) => item.index)
          .toList();
      if (indices.isNotEmpty) {
        setState(() {
          activeIndex = indices[0];
        });
      }
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
    setState(() {
      sectionContent = [
        about(size),
        experience(size, width),
        projects(size, width)
      ];
    });

    return Scaffold(
      backgroundColor: bgColor,
      body: Listener(
        onPointerMove: _updateLocation,
        onPointerHover: _updateLocation,
        child: CustomPaint(
          painter: GlowingCirclePainter(
            center: Offset(xPosition, yPosition),
          ),
          child: FutureBuilder(
              future: loadData(),
              builder: (context, snapshot) {
                return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 510 * width,
                    height: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.06),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "NIHAAL SHIRKAR",
                            style: TextStyle(
                                fontSize: 40,
                                color: white,
                                fontFamily: 'SFProBold',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 3),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "BACHELOR OF ENGINEERING (COMPUTER)",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: white,
                                  fontFamily: 'SFProMedium',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              width: 537.6,
                              child: Text(
                                "I enjoy creating Android apps that focus on the user, aiming to provide smooth and enjoyable digital experiences.",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: lightBlue,
                                    fontFamily: 'SFProMedium',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.05),
                            child: SizedBox(
                              height: size.height * 0.25,
                              child: ListView.builder(
                                itemCount: buttonTitles.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding:
                                          EdgeInsets.only(top: size.height * 0.02),
                                      child: HoverButton(
                                        title: buttonTitles[index],
                                        onTap: () {
                                          _scrollToSection(index);
                                        },
                                        isActive: _isActive(index),
                                      ));
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        html.window.open(
                                            'https://github.com/Nihaal15',
                                            "_blank");
                                      },
                                      child: MouseRegion(
                                        onEnter: (PointerEnterEvent data) {
                                          setState(() {
                                            gitHover = true;
                                          });
                                        },
                                        onExit: (PointerExitEvent data) {
                                          setState(() {
                                            gitHover = false;
                                          });
                                        },
                                        opaque: false,
                                        child: AnimatedOpacity(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          opacity: gitHover ? 1 : 0.5,
                                          child: SvgPicture.asset(
                                            'assets/images/github.svg',
                                            colorFilter: ColorFilter.mode(
                                              white,
                                              BlendMode.srcIn,
                                            ),
                                            height: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    InkWell(
                                      onTap: () {
                                        html.window.open(
                                            'https://www.linkedin.com/in/nihaalshirkar15/',
                                            "_blank");
                                      },
                                      child: MouseRegion(
                                        onEnter: (PointerEnterEvent data) {
                                          setState(() {
                                            linkedinHover = true;
                                          });
                                        },
                                        onExit: (PointerExitEvent data) {
                                          setState(() {
                                            linkedinHover = false;
                                          });
                                        },
                                        opaque: false,
                                        child: AnimatedOpacity(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          opacity: linkedinHover ? 1 : 0.5,
                                          child: SvgPicture.asset(
                                            'assets/images/linkedin.svg',
                                            colorFilter: ColorFilter.mode(
                                              white,
                                              BlendMode.srcIn,
                                            ),
                                            height: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * width * 0.03),
                  SizedBox(
                    height: double.infinity,
                    width: 590 * width,
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.06),
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: ScrollablePositionedList.builder(
                          itemScrollController: _scrollController,
                          itemPositionsListener: itemPositionsListener,
                          itemCount: buttonTitles.length,
                          itemBuilder: (context, index) => item(index),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width: size.width * 0.253,)
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  void _scrollToSection(int index) {
    _scrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 250),
    );
  }

  _isActive(int index) {
    return index == activeIndex;
  }

  Widget item(int index) {
    return sectionContent[index];
  }

  Widget about(Size size) {
    final Stream<QuerySnapshot> aboutStream =
        FirebaseFirestore.instance.collection('about').snapshots();

    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: aboutStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const SizedBox.shrink();
            }
            final documents = snapshot.data!.docs;
            final paras = <Widget>[];
            for (final document in documents) {
              final content = document['para'];
              paras.add(
                SizedBox(
                  width: 499.52,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      content,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.75,
                          color: lightBlue,
                          fontFamily: 'SFProRegular',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              );
            }

            return Column(
              children: paras,
            );
          },
        ),
        SizedBox(
          height: size.height * 0.1,
        ),
      ],
    );
  }

  Widget experience(Size size, double width) {
    final Stream<QuerySnapshot> experienceStream =
        FirebaseFirestore.instance.collection('experience').snapshots();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: experienceStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data!.docs.isEmpty) {
              return const SizedBox.shrink();
            }

            final documents = snapshot.data!.docs;
            final customCards = <Widget>[];
            for (final document in documents) {
              final company = document['company'];
              final title = document['title'];
              final description = document['description'];
              final tags = List<String>.from(document['tags']);
              final from = document['from'];
              final to = document['to'];
              final url = document['url'];

              customCards.add(
                DesktopExperienceCard(
                  company: company,
                  title: title,
                  description: description,
                  tags: tags,
                  from: from,
                  to: to,
                  url: url,
                  width: width,
                ),
              );
            }

            return Column(
              children: customCards,
            );
          },
        ),
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
          child: Padding(
            padding: EdgeInsets.only(left: 33.6, top: size.height * 0.01),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/resume");
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'View Full Résumé',
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.75,
                          shadows: [
                            Shadow(color: white, offset: const Offset(0, -2.5))
                          ],
                          decoration: isHover
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationColor:
                              isHover ? neonBlue : Colors.transparent,
                          decorationThickness: isHover ? 1.5 : 0.0,
                          color: Colors.transparent,
                          fontFamily: 'SFProMedium',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1),
                    ),
                    WidgetSpan(
                      child: AnimatedPadding(
                        padding: EdgeInsets.only(
                            left: isHover ? 14.56 : 7.84,
                            bottom: size.height * 0.001),
                        duration: const Duration(milliseconds: 200),
                        child: SvgPicture.asset(
                          'assets/images/arrow-right-solid.svg',
                          colorFilter: ColorFilter.mode(
                            white,
                            BlendMode.srcIn,
                          ),
                          height: 17.92,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.1,
        ),
      ],
    );
  }

  Widget projects(Size size, double width) {
    final Stream<QuerySnapshot> projectStream =
        FirebaseFirestore.instance.collection('projects').snapshots();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: projectStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data!.docs.isEmpty) {
              return const SizedBox.shrink();
            }

            final documents = snapshot.data!.docs;
            final customCards = <Widget>[];
            for (final document in documents.reversed) {
              final company = document['made at'];
              final title = document['project'];
              final description = document['description'];
              final tags = List<String>.from(document['tags']);
              final year = document['year'];
              final url = document['url'];

              customCards.add(
                DesktopProjectCard(
                  company: company,
                  title: title,
                  description: description,
                  tags: tags,
                  year: year,
                  url: url,
                  width: width,
                ),
              );
            }
            return Column(
              children: customCards,
            );
          },
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          opaque: false,
          onEnter: (event) {
            setState(() {
              isHoverProject = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHoverProject = false;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(left: 33.6, top: size.height * 0.01),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/archive");
              },
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'View Full Project Archive',
                      style: TextStyle(
                          fontSize: 16,
                          height: 1.75,
                          shadows: [
                            Shadow(color: white, offset: const Offset(0, -2.5))
                          ],
                          decoration: isHoverProject
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          decorationColor:
                              isHoverProject ? neonBlue : Colors.transparent,
                          decorationThickness: isHoverProject ? 1.5 : 0.0,
                          color: Colors.transparent,
                          fontFamily: 'SFProMedium',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1),
                    ),
                    WidgetSpan(
                      child: AnimatedPadding(
                        padding: EdgeInsets.only(
                            left: isHoverProject ? 14.56 : 7.84,
                            bottom: size.height * 0.001),
                        duration: const Duration(milliseconds: 200),
                        child: SvgPicture.asset(
                          'assets/images/arrow-right-solid.svg',
                          colorFilter: ColorFilter.mode(
                            white,
                            BlendMode.srcIn,
                          ),
                          height: 17.92,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.075),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Designed in ',
                style: TextStyle(
                    fontSize: 14,
                    color: white.withOpacity(0.5),
                    fontFamily: 'SFProRegular',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2),
              ),
              TextSpan(
                text: 'Figma',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    html.window.open("https://www.figma.com", "_blank");
                  },
                style: TextStyle(
                    fontSize: 14,
                    color: white,
                    fontFamily: 'SFProRegular',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2),
              ),
              TextSpan(
                text: ' and coded in ',
                style: TextStyle(
                    fontSize: 14,
                    color: white.withOpacity(0.5),
                    fontFamily: 'SFProRegular',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2),
              ),
              TextSpan(
                text: 'Android Studio',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    html.window
                        .open("https://developer.android.com/studio", "_blank");
                  },
                style: TextStyle(
                    fontSize: 14,
                    color: white,
                    fontFamily: 'SFProRegular',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2),
              ),
              TextSpan(
                text: ' by yours truly. Built with ',
                style: TextStyle(
                    fontSize: 14,
                    color: white.withOpacity(0.5),
                    fontFamily: 'SFProRegular',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2),
              ),
              TextSpan(
                text: 'Flutter',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    html.window.open("https://flutter.dev/", "_blank");
                  },
                style: TextStyle(
                    fontSize: 14,
                    color: white,
                    fontFamily: 'SFProRegular',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2),
              ),
              TextSpan(
                text: ', deployed with ',
                style: TextStyle(
                    fontSize: 14,
                    color: white.withOpacity(0.5),
                    fontFamily: 'SFProRegular',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2),
              ),
              TextSpan(
                text: 'Firebase',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    html.window.open("https://firebase.google.com/", "_blank");
                  },
                style: TextStyle(
                    fontSize: 14,
                    color: white,
                    fontFamily: 'SFProRegular',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2),
              ),
              TextSpan(
                text: '. All text is set in the ',
                style: TextStyle(
                    fontSize: 14,
                    color: white.withOpacity(0.5),
                    fontFamily: 'SFProRegular',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2),
              ),
              TextSpan(
                text: 'SF Pro',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    html.window
                        .open("https://developer.apple.com/fonts/", "_blank");
                  },
                style: TextStyle(
                    fontSize: 14,
                    color: white,
                    fontFamily: 'SFProRegular',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2),
              ),
              TextSpan(
                text: ' typeface.',
                style: TextStyle(
                    fontSize: 14,
                    color: white.withOpacity(0.5),
                    fontFamily: 'SFProRegular',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2),
              ),
            ]),
          ),
        )
      ],
    );
  }

  Future<void> loadData() async {
    try {
      final aboutSnapshot = await FirebaseFirestore.instance.collection('about').get();
      final experienceSnapshot = await FirebaseFirestore.instance.collection('experience').get();
      final projectsSnapshot = await FirebaseFirestore.instance.collection('projects').get();

      final aboutData = aboutSnapshot.docs.map((doc) => doc.data()).toList();
      final experienceData = experienceSnapshot.docs.map((doc) => doc.data()).toList();
      final projectsData = projectsSnapshot.docs.map((doc) => doc.data()).toList();

    } catch (_) {}
  }
}
