import 'dart:html' as html;
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/pdf_viewer.dart';
import '../utils/constants.dart';
import '../utils/dimension.dart';

class Resume extends StatefulWidget {
  const Resume({super.key});

  @override
  State<Resume> createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
  late Uint8List pdfData;
  bool _isLoading = true;

  Future<void> loadPDF() async {
    String pdfLocation = '/documents/Resume.pdf';
    final Reference ref = FirebaseStorage.instance.ref().child(pdfLocation);
    String pdfUrl = await ref.getDownloadURL();
    final response = await http.get(Uri.parse(pdfUrl));
    final Uint8List bytes = response.bodyBytes;
    setState(() {
      pdfData = bytes;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPDF();
  }

  Future<void> saveFile(Uint8List bytes) async {
    try {
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute('download', 'nihaal_shirkar_resume.pdf')
        ..click();
      html.Url.revokeObjectUrl(url);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= maxMobileWidth) {
        return resumeViewer(size, 0.3);
      } else if (maxMobileWidth < constraints.maxWidth &&
          constraints.maxWidth <= maxLaptopWidth) {
        return resumeViewer(size, 0.75);
      } else {
        return resumeViewer(size, 1);
      }
    });
  }

  Widget resumeViewer(Size size, double fontSize) {
    return Scaffold(
        backgroundColor: _isLoading ? bgColor : const Color(0xFFFFFFFF),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            saveFile(pdfData);
          },
          elevation: _isLoading ? 0 : 20,
          foregroundColor: white,
          backgroundColor: bgColor,
          child: _isLoading
              ? const SizedBox.shrink()
              : const Icon(Icons.file_download_outlined),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator(color: neonBlue))
            : Center(
                child: SizedBox(
                    width: fontSize > 0.75 ? size.width * 0.8 : double.infinity,
                    height: size.height,
                    child: PDFViewer(pdfData: pdfData))));
  }
}
