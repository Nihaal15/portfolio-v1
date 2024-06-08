import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PDFViewer extends StatefulWidget {
  final Uint8List pdfData;

  const PDFViewer({super.key, required this.pdfData});

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  late PdfControllerPinch pdfPinchController =
      PdfControllerPinch(document: PdfDocument.openData(widget.pdfData));

  @override
  Widget build(BuildContext context) {
    if (widget.pdfData.isEmpty) {
      Navigator.of(context).pushNamed("/");
      return const SizedBox.shrink();
    } else {
      return PdfViewPinch(
        controller: pdfPinchController,
        padding: 0,
      );
    }
  }
}
