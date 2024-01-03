import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:universal_html/html.dart' as html;

import '../utils/constants.dart';

class Link extends StatefulWidget {
  final List tableHeaderWidth;
  final String url;
  final String github;
  final double multiplierSize;
  final int index;

  const Link(
      {super.key,
      required this.tableHeaderWidth,
      required this.url,
      required this.github,
      required this.multiplierSize,
      required this.index});

  @override
  State<Link> createState() => _LinkState();
}

class _LinkState extends State<Link> {
  bool isHoverGithub = false;
  bool isHoverLink = false;
  late String url;
  late String github;

  @override
  Widget build(BuildContext context) {
    if (widget.url != "") {
      setState(() {
        url = widget.url.split("/")[2];
      });
    } else {
      setState(() {
        url = "";
      });
    }
    if (widget.github != "") {
      setState(() {
        github = widget.github.split("/")[2];
      });
    } else {
      setState(() {
        github = "";
      });
    }
    return SizedBox(
      width:
          widget.tableHeaderWidth[widget.index] * widget.multiplierSize * 0.9,
      child: Row(
        children: [
          githubLink(),
          const SizedBox(
            width: 10,
          ),
          linkWidget(),
        ],
      ),
    );
  }

  Widget linkWidget() {
    if (url != "") {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        opaque: false,
        onEnter: (event) {
          setState(() {
            isHoverLink = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHoverLink = false;
          });
        },
        child: GestureDetector(
          onTap: () {
            if (widget.url != "") {
              html.window.open(widget.url, "_blank");
            }
          },
          onLongPressDown: (onLong) {
            setState(() {
              isHoverLink = true;
            });
          },
          onLongPressUp: () {
            setState(() {
              isHoverLink = false;
            });
          },
          child: Text.rich(
            TextSpan(
              children: [
                (url != "")
                    ? WidgetSpan(
                        child: AnimatedPadding(
                          padding: const EdgeInsets.only(left: 7.84),
                          duration: const Duration(milliseconds: 300),
                          child: SvgPicture.asset(
                            'assets/images/link-solid.svg',
                            colorFilter: ColorFilter.mode(
                              isHoverLink ? neonBlue : white,
                              BlendMode.srcIn,
                            ),
                            height: 15,
                          ),
                        ),
                      )
                    : WidgetSpan(child: Container()),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget githubLink() {
    if (github != "") {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        opaque: false,
        onEnter: (event) {
          setState(() {
            isHoverGithub = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHoverGithub = false;
          });
        },
        child: GestureDetector(
          onTap: () {
            if (widget.github != "") {
              html.window.open(widget.github, "_blank");
            }
          },
          onLongPressDown: (onLong) {
            setState(() {
              isHoverGithub = true;
            });
          },
          onLongPressUp: () {
            setState(() {
              isHoverGithub = false;
            });
          },
          child: Text.rich(
            TextSpan(
              children: [
                (github != "")
                    ? WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 7.84),
                          child: SvgPicture.asset(
                            'assets/images/github.svg',
                            colorFilter: ColorFilter.mode(
                              isHoverGithub ? neonBlue : white.withOpacity(0.9),
                              BlendMode.srcIn,
                            ),
                            height: 16,
                          ),
                        ),
                      )
                    : WidgetSpan(child: Container()),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
