import 'dart:convert';
import 'dart:io';
import 'package:pdf/widgets.dart' as pdf;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:print_pdf_invoices_app/pdfApi.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';


class User {final String item;
  final String total;
  
  final int count;

  const User({
    required this.item,
    required this.count,
    required this.total,
  });
}

class PdfParagraphApi {
  static Future<File> generate() async {
    final pdf = Document();

    final font = await rootBundle.load("assets/fonts/Cairo-Regular.ttf");
    final img =
        (await rootBundle.load('assets/jahez.png')).buffer.asUint8List();
        //     final img2 =
        // (await rootBundle.load('assest/img/qr.png')).buffer.asUint8List();
    final headers = ['Price', 'Count', 'Item'];

    final users = [
     const User(item: "منتج ١", count: 454, total: "23"), const User(item: "منتج ١", count: 454, total: "33"), const User(item: "منتج ١", count: 929, total: "45"), const User(item: "منتج ١", count: 282, total: "42"), const User(item: "منتج ١", count: 343, total: "53"), const User(item: "منتج ١", count: 554, total: "58"), const User(item: "منتج ١", count: 454, total: "93"), 
    ];
    final data = users.map((user) => [ user.count,user.total,user.item,]).toList();

    final ttf = Font.ttf(font);
    pdf.addPage(MultiPage(
      textDirection: TextDirection.rtl,
      theme: ThemeData.withFont(
        base: ttf,
      ),
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      build: (context) => <Widget>[
        Container(

        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //  Image(
            //   MemoryImage(img2),
            //   height: 80,
            //   width: 80,
            // ),
          
        Row(   mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
children: [
 Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'جاهز',
                    style: const TextStyle(
                      fontSize: 20,
                      color: PdfColors.black,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    'مكة المكرمة ',
                    style: const TextStyle(
                      fontSize: 20,
                      color: PdfColors.black,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ]),
            SizedBox(width: 0.5 * PdfPageFormat.cm),
            Image(
              MemoryImage(img),
              height: 80,
              width: 80,
            ),
]
            )
           
          ],
        )),
        Container(child: 
       
        Header(
          child: Center(
            child: Text('فاتورة ضريبية Tax Invoices',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: PdfColors.white,
                    font: ttf),
                textAlign: TextAlign.center),
          ),
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(color:PdfColors.deepOrangeAccent200),
        )),
        Container(
          child: 
        
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Invoices Number',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.black,
                  font: ttf),
              textAlign: TextAlign.center),
          Text('446567645433',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.deepOrangeAccent200,
                  font: ttf),
              textAlign: TextAlign.center),
          Text('رقم الفاتورة',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.black,
                  font: ttf),
              textAlign: TextAlign.center),
        ])),
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        Container(

        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Invoices Date',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.black,
                  font: ttf),
              textAlign: TextAlign.center),
          Text('12/05/2022',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.deepOrangeAccent200,
                  font: ttf),
              textAlign: TextAlign.center),
          Text('تاريخ الفاتورة',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.black,
                  font: ttf),
              textAlign: TextAlign.center),
        ])), SizedBox(height: 0.2 * PdfPageFormat.cm),
        Container(
          child: 
        
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Invoices Time',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.black,
                  font: ttf),
              textAlign: TextAlign.center),
          Text('12:05/2022',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.deepOrangeAccent200,
                  font: ttf),
              textAlign: TextAlign.center),
          Text('وقت الفاتورة',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.black,
                  font: ttf),
              textAlign: TextAlign.center),
        ])), SizedBox(height: 0.2 * PdfPageFormat.cm),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('VAT  number',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.black,
                  font: ttf),
              textAlign: TextAlign.center),
          Text('557899989845',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.deepOrangeAccent200,
                  font: ttf),
              textAlign: TextAlign.center),
          Text('رقم الضريبة المضافة ',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.black,
                  font: ttf),
              textAlign: TextAlign.center),
        ]),
        Center(
          child: Table.fromTextArray(
            headers: headers,
            data: data,

      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.deepOrangeAccent200),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerRight,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
          ),
        ), Divider(),
        Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              
              children: [
                
                buildText(
                  title: 'Net total',
                  value: "566.0",
                  unite: true,
                ),
                buildText(
                  title: 'Vat ${0.15 * 100} %',
                  value: "200",
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Total amount due',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: '700.63',
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    ),   SizedBox(height: 2 * PdfPageFormat.mm),Divider(),
   
    ],
      footer: (context) {
        final text = 'Page ${context.pageNumber} of ${context.pagesCount}';

        return  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [ Text("4026626626267"),  SizedBox(width: 2 * PdfPageFormat.mm),
        Text("السجل التجاري :", textDirection: TextDirection.rtl,),
      
       
      ],
    ),
          SizedBox(height: 1 * PdfPageFormat.mm),
            Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [ Text("454576772"),  SizedBox(width: 2 * PdfPageFormat.mm),
        Text("الرقم الضريبي :", textDirection: TextDirection.rtl,),
      
       

   ]) ]);}));

    return PdfApi.saveDocument(name: 'my_example.pdf', pdf: pdf);
  }
static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return 
    
    Directionality(textDirection: TextDirection.rtl, child: 
    Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: style, textDirection: TextDirection.rtl,),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    ));
  }
  static Widget buildCustomHeader() => Container(
      padding: EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 2, color: PdfColors.blue)),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'فوري',
              style: const TextStyle(
                fontSize: 20,
                color: PdfColors.black,
              ),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(width: 0.5 * PdfPageFormat.cm),
            PdfLogo(),
          ],
        ),
      ));

  static Widget buildCustomHeadline() => Header(
        child: Text(
          'My Third Headline',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PdfColors.white,
          ),
        ),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(color: PdfColors.red),
      );

  static Widget buildLink() => UrlLink(
        destination: 'https://flutter.dev',
        child: Text(
          'Go to flutter.dev',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: PdfColors.blue,
          ),
        ),
      );

  static List<Widget> buildBulletPoints() => [
        Bullet(text: 'First Bullet'),
        Bullet(text: 'Second Bullet'),
        Bullet(text: 'Third Bullet'),
      ];
        static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

}

