import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class Resume extends StatelessWidget {
  const Resume({super.key});

  @override
  Widget build(BuildContext context) {
    final storageRef = FirebaseStorage.instance.ref();
    String pdfUrl = '/documents/Resume.pdf';

    return Scaffold(
      body: FutureBuilder<String>(
        future: storageRef.child(pdfUrl).getDownloadURL(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error loading PDF: ${snapshot.error}'),
              );
            }
            final pdfUrl = snapshot.data;
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: HtmlWidget(
                '<iframe src="$pdfUrl" style="width: 100vw; height: 100vh"></iframe>',
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
