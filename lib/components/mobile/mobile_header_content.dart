import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class MobileTableHeaderContent extends StatefulWidget {
  const MobileTableHeaderContent({super.key});

  @override
  State<MobileTableHeaderContent> createState() => _MobileTableHeaderContentState();
}

class _MobileTableHeaderContentState extends State<MobileTableHeaderContent> {
  final List<String> tableHeaderList = [
    "Year",
    "Project",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return BlurryContainer(
      blur: 50,
      width: size.width,
      elevation: 0,
      color: bgColor.withOpacity(0.5),
      padding: const EdgeInsets.all(0),
      borderRadius: const BorderRadius.all(Radius.circular(0)),
      child: SizedBox(width: double.infinity, height: 52.5, child: headers(size),),);
  }

  Widget headers(size) {
    return Row(
      children: [
        Container(
          width: size.width * 0.15,
          constraints: const BoxConstraints(
            minWidth: 40
          ),
          child: Text(
            "Year",
            style: TextStyle(
                fontSize: 14,
                color: white,
                fontFamily: 'SFProMedium',
                letterSpacing: 1.2),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            "Project",
            style: TextStyle(
                fontSize: 14,
                color: white,
                fontFamily: 'SFProMedium',
                letterSpacing: 1.2),
          ),
        ),
      ],
    );
  }
}
