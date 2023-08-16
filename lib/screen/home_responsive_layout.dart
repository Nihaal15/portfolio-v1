import 'package:flutter/material.dart';

import '../utils/dimension.dart';
import 'portfolio_desktop.dart';
import 'portfolio_tablet.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({super.key});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= maxMobileWidth) {
        return const PortfolioTablet(
          multiplierSize: 0.3,
        );
      } else if (maxMobileWidth < constraints.maxWidth &&
          constraints.maxWidth <= maxLaptopWidth) {
        return const PortfolioTablet(
          multiplierSize: 0.75,
        );
      } else if (maxLaptopWidth < constraints.maxWidth &&
          constraints.maxWidth <= maxLargeWidth) {
        return const PortfolioDesktop(
          multiplierSize: 0.75,
        );
      } else {
        return const PortfolioDesktop(
          multiplierSize: 1.0,
        );
      }
    });
  }
}
