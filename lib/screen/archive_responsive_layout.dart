import 'package:flutter/material.dart';

import 'archive_desktop.dart';
import 'archive_mobile.dart';
import 'archive_tablet.dart';

class ArchiveResponsiveLayout extends StatefulWidget {
  const ArchiveResponsiveLayout({super.key});

  @override
  State<ArchiveResponsiveLayout> createState() =>
      _ArchiveResponsiveLayoutState();
}

class _ArchiveResponsiveLayoutState extends State<ArchiveResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 639) {
        return const ArchiveMobile();
      } else if (639 < constraints.maxWidth && constraints.maxWidth <= 1023) {
        return const ArchiveTablet(
          multiplierSize: 0.5,
        );
      } else if (1023 < constraints.maxWidth && constraints.maxWidth <= 1268) {
        return const ArchiveDesktop(
          multiplierSize: 0.75,
        );
      } else {
        return const ArchiveDesktop(
          multiplierSize: 1,
        );
      }
    });
  }
}
