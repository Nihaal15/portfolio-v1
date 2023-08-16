import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'hover_line.dart';

class HoverButton extends StatefulWidget {
  final String title;
  final void Function() onTap;
  final bool isActive;

  const HoverButton(
      {super.key,
      required this.title,
      required this.onTap,
      required this.isActive});

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      onHover: (value) {
        setState(
          () {
            isHovered = value;
          },
        );
      },
      child: Row(
        children: [
          HoverLine(
            isHovered: isHovered,
            color: Color.lerp(white, white.withOpacity(0.5),
                (isHovered || widget.isActive) ? 0.0 : 1.0)!,
            isActive: widget.isActive,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              widget.title,
              style: TextStyle(
                  fontSize: 12,
                  color: Color.lerp(white, white.withOpacity(0.5),
                      (isHovered || widget.isActive) ? 0.0 : 1.0),
                  fontFamily: 'SFProMedium',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2),
            ),
          ),
        ],
      ),
    );
  }
}
