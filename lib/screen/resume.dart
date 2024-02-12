import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../components/pdf_viewer.dart';
import '../utils/constants.dart';

class Resume extends StatefulWidget {
  const Resume({super.key});

  @override
  State<Resume> createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
  late String pdfUri;
  bool _isLoading = true;

  Future<void> loadPDF() async {
    String pdfLocation = '/documents/Resume.pdf';
    final Reference ref = FirebaseStorage.instance.ref().child(pdfLocation);
    String pdfUrl = await ref.getDownloadURL();
    setState(() {
      pdfUri = pdfUrl;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPDF();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: _isLoading
            ? Center(child: CircularProgressIndicator(color: neonBlue))
            : SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: PDFViewer(uri: pdfUri)));
  }
}
