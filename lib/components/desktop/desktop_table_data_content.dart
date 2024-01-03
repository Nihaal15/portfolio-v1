import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../link.dart';

class DesktopTableData extends StatefulWidget {
  final double multiplierSize;

  const DesktopTableData({super.key, required this.multiplierSize});

  @override
  State<DesktopTableData> createState() => _DesktopTableDataState();
}

class _DesktopTableDataState extends State<DesktopTableData> {
  final List<double> tableHeaderWidth = [64.13, 271.05, 143.27, 368.03, 241.53];

  @override
  Widget build(BuildContext context) {
    return records();
  }

  Widget records() {
    final Stream<QuerySnapshot> projectStream =
        FirebaseFirestore.instance.collection('projects').snapshots();

    return FutureBuilder(
      future: projectStream.first,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.docs.isEmpty) {
          return const SizedBox.shrink();
        }

        final documents = snapshot.data!.docs;

        return Column(
          children: documents.reversed.map((document) {
            final company = document['made at'];
            final title = document['project'];
            final tags = List<String>.from(document['tags']);
            final year = document['year'];
            final url = document['url'];
            final github = document['github'];

            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 0.3,
                  color: lightBlue.withOpacity(0.5),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: [
                      SizedBox(
                        width:
                            tableHeaderWidth[0] * widget.multiplierSize * 0.9,
                        child: Text(
                          year,
                          style: TextStyle(
                              fontSize: 14,
                              color: white.withOpacity(0.5),
                              fontFamily: 'SFProRegular',
                              letterSpacing: 1.2),
                        ),
                      ),
                      SizedBox(
                        width:
                            tableHeaderWidth[1] * widget.multiplierSize * 0.9,
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 14,
                              color: white,
                              fontFamily: 'SFProMedium',
                              letterSpacing: 1.2),
                        ),
                      ),
                      SizedBox(
                        width:
                            tableHeaderWidth[2] * widget.multiplierSize * 0.9,
                        child: Text(
                          company,
                          style: TextStyle(
                              fontSize: 14,
                              color: white.withOpacity(0.5),
                              fontFamily: 'SFProRegular',
                              letterSpacing: 1.2),
                        ),
                      ),
                      SizedBox(
                        width:
                            tableHeaderWidth[3] * widget.multiplierSize * 0.9,
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: tags.map((text) {
                            return ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                enabledMouseCursor: SystemMouseCursors.basic,
                                surfaceTintColor: Colors.transparent,
                                disabledBackgroundColor:
                                    const Color(0xFF122b39),
                                disabledForegroundColor: neonBlue,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              child: Text(
                                text,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'SFProRegular',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Link(
                        tableHeaderWidth: tableHeaderWidth,
                        url: url,
                        github: github,
                        multiplierSize: widget.multiplierSize,
                        index: 4,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
