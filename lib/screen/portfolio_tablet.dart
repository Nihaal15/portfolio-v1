import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/components/mobile/mobile_experience_card.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:universal_html/html.dart' as html;

import '../components/desktop/desktop_header_content.dart';
import '../components/tablet/tablet_experience_card.dart';
import '../components/tablet/tablet_project_card.dart';
import '../utils/constants.dart';

class PortfolioTablet extends StatefulWidget {
  final double multiplierSize;

  const PortfolioTablet({
    super.key,
    required this.multiplierSize,
  });

  @override
  State<PortfolioTablet> createState() => _PortfolioTabletState();
}

class _PortfolioTabletState extends State<PortfolioTablet>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  bool gitHover = false;
  bool linkedinHover = false;
  bool isHover = false;
  bool isHoverProject = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = widget.multiplierSize;
    if (size.width >= 640 && size.width <= 1023) {
      double percentage = (size.width - 640) / (1023 - 640);
      width = 0.3 + percentage * (0.75 - 0.3);
    }
    width = width.clamp(0.3, 0.75);

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: [glowColor.withOpacity(0.25), Colors.transparent],
          center: Alignment.topLeft,
          radius: 0.5,
        )),
        child: FutureBuilder(
            future: loadData(),
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 47),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView.builder(
                      itemCount: 5,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return StickyHeader(
                            header: Container(),
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.06),
                                  child: Text(
                                    "NIHAAL SHIRKAR",
                                    style: TextStyle(
                                        fontSize:
                                            (widget.multiplierSize == 0.75)
                                                ? 48
                                                : 36,
                                        color: white,
                                        fontFamily: 'SFProMedium',
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 3),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "BACHELOR OF ENGINEERING (COMPUTER)",
                                    style: TextStyle(
                                        fontSize:
                                            (widget.multiplierSize == 0.75)
                                                ? 20
                                                : 16,
                                        color: white,
                                        fontFamily: 'SFProRegular',
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 2),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 24.0),
                                  child: SizedBox(
                                    width: 315,
                                    child: Text(
                                      "I enjoy creating Android apps that focus on the user, aiming to provide smooth and enjoyable digital experiences.",
                                      style: TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                          color: lightBlue,
                                          fontFamily: 'SFProRegular',
                                          fontWeight: FontWeight.normal,
                                          letterSpacing: 1.2),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 28),
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
                                            duration: const Duration(
                                                milliseconds: 200),
                                            opacity: gitHover ? 1 : 0.5,
                                            child: SvgPicture.asset(
                                              'assets/images/github.svg',
                                              colorFilter: ColorFilter.mode(
                                                white,
                                                BlendMode.srcIn,
                                              ),
                                              height: 26,
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
                                            duration: const Duration(
                                                milliseconds: 200),
                                            opacity: linkedinHover ? 1 : 0.5,
                                            child: SvgPicture.asset(
                                              'assets/images/linkedin.svg',
                                              colorFilter: ColorFilter.mode(
                                                white,
                                                BlendMode.srcIn,
                                              ),
                                              height: 26,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 120,
                                ),
                              ],
                            ),
                          );
                        } else if (index == 1) {
                          return StickyHeader(
                            header: const HeaderContent(text: "ABOUT"),
                            content: Padding(
                              padding:
                                  const EdgeInsets.only(top: 23.0, bottom: 95),
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('about')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const SizedBox.shrink();
                                  }
                                  if (!snapshot.hasData ||
                                      snapshot.data!.docs.isEmpty) {
                                    return const SizedBox.shrink();
                                  }
                                  final documents = snapshot.data!.docs;
                                  final paras = <Widget>[];
                                  for (final document in documents) {
                                    final content = document['para'];
                                    paras.add(
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 12.0),
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
                                    );
                                  }

                                  return Column(
                                    children: paras,
                                  );
                                },
                              ),
                            ),
                          );
                        } else if (index == 2) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 23.0, bottom: 95),
                            child: StickyHeader(
                              header: const HeaderContent(text: "EXPERIENCE"),
                              content: Padding(
                                padding: const EdgeInsets.only(top: 23.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('experience')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError) {
                                          return const SizedBox.shrink();
                                        }
                                        if (!snapshot.hasData ||
                                            snapshot.data!.docs.isEmpty) {
                                          return const SizedBox.shrink();
                                        }
                                        final documents = snapshot.data!.docs;
                                        final customCards = <Widget>[];
                                        for (final document in documents) {
                                          final company = document['company'];
                                          final title = document['title'];
                                          final description =
                                              document['description'];
                                          final tags = List<String>.from(
                                              document['tags']);
                                          final from = document['from'];
                                          final to = document['to'];
                                          final url = document['url'];
                                          customCards.add(
                                            (widget.multiplierSize == 0.75)
                                                ? TabletExperienceCard(
                                                    company: company,
                                                    title: title,
                                                    description: description,
                                                    tags: tags,
                                                    from: from,
                                                    to: to,
                                                    url: url,
                                                    width: width,
                                                  )
                                                : MobileExperienceCard(
                                                    company: company,
                                                    title: title,
                                                    description: description,
                                                    tags: tags,
                                                    from: from,
                                                    to: to,
                                                    url: url,
                                                    width: width),
                                          );
                                        }

                                        return Column(
                                          children: customCards,
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.01),
                                      child: MouseRegion(
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
                                            Navigator.of(context).pushNamed("/resume");
                                          },
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'View Full Résumé',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      shadows: [
                                                        Shadow(
                                                            color: white,
                                                            offset:
                                                                const Offset(
                                                                    0, -2.5))
                                                      ],
                                                      decoration: isHover
                                                          ? TextDecoration
                                                              .underline
                                                          : TextDecoration.none,
                                                      decorationColor: isHover
                                                          ? neonBlue
                                                          : Colors.transparent,
                                                      decorationThickness:
                                                          isHover ? 1.5 : 0.0,
                                                      color: Colors.transparent,
                                                      fontFamily: 'SFProMedium',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      letterSpacing: 1),
                                                ),
                                                WidgetSpan(
                                                  child: AnimatedPadding(
                                                    padding: EdgeInsets.only(
                                                        left: isHover
                                                            ? 14.56
                                                            : 7.84,
                                                        bottom: size.height *
                                                            0.001),
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    child: SvgPicture.asset(
                                                      'assets/images/arrow-right-solid.svg',
                                                      colorFilter:
                                                          ColorFilter.mode(
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
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else if (index == 3) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 23.0, bottom: 95),
                            child: StickyHeader(
                              header: const HeaderContent(text: "PROJECTS"),
                              content: Padding(
                                padding: const EdgeInsets.only(top: 23.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('projects')
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasError) {
                                          return const SizedBox.shrink();
                                        }
                                        if (!snapshot.hasData ||
                                            snapshot.data!.docs.isEmpty) {
                                          return const SizedBox.shrink();
                                        }
                                        final documents = snapshot.data!.docs;
                                        final customCards = <Widget>[];
                                        for (final document
                                            in documents.reversed) {
                                          final company = document['made at'];
                                          final title = document['project'];
                                          final description =
                                              document['description'];
                                          final tags = List<String>.from(
                                              document['tags']);
                                          final year = document['year'];
                                          final url = document['url'];

                                          customCards.add(
                                            TabletProjectCard(
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
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.01),
                                      child: MouseRegion(
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
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    "/archive");
                                          },
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'View Full Project Archive',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      shadows: [
                                                        Shadow(
                                                            color: white,
                                                            offset:
                                                                const Offset(
                                                                    0, -2.5))
                                                      ],
                                                      decoration: isHoverProject
                                                          ? TextDecoration
                                                              .underline
                                                          : TextDecoration.none,
                                                      decorationColor:
                                                          isHoverProject
                                                              ? neonBlue
                                                              : Colors
                                                                  .transparent,
                                                      decorationThickness:
                                                          isHoverProject
                                                              ? 1.5
                                                              : 0.0,
                                                      color: Colors.transparent,
                                                      fontFamily: 'SFProMedium',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      letterSpacing: 1),
                                                ),
                                                WidgetSpan(
                                                  child: AnimatedPadding(
                                                    padding: EdgeInsets.only(
                                                        left: isHoverProject
                                                            ? 14.56
                                                            : 7.84,
                                                        bottom: size.height *
                                                            0.001),
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    child: SvgPicture.asset(
                                                      'assets/images/arrow-right-solid.svg',
                                                      colorFilter:
                                                          ColorFilter.mode(
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
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else if (index == 4) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.075),
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
                                      html.window.open(
                                          "https://www.figma.com", "_blank");
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
                                      html.window.open(
                                          "https://developer.android.com/studio",
                                          "_blank");
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
                                      html.window.open(
                                          "https://flutter.dev/", "_blank");
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
                                      html.window.open(
                                          "https://firebase.google.com/",
                                          "_blank");
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
                                      html.window.open(
                                          "https://developer.apple.com/fonts/",
                                          "_blank");
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
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                ),
              );
            }),
      ),
    );
  }

  Future<void> loadData() async {
    try {
      final aboutSnapshot =
          await FirebaseFirestore.instance.collection('about').get();
      final experienceSnapshot =
          await FirebaseFirestore.instance.collection('experience').get();
      final projectsSnapshot =
          await FirebaseFirestore.instance.collection('projects').get();

      final aboutData = aboutSnapshot.docs.map((doc) => doc.data()).toList();
      final experienceData =
          experienceSnapshot.docs.map((doc) => doc.data()).toList();
      final projectsData =
          projectsSnapshot.docs.map((doc) => doc.data()).toList();
    } catch (_) {}
  }
}
