import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:universal_html/html.dart' as html;

import '../utils/constants.dart';

class Link extends StatefulWidget {
  final List tableHeaderWidth;
  final String url;
  final double multiplierSize;
  final int index;

  const Link(
      {super.key,
      required this.tableHeaderWidth,
      required this.url,
      required this.multiplierSize,
      required this.index});

  @override
  State<Link> createState() => _LinkState();
}

class _LinkState extends State<Link> {
  bool isHover = false;
  late String url;

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
    return SizedBox(
      width:
          widget.tableHeaderWidth[widget.index] * widget.multiplierSize * 0.9,
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
            if (widget.url != "") {
              html.window.open(widget.url, "_blank");
            }
          },
          onLongPressDown: (onLong) {
            setState(() {
              isHover = true;
            });
          },
          onLongPressUp: () {
            setState(() {
              isHover = false;
            });
          },
          child: linkWidget(),
        ),
      ),
    );
  }

  Widget linkWidget() {
    if (url == "github.com") {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "GitHub",
              style: TextStyle(
                  color: isHover ? neonBlue : white.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SFProRegular',
                  letterSpacing: 1.2),
            ),
            (url != "")
                ? WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7.84),
                      child: SvgPicture.asset(
                        'assets/images/github.svg',
                        colorFilter: ColorFilter.mode(
                          isHover ? neonBlue : white.withOpacity(0.9),
                          BlendMode.srcIn,
                        ),
                        height: 16,
                      ),
                    ),
                  )
                : WidgetSpan(child: Container()),
          ],
        ),
      );
    } else {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: (url == "") ? url : url.split("/")[2],
              style: TextStyle(
                  color: isHover ? neonBlue : white.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SFProRegular',
                  letterSpacing: 1.2),
            ),
            (url != "")
                ? WidgetSpan(
                    child: AnimatedPadding(
                      padding: EdgeInsets.only(left: isHover ? 12.32 : 7.84),
                      duration: const Duration(milliseconds: 300),
                      child: SvgPicture.asset(
                        'assets/images/angle-right-solid.svg',
                        colorFilter: ColorFilter.mode(
                          isHover ? neonBlue : white,
                          BlendMode.srcIn,
                        ),
                        height: 15,
                      ),
                    ),
                  )
                : WidgetSpan(child: Container()),
          ],
        ),
      );
    }
  }
}
