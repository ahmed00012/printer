import 'dart:typed_data';

import 'package:enough_convert/enough_convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:print_pdf_invoices_app/bluetooth.dart';
import 'package:print_pdf_invoices_app/pdf.dart';
import 'package:print_pdf_invoices_app/pdfApi.dart';

class Invoices extends StatefulWidget {
  const Invoices({Key? key}) : super(key: key);

  @override
  State<Invoices> createState() => _InvoicesState();
}

class _InvoicesState extends State<Invoices> {

  Uint8List textEncoder(String word) {
    return Uint8List.fromList(
        Windows1256Codec(allowInvalid: false).encode(word));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: InkWell(
          onTap: (){
            print(textEncoder('الرصيفة بجوار ستاربكس '));
          },
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
              const Center(
                  child: const Text(
                "فاتورة ضريبية مبسطة",
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              )),
              const SizedBox(
                height: 20,
              ),
              const Center(
                  child: const Text(
                'رقم الفاتورة :' + "44334455545555454",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Image(
                    height: 65,
                    width: 65,
                    image: NetworkImage(
                      'https://iconape.com/wp-content/png_logo_vector/jahez.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "جاهز",
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const Text(
                        "مكة المكرمة",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "التاريخ:" + "12-2-2020",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const Text(
                    "الوقت:" + "12:22:33",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Center(
                  child: Text(
                "رقم تسجيل ضريبة القيمة المضافة :" + "736738388383",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              )),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              DataTable(
                sortColumnIndex: 0,
                sortAscending: true,
                columns: [
                  const DataColumn(
                    label: const Text(
                      'المنتجات',
                    ),
                  ),
                  const DataColumn(
                    label: const Text(
                      'الكمية',
                    ),
                    numeric: true,
                  ),
                  const DataColumn(
                    label: const Text(
                      'السعر',
                    ),
                    numeric: true,
                  ),
                ],
                rows: List.generate(
                  3,
                  (index) => const DataRow(
                    cells: [
                      const DataCell(
                        const Text(
                          "برقر",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      const DataCell(
                        const Text(
                          "2",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      const DataCell(
                        const Text(
                          "30",
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "المجموع شامل ضريبة القيمة المضافة(ريال)",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    const Text(
                      "33",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "ضريبة القيمة المضافة(ريال)",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    const Text(
                      "55",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PrintScreen()),
                        );
                      },
                      child: const Center(
                        child: const Text(
                          "طباعة بالبلوتوث ",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async{


                  final pdfFile = await PdfParagraphApi.generate();

                      PdfApi.openFile(pdfFile);
                      },
                      //
                      child: const Center(
                        child: Text(
                          "عرض",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ]),
          )),
        ));
  }
}
