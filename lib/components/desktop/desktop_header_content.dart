import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class HeaderContent extends StatelessWidget {
  final String text;

  const HeaderContent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlurryContainer(
      blur: 5,
      width: size.width,
      elevation: 0,
      color: bgColor.withOpacity(0.1),
      padding: const EdgeInsets.all(0),
      borderRadius: const BorderRadius.all(Radius.circular(0)),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16,
                color: white,
                fontFamily: 'SFProMedium',
                letterSpacing: 1.2),
          ),
        ),
      ),
    );
  }
}
