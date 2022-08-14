import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {



  
  static Future<File> generateCenteredText(String text) async {
    final pdf = Document();
 final font = await rootBundle.load("assest/fonts/Cairo-Regular.ttf");
        final ttf = Font.ttf(
          font
        );
    pdf.addPage(Page(
          textDirection: TextDirection.rtl,
       theme: ThemeData.withFont(
    base: ttf,
  ),
      build: (context) =>Directionality(
                textDirection: TextDirection.rtl,
                child: Center(
        child: Text(text, style: TextStyle(fontSize: 48)),
      ),
    )));

    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}