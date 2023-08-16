import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../link.dart';

class TabletTableData extends StatefulWidget {
  const TabletTableData({super.key});

  @override
  State<TabletTableData> createState() => _TabletTableDataState();
}

class _TabletTableDataState extends State<TabletTableData> {
  final List<double> tableHeaderWidth = [85, 500.66, 324.34];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return records(size);
  }

  Widget records(size) {
    final Stream<QuerySnapshot> projectStream =
    FirebaseFirestore.instance.collection('projects').snapshots();

    return StreamBuilder(
      stream: projectStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.docs.isEmpty) {
          return const SizedBox.shrink();
        }

        final documents = snapshot.data!.docs;

        return Column(
          children: documents.reversed.map((document) {
            final title = document['project'];
            final year = document['year'];
            final url = document['url'];

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
                        width: tableHeaderWidth[0] * size.width * 0.0009,
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
                        width: tableHeaderWidth[1] * size.width * 0.0009,
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 14,
                              color: white,
                              fontFamily: 'SFProMedium',
                              letterSpacing: 1.2),
                        ),
                      ),
                      Link(
                        tableHeaderWidth: tableHeaderWidth,
                        url: url, multiplierSize: 0.75, index: 2,
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
