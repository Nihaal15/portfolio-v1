import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../components/mobile/mobile_header_content.dart';
import '../components/mobile/mobile_table_data_content.dart';
import '../utils/constants.dart';

class ArchiveMobile extends StatefulWidget {
  const ArchiveMobile({super.key});

  @override
  State<ArchiveMobile> createState() => _ArchiveMobileState();
}

class _ArchiveMobileState extends State<ArchiveMobile>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final ItemScrollController _scrollController = ItemScrollController();

  bool isHover = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  double fontSize = 36;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      body: FutureBuilder(builder: (context, snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.9175,
              height: double.infinity,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ScrollablePositionedList.builder(
                  itemCount: 2,
                  itemScrollController: _scrollController,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return StickyHeader(
                        header: const SizedBox.shrink(),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MouseRegion(
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
                                        Navigator.of(context)
                                            .pushReplacementNamed("/");
                                      },
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: SizedBox(
                                                width: 25,
                                                child: AnimatedPadding(
                                                  duration: const Duration(
                                                      milliseconds: 100),
                                                  padding: EdgeInsets.only(
                                                      right: isHover ? 10 : 0),
                                                  child: SvgPicture.asset(
                                                    'assets/images/angle-left-solid.svg',
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                      neonBlue,
                                                      BlendMode.srcIn,
                                                    ),
                                                    height: 15.68,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(
                                              child: SizedBox(
                                                height: 15.68,
                                                child: Text(
                                                  'NIHAAL SHIRKAR',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: neonBlue,
                                                      fontFamily: 'SFProBold',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 1.2),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 8, bottom: 48),
                              child: Text(
                                'All Projects',
                                style: TextStyle(
                                    fontSize: fontSize,
                                    color: white,
                                    fontFamily: 'SFProMedium',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.2),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: StickyHeader(
                          header: const Padding(
                            padding: EdgeInsets.only(bottom: 3.0),
                            child: MobileTableHeaderContent(),
                          ),
                          content: const MobileTableData(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
