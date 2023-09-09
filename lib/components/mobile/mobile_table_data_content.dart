import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/components/title_link.dart';

import '../../utils/constants.dart';

class MobileTableData extends StatefulWidget {
  const MobileTableData({super.key});

  @override
  State<MobileTableData> createState() => _MobileTableDataState();
}

class _MobileTableDataState extends State<MobileTableData> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      Container(
                        width: size.width * 0.15,
                        constraints: const BoxConstraints(minWidth: 40),
                        child: Text(
                          year,
                          style: TextStyle(
                              fontSize: 14,
                              color: white.withOpacity(0.5),
                              fontFamily: 'SFProRegular',
                              letterSpacing: 1.2),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TitleLink(
                          url: url,
                          title: title,
                        ),
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
