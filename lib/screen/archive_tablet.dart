import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../components/tablet/tablet_header_content.dart';
import '../components/tablet/tablet_table_data_content.dart';
import '../utils/constants.dart';

class ArchiveTablet extends StatefulWidget {
  final double multiplierSize;

  const ArchiveTablet({Key? key, required this.multiplierSize})
      : super(key: key);

  @override
  State<ArchiveTablet> createState() => _ArchiveTabletState();
}

class _ArchiveTabletState extends State<ArchiveTablet>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  bool isHover = false;
  late double multiplierSize;

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setState(() {
      multiplierSize = widget.multiplierSize;
    });
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
    double width = widget.multiplierSize;
    if (size.width >= 640 && size.width <= 1023) {
      double percentage = (size.width - 640) / (1023 - 640);
      width = 0.3 + percentage * (0.75 - 0.3);
    }
    width = width.clamp(0.3, 0.75);

    return Scaffold(
      backgroundColor: bgColor,
      body: FutureBuilder(
          future: loadData(),
          builder: (context, snapshot) {
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
                                padding: EdgeInsets.only(top: 0.08 * size.width),
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
                                                      colorFilter: ColorFilter.mode(
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
                                                        fontWeight: FontWeight.bold,
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
                                      fontSize: 46,
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
                              child: TabletTableHeaderContent(),
                            ),
                            content: const TabletTableData(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  Future<void> loadData() async {
    try {
      final aboutSnapshot =
      await FirebaseFirestore.instance.collection('about').get();
      final experienceSnapshot =
      await FirebaseFirestore.instance.collection('experience').get();
      final projectsSnapshot =
      await FirebaseFirestore.instance.collection('projects').get();

      final aboutData = aboutSnapshot.docs.map((doc) => doc.data()).toList();
      final experienceData =
      experienceSnapshot.docs.map((doc) => doc.data()).toList();
      final projectsData =
      projectsSnapshot.docs.map((doc) => doc.data()).toList();
    } catch (_) {}
  }
}
