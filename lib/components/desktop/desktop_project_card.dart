import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:universal_html/html.dart' as html;

import '../../utils/constants.dart';

class DesktopProjectCard extends StatefulWidget {
  final String company;
  final String title;
  final String description;
  final List<dynamic> tags;
  final String year;
  final String url;
  final String github;
  final double width;

  const DesktopProjectCard({
    Key? key,
    required this.company,
    required this.title,
    required this.description,
    required this.tags,
    required this.year,
    required this.url,
    required this.github,
    required this.width,
  }) : super(key: key);

  @override
  State<DesktopProjectCard> createState() => _DesktopProjectCardState();
}

class _DesktopProjectCardState extends State<DesktopProjectCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final color = Color.lerp(
        shadowColor.withOpacity(0.3), Colors.transparent, isHover ? 0.0 : 1.0);
    final shadow = Color.lerp(
        bgColor.withOpacity(0.3), Colors.transparent, isHover ? 0.0 : 1.0);
    final surface = Color.lerp(
        white.withOpacity(0.1), Colors.transparent, isHover ? 0.0 : 1.0);
    final elevation = isHover ? 4.0 : 0.0;

    return MouseRegion(
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
          } else {
            null;
          }
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Card(
            elevation: elevation,
            color: color,
            shadowColor: surface,
            surfaceTintColor: shadow,
            child: SizedBox(
              width: 672 * widget.width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                    horizontal: 33.6 * widget.width),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: widget.title,
                            style: TextStyle(
                                color: isHover ? neonBlue : white,
                                fontSize: 15 +
                                    (widget.width - 0.75) *
                                        (16 - 15) /
                                        (1 - 0.75),
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
                              : WidgetSpan(child: Container()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: SizedBox(
                        width: 497.28 * widget.width,
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
                      child: SizedBox(
                        width: 448 * widget.width,
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: widget.tags.map((text) {
                            return ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                enabledMouseCursor: SystemMouseCursors.basic,
                                surfaceTintColor: Colors.transparent,
                                disabledBackgroundColor:
                                    const Color(0xFF122b39),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
