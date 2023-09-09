import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class TabletTableHeaderContent extends StatefulWidget {
  const TabletTableHeaderContent({super.key});

  @override
  State<TabletTableHeaderContent> createState() =>
      _TabletTableHeaderContentState();
}

class _TabletTableHeaderContentState extends State<TabletTableHeaderContent> {
  final List<String> tableHeaderList = ["Year", "Project", "Link"];
  final List<double> tableHeaderWidth = [85, 500.66, 324.34];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlurryContainer(
      blur: 50,
      width: size.width,
      elevation: 0,
      color: bgColor.withOpacity(0.5),
      padding: const EdgeInsets.all(0),
      borderRadius: const BorderRadius.all(Radius.circular(0)),
      child: SizedBox(
        width: double.infinity,
        height: 52.5,
        child: headers(size),
      ),
    );
  }

  Widget headers(size) {
    final heading = <Widget>[];
    for (int i = 0; i < tableHeaderList.length; i++) {
      heading.add(
        SizedBox(
          width: tableHeaderWidth[i] * size.width * 0.0009,
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
