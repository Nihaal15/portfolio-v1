import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:universal_html/html.dart' as html;

import '../utils/constants.dart';

class TitleLink extends StatefulWidget {
  final String url;
  final String title;
  const TitleLink({super.key, required this.url, required this.title});

  @override
  State<TitleLink> createState() => _TitleLinkState();
}

class _TitleLinkState extends State<TitleLink> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: (widget.url != "") ? SystemMouseCursors.click : SystemMouseCursors.basic,
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
        onLongPressDown: (onLong){
          setState(() {
            isHover = true;
          });
        },
        onLongPressUp: (){
          setState(() {
            isHover = false;
          });
        },
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: widget.title,
                style: TextStyle(
                    color: (isHover && (widget.url != "")) ? neonBlue : white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SFProMedium',
                    letterSpacing: 1.2),
              ),
              (widget.url != "")
                  ? WidgetSpan(
                child: AnimatedPadding(
                  padding:
                  EdgeInsets.only(left: isHover ? 12.32 : 7.84),
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
                  : const WidgetSpan(child: SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
