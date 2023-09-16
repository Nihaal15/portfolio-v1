import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:universal_html/html.dart' as html;

import '../../utils/constants.dart';

class TabletProjectCard extends StatefulWidget {
  final String company;
  final String title;
  final String description;
  final List<dynamic> tags;
  final String year;
  final String url;
  final double width;

  const TabletProjectCard(
      {super.key,
      required this.company,
      required this.title,
      required this.description,
      required this.tags,
      required this.year,
      required this.url,
      required this.width});

  @override
  State<TabletProjectCard> createState() => _TabletProjectCardState();
}

class _TabletProjectCardState extends State<TabletProjectCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                if (widget.url != "") {
                  html.window.open(widget.url, "_blank");
                }
              },
              onLongPressDown: (LongPressDownDetails data) {
                setState(() {
                  isHover = true;
                });
              },
              onLongPressUp: () {
                setState(() {
                  isHover = false;
                });
              },
              onLongPressCancel: () {
                setState(() {
                  isHover = false;
                });
              },
              child: SizedBox(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: widget.title,
                        style: TextStyle(
                            color: isHover ? neonBlue : white,
                            fontSize: 15 +
                                (widget.width - 0.3) * (16 - 15) / (0.75 - 0.3),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SFProMedium'),
                      ),
                      (widget.url != "")
                          ? WidgetSpan(
                              child: AnimatedPadding(
                                padding: EdgeInsets.only(
                                    left: isHover ? 12.32 : 7.84),
                                duration: const Duration(milliseconds: 300),
                                child: SvgPicture.asset(
                                  'assets/images/angle-right-solid.svg',
                                  colorFilter: ColorFilter.mode(
                                    isHover ? neonBlue : white,
                                    BlendMode.srcIn,
                                  ),
                                  height: 17.92,
                                ),
                              ),
                            )
                          : const WidgetSpan(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                widget.description,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: widget.tags.map((text) {
                return ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    enabledMouseCursor: SystemMouseCursors.basic,
                    surfaceTintColor: Colors.transparent,
                    disabledBackgroundColor: const Color(0xFF122b39),
                    disabledForegroundColor: neonBlue,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'SFProRegular',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
