import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'components/navi.dart';
import 'screen/archive_responsive_layout.dart';
import 'screen/home_responsive_layout.dart';
import 'screen/page_not_found.dart';
import 'screen/resume.dart';
import 'utils/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: kIsWeb
                ? {
              for (final platform in TargetPlatform.values)
                platform: const NoTransitionsBuilder(),
            }
                : const {},
          )),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const PageNotFound());
      },
      routes: {
        '/': (context) => const ResponsiveLayout(),
        '/archive': (context) => const ArchiveResponsiveLayout(),
        '/resume': (context) => const Resume(),
      },
      title: 'Nihaal Shirkar',
    );
  }
}
