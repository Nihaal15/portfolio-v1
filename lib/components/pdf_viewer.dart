import 'dart:html' as html;
import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';

class PDFViewer extends StatelessWidget {
  final String uri;

  PDFViewer({super.key, required this.uri}) {
    ui.platformViewRegistry.registerViewFactory('object', (int viewId) {
      var object = html.ObjectElement()
        ..style.border = 'none'
        ..style.height = '100vh'
        ..style.width = '100vw';
      object.data = uri;
      return object;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const HtmlElementView(viewType: 'object');
  }
}
