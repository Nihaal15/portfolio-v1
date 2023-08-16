import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/utils/constants.dart';

class DesktopTableHeaderContent extends StatelessWidget {
  final double multiplierSize;
  DesktopTableHeaderContent({super.key, required this.multiplierSize});

  final List<String> tableHeaderList = [
    "Year",
    "Project",
    "Made at",
    "Built with",
    "Link"
  ];
  final List<double> tableHeaderWidth = [64.13, 271.05, 143.27, 368.03, 241.53];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return BlurryContainer(
      blur: 50,
      width: size.width,
      elevation: 0,
      color: bgColor.withOpacity(0.1),
      padding: const EdgeInsets.all(0),
      borderRadius: const BorderRadius.all(Radius.circular(0)),
      child: SizedBox(width: double.infinity, height: 52.5, child: headers(),),);
  }
  Widget headers() {
    final heading = <Widget>[];
    for (int i = 0; i < tableHeaderList.length; i++) {
      heading.add(
        SizedBox(
          width: tableHeaderWidth[i] * multiplierSize * 0.9,
          child: Text(
            tableHeaderList[i],
            style: TextStyle(
                fontSize: 14,
                color: white,
                fontFamily: 'SFProMedium',
                letterSpacing: 1.2),
          ),
        ),
      );
    }
    return Row(
      children: heading,
    );
  }
}
