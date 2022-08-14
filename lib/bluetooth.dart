import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui';

import 'package:enough_convert/enough_convert.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:image/image.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:qr_flutter/qr_flutter.dart';

class PrintScreen extends StatefulWidget {
 
  @override
  State<PrintScreen> createState() => _PrintScreenState();

}


class _PrintScreenState extends State<PrintScreen> {
  final PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  String? _devicesMsg;
  BluetoothManager bluetoothManager = BluetoothManager.instance;

  @override
  void initState() {
    bluetoothManager.state.listen((val) {
      if (!mounted) return;
      if (val == 12) {
        print('on');
        initPrinter();
      } else if (val == 10) {
        print('off');
        setState(() {
          _devicesMsg = 'bluetooth is not enabled';
        });
      }
      print('state is $val');
    });

    super.initState();
  }

  @override
  void dispose() {
    printerManager.startScan(const Duration(seconds: 2));
    super.dispose();
  }

  Uint8List textEncoder(String word) {
    return Uint8List.fromList(
        Windows1256Codec(allowInvalid: false).encode(word));
  }

  void initPrinter() {
    printerManager.startScan(const Duration(seconds: 2));

    printerManager.scanResults.listen((val) async {
      print('-------------');
      if (!mounted) return;
      setState(() => _devices = val);
      print(_devices);
      print(_devices.length);
      if (_devices.isEmpty) {
        setState(() => _devicesMsg = 'No devices');
      }
      print('-------------');
    });
  }

  Future<void> _startPrint(PrinterBluetooth printer) async {
    printerManager.selectPrinter(printer);
    final profile = await CapabilityProfile.load();

    final result = await printerManager
        .printTicket(await demoReceipt(PaperSize.mm80, profile));
    print(result);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(result.msg),
      ),
    );
  }

  // void _startPrint1(PrinterBluetooth printer) async {
  //   printerManager.selectPrinter(printer);
  //
  //   PaperSize paper = PaperSize.mm80;
  //   final profile = await CapabilityProfile.load(name: "XP-N160I");
  //   final PosPrintResult res = await printerManager
  //       .printTicket((await demoReceipt(PaperSize.mm80, profile)));
  //   print("&&&&&&&&&&&&&&&&&&&");
  //   print(res.toString());
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       content: Text(res.msg),
  //     ),
  //   );
  // }
  //
  // void _startPrint2(PrinterBluetooth printer) async {
  //   printerManager.selectPrinter(printer);
  //
  //   PaperSize paper = PaperSize.mm80;
  //   final profile = await CapabilityProfile.load(name: "RP80USE");
  //   final PosPrintResult res = await printerManager
  //       .printTicket((await demoReceipt(PaperSize.mm80, profile)));
  //   print("&&&&&&&&&&&&&&&&&&&");
  //   print(res.toString());
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       content: Text(res.msg),
  //     ),
  //   );
  // }
  //
  // void _startPrint3(PrinterBluetooth printer) async {
  //   printerManager.selectPrinter(printer);
  //
  //   PaperSize paper = PaperSize.mm80;
  //   final profile = await CapabilityProfile.load(name: "TP806L");
  //   final PosPrintResult res = await printerManager
  //       .printTicket((await demoReceipt(PaperSize.mm80, profile)));
  //   print("&&&&&&&&&&&&&&&&&&&");
  //   print(res.toString());
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       content: Text(res.msg),
  //     ),
  //   );
  // }


   Future<List<int>> demoReceipt(
      PaperSize paper, CapabilityProfile profile) async {
    final Generator ticket = Generator(paper, profile);
    List<int> bytes = [];

    // Print image
    // final ByteData data = await rootBundle.load('assets/jahez.png');
    // final Uint8List imageBytes = data.buffer.asUint8List();
    // final image = decodeImage(imageBytes);
    // bytes += ticket.image(image!);
    //
    // bytes += ticket.textEncoded(textEncoder('جاهز'),
    //     styles: PosStyles(
    //       align: PosAlign.center,
    //       height: PosTextSize.size2,
    //       width: PosTextSize.size2,
    //     ),
    //     linesAfter: 1);
    //
    // bytes += ticket.textEncoded(textEncoder('مكة المكرمة'),
    //     styles: PosStyles(align: PosAlign.center));
    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
        codeTable: 'CP437'));
    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP932'));
    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP850'));
    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP860'));
    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP863')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP865')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP851')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP853')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP857')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP737')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'ISO_8859-7')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP1252')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP866')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP852')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP858')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP874')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'TCVN-3-1')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'TCVN-3-2')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP720')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP775')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP855')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP861')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP862')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP864')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP869')); bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'ISO_8859-2'));
    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'ISO_8859-15'));

    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP1098'));

    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP774'));

    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP772'));
    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP1125'));
    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP1250'));
    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP1251'));
    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP1253'));

    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP1254'));

    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP1255'));

    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP1256'));
    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP1257'));
    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'CP1258'));
    bytes += ticket.textEncoded(textEncoder('الرصيفة بجوار ستاربكس '),
        styles: PosStyles(align: PosAlign.center,
            codeTable: 'RK1048'));





    // bytes += ticket.textEncoded(textEncoder('الموقع : www.example.com'),
    //     styles: PosStyles(align: PosAlign.center), linesAfter: 1);
    //
    // bytes += ticket.hr();
    // bytes += ticket.row([
    //   PosColumn(textEncoded: textEncoder('الكمية'), width: 1),
    //   PosColumn(textEncoded: textEncoder('الصنف'), width: 7),
    //   PosColumn(
    //       textEncoded: textEncoder('السعر'), width: 2, styles: PosStyles(align: PosAlign.right)),
    //   PosColumn(
    //       textEncoded: textEncoder('الاجمالي'), width: 2, styles: PosStyles(align: PosAlign.right)),
    // ]);
    //
    // bytes += ticket.row([
    //   PosColumn(text: '2', width: 1),
    //   PosColumn(textEncoded: textEncoder('حلقات البصل'), width: 7),
    //   PosColumn(
    //       text: '0.99', width: 2, styles: PosStyles(align: PosAlign.right)),
    //   PosColumn(
    //       text: '1.98', width: 2, styles: PosStyles(align: PosAlign.right)),
    // ]);
    // bytes += ticket.row([
    //   PosColumn(text: '1', width: 1),
    //   PosColumn(textEncoded: textEncoder('بيتزا'), width: 7),
    //   PosColumn(
    //       text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
    //   PosColumn(
    //       text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
    // ]);
    // bytes += ticket.row([
    //   PosColumn(text: '1', width: 1),
    //   PosColumn(textEncoded: textEncoder('سبرينق رول'), width: 7),
    //   PosColumn(
    //       text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
    //   PosColumn(
    //       text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
    // ]);
    // bytes += ticket.row([
    //   PosColumn(text: '3', width: 1),
    //   PosColumn(textEncoded: textEncoder('أصابع كرانشي'), width: 7),
    //   PosColumn(
    //       text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
    //   PosColumn(
    //       text: '2.55', width: 2, styles: PosStyles(align: PosAlign.right)),
    // ]);
    // bytes += ticket.hr();
    //
    // bytes += ticket.row([
    //   PosColumn(
    //       textEncoded: textEncoder('الاجمالي'),
    //       width: 6,
    //       styles: PosStyles(
    //         height: PosTextSize.size2,
    //         width: PosTextSize.size2,
    //       )),
    //   PosColumn(
    //       text: '\$10.97',
    //       width: 6,
    //       styles: PosStyles(
    //         align: PosAlign.right,
    //         height: PosTextSize.size2,
    //         width: PosTextSize.size2,
    //       )),
    // ]);
    //
    // bytes += ticket.hr(ch: '=', linesAfter: 1);
    //
    // bytes += ticket.row([
    //   PosColumn(
    //       textEncoded: textEncoder('كاش'),
    //       width: 7,
    //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
    //   PosColumn(
    //       text: '\$15.00',
    //       width: 5,
    //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
    // ]);
    // bytes += ticket.row([
    //   PosColumn(
    //       textEncoded: textEncoder('تغيير'),
    //       width: 7,
    //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
    //   PosColumn(
    //       text: '\$4.03',
    //       width: 5,
    //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
    // ]);
    //
    // bytes += ticket.feed(2);
    // bytes += ticket.textEncoded(textEncoder('شكرا !'),
    //     styles: PosStyles(align: PosAlign.center, bold: true));
    //
    // final now = DateTime.now();
    // final formatter = DateFormat('MM/dd/yyyy H:m');
    // final String timestamp = formatter.format(now);
    // bytes += ticket.text(timestamp,
    //     styles: PosStyles(align: PosAlign.center), linesAfter: 2);

    // Print QR Code from image
    // try {
    //   const String qrData = 'example.com';
    //   const double qrSize = 200;
    //   final uiImg = await QrPainter(
    //     data: qrData,
    //     version: QrVersions.auto,
    //     gapless: false,
    //   ).toImageData(qrSize);
    //   final dir = await getTemporaryDirectory();
    //   final pathName = '${dir.path}/qr_tmp.png';
    //   final qrFile = File(pathName);
    //   final imgFile = await qrFile.writeAsBytes(uiImg!.buffer.asUint8List());
    //   final img = decodeImage(imgFile.readAsBytesSync());

    //   bytes += ticket.image(img!);
    // } catch (e) {
    //   print(e);
    // }

   
    // bytes += ticket.qrcode('example.com');

    ticket.feed(2);
    ticket.cut();
    return bytes;}

  // Future<List<int>> demoReceipt1(
  //     PaperSize paper, CapabilityProfile profile) async {
  //   final Generator ticket = Generator(paper, profile);
  //   List<int> bytes = [];
  //
  //   // Print image
  //   // final ByteData data = await rootBundle.load('assets/jahez.png');
  //   // final Uint8List imageBytes = data.buffer.asUint8List();
  //   // final image = decodeImage(imageBytes);
  //   // bytes += ticket.image(image!);
  //   //
  //   // bytes += ticket.textEncoded(textEncoder('جاهز'),
  //   //     styles: PosStyles(
  //   //       align: PosAlign.center,
  //   //       height: PosTextSize.size2,
  //   //       width: PosTextSize.size2,
  //   //     ),
  //   //     linesAfter: 1);
  //   //
  //   // bytes += ticket.textEncoded(textEncoder('مكة المكرمة'),
  //   //     styles: PosStyles(align: PosAlign.center));
  //   bytes += ticket.text('11الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP437'));
  //   bytes += ticket.text(' 111الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP932'));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP850'));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP860'));
  //   bytes += ticket.text('11الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP863')); bytes += ticket.text('1الرصيفة بجوار ستاربكس 11',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP865')); bytes += ticket.text('111الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1252')); bytes += ticket.text('الرصيفة بجوار ستاربكس 111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP737')); bytes += ticket.text('الرصيفة بجوار ستاربكس 111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP862')); bytes += ticket.text('الرصيفة بجوار ستاربكس 111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1252')); bytes += ticket.text('1111الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP866')); bytes += ticket.text('الرصيفة بجوار ستاربكس 111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP852')); bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP858')); bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP747')); bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1257')); bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1258')); bytes += ticket.text('1111الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP864')); bytes += ticket.text('الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1001')); bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1255')); bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP437')); bytes += ticket.text('111الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP932')); bytes += ticket.text('الرصيفة بجوار ستاربكس 111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP858')); bytes += ticket.text('111الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP860')); bytes += ticket.text('111الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP861')); bytes += ticket.text('111الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP863')); bytes += ticket.text('الرصيفة بجوار ستاربكس 111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP865'));
  //   bytes += ticket.text('111الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP866'));
  //
  //   bytes += ticket.text('111الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP855'));
  //
  //   bytes += ticket.text('1111الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP857'));
  //
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP862'));
  //   bytes += ticket.text('1111الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP864'));
  //   bytes += ticket.text('1111الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP737'));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP851'));
  //   bytes += ticket.text('1111الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP869'));
  //
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP928'));
  //
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس111 ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP772'));
  //
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس111 ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP774'));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP874'));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1252'));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1250'));   bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1251'));   bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP3840'));   bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP3841'));   bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP3843'));   bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP3844'));   bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP3845'));   bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP3846'));   bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP3847'));   bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP3848')); bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1001')); bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP2001')); bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP3001')); bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP3002')); bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP3011')); bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP3012')); bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP3021')); bytes += ticket.text('الرصيفة بجوار ستاربكس 1111',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP3041'));
  //
  //
  //
  //
  //
  //   // bytes += ticket.textEncoded(textEncoder('الموقع : www.example.com'),
  //   //     styles: PosStyles(align: PosAlign.center), linesAfter: 1);
  //   //
  //   // bytes += ticket.hr();
  //   // bytes += ticket.row([
  //   //   PosColumn(textEncoded: textEncoder('الكمية'), width: 1),
  //   //   PosColumn(textEncoded: textEncoder('الصنف'), width: 7),
  //   //   PosColumn(
  //   //       textEncoded: textEncoder('السعر'), width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       textEncoded: textEncoder('الاجمالي'), width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   //
  //   // bytes += ticket.row([
  //   //   PosColumn(text: '2', width: 1),
  //   //   PosColumn(textEncoded: textEncoder('حلقات البصل'), width: 7),
  //   //   PosColumn(
  //   //       text: '0.99', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '1.98', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   // bytes += ticket.row([
  //   //   PosColumn(text: '1', width: 1),
  //   //   PosColumn(textEncoded: textEncoder('بيتزا'), width: 7),
  //   //   PosColumn(
  //   //       text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   // bytes += ticket.row([
  //   //   PosColumn(text: '1', width: 1),
  //   //   PosColumn(textEncoded: textEncoder('سبرينق رول'), width: 7),
  //   //   PosColumn(
  //   //       text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   // bytes += ticket.row([
  //   //   PosColumn(text: '3', width: 1),
  //   //   PosColumn(textEncoded: textEncoder('أصابع كرانشي'), width: 7),
  //   //   PosColumn(
  //   //       text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '2.55', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   // bytes += ticket.hr();
  //   //
  //   // bytes += ticket.row([
  //   //   PosColumn(
  //   //       textEncoded: textEncoder('الاجمالي'),
  //   //       width: 6,
  //   //       styles: PosStyles(
  //   //         height: PosTextSize.size2,
  //   //         width: PosTextSize.size2,
  //   //       )),
  //   //   PosColumn(
  //   //       text: '\$10.97',
  //   //       width: 6,
  //   //       styles: PosStyles(
  //   //         align: PosAlign.right,
  //   //         height: PosTextSize.size2,
  //   //         width: PosTextSize.size2,
  //   //       )),
  //   // ]);
  //   //
  //   // bytes += ticket.hr(ch: '=', linesAfter: 1);
  //   //
  //   // bytes += ticket.row([
  //   //   PosColumn(
  //   //       textEncoded: textEncoder('كاش'),
  //   //       width: 7,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   //   PosColumn(
  //   //       text: '\$15.00',
  //   //       width: 5,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   // ]);
  //   // bytes += ticket.row([
  //   //   PosColumn(
  //   //       textEncoded: textEncoder('تغيير'),
  //   //       width: 7,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   //   PosColumn(
  //   //       text: '\$4.03',
  //   //       width: 5,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   // ]);
  //   //
  //   // bytes += ticket.feed(2);
  //   // bytes += ticket.textEncoded(textEncoder('شكرا !'),
  //   //     styles: PosStyles(align: PosAlign.center, bold: true));
  //   //
  //   // final now = DateTime.now();
  //   // final formatter = DateFormat('MM/dd/yyyy H:m');
  //   // final String timestamp = formatter.format(now);
  //   // bytes += ticket.text(timestamp,
  //   //     styles: PosStyles(align: PosAlign.center), linesAfter: 2);
  //
  //   // Print QR Code from image
  //   // try {
  //   //   const String qrData = 'example.com';
  //   //   const double qrSize = 200;
  //   //   final uiImg = await QrPainter(
  //   //     data: qrData,
  //   //     version: QrVersions.auto,
  //   //     gapless: false,
  //   //   ).toImageData(qrSize);
  //   //   final dir = await getTemporaryDirectory();
  //   //   final pathName = '${dir.path}/qr_tmp.png';
  //   //   final qrFile = File(pathName);
  //   //   final imgFile = await qrFile.writeAsBytes(uiImg!.buffer.asUint8List());
  //   //   final img = decodeImage(imgFile.readAsBytesSync());
  //
  //   //   bytes += ticket.image(img!);
  //   // } catch (e) {
  //   //   print(e);
  //   // }
  //
  //
  //   // bytes += ticket.qrcode('example.com');
  //
  //   ticket.feed(2);
  //   ticket.cut();
  //   return bytes;}
  //
  //
  // Future<List<int>> demoReceipt2(
  //     PaperSize paper, CapabilityProfile profile) async {
  //   final Generator ticket = Generator(paper, profile);
  //   List<int> bytes = [];
  //
  //   // Print image
  //   // final ByteData data = await rootBundle.load('assets/jahez.png');
  //   // final Uint8List imageBytes = data.buffer.asUint8List();
  //   // final image = decodeImage(imageBytes);
  //   // bytes += ticket.image(image!);
  //   //
  //   // bytes += ticket.textEncoded(textEncoder('جاهز'),
  //   //     styles: PosStyles(
  //   //       align: PosAlign.center,
  //   //       height: PosTextSize.size2,
  //   //       width: PosTextSize.size2,
  //   //     ),
  //   //     linesAfter: 1);
  //   //
  //   // bytes += ticket.textEncoded(textEncoder('مكة المكرمة'),
  //   //     styles: PosStyles(align: PosAlign.center));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 22222',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP437'));
  //   bytes += ticket.text('2222الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP932'));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 222',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP850'));
  //   bytes += ticket.text('222الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP860'));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس2222 ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP863')); bytes += ticket.text('222الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP865')); bytes += ticket.text('الرصيفة بجوار ستاربكس 222',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1251')); bytes += ticket.text('222الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP866')); bytes += ticket.text('222الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP862')); bytes += ticket.text('الرصيفة بجوار ستاربكس2222 ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1252')); bytes += ticket.text('الرصيفة بجوار ستاربكس 222',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1253')); bytes += ticket.text('222الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP852')); bytes += ticket.text('الرصيفة بجوار ستاربكس 222',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP858')); bytes += ticket.text('الرصيفة بجوار ستاربكس222 ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP864')); bytes += ticket.text('الرصيفة بجوار ستاربكس222 ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'ISO_8859-1')); bytes += ticket.text('الرصيفة بجوار ستاربكس 2222',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP737')); bytes += ticket.text('222الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1257')); bytes += ticket.text('222الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP720')); bytes += ticket.text('2222الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP855')); bytes += ticket.text('الرصيفة بجوار ستاربكس 222',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP857')); bytes += ticket.text('الرصيفة بجوار ستاربكس 222',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1250')); bytes += ticket.text('الرصيفة بجوار ستاربكس 2222',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP775')); bytes += ticket.text('الرصيفة بجوار ستاربكس 222',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1254')); bytes += ticket.text('الرصيفة بجوار ستاربكس 222',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1256')); bytes += ticket.text('222الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP1258')); bytes += ticket.text('الرصيفة بجوار ستاربكس 222',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'ISO_8859-2'));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس222 ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'ISO_8859-3'));
  //
  //   bytes += ticket.text('222الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'ISO_8859-4'));
  //
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 222',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'ISO_8859-5'));
  //
  //   bytes += ticket.text('222الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'ISO_8859-6'));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 222',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'ISO_8859-7'));
  //   bytes += ticket.text('222الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'ISO_8859-8'));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس2222 ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'ISO_8859-9'));
  //   bytes += ticket.text('222الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'ISO_8859-15'));
  //
  //   bytes += ticket.text('222الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP856'));
  //
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس222 ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'CP874'));
  //
  //
  //
  //
  //
  //
  //
  //   // bytes += ticket.textEncoded(textEncoder('الموقع : www.example.com'),
  //   //     styles: PosStyles(align: PosAlign.center), linesAfter: 1);
  //   //
  //   // bytes += ticket.hr();
  //   // bytes += ticket.row([
  //   //   PosColumn(textEncoded: textEncoder('الكمية'), width: 1),
  //   //   PosColumn(textEncoded: textEncoder('الصنف'), width: 7),
  //   //   PosColumn(
  //   //       textEncoded: textEncoder('السعر'), width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       textEncoded: textEncoder('الاجمالي'), width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   //
  //   // bytes += ticket.row([
  //   //   PosColumn(text: '2', width: 1),
  //   //   PosColumn(textEncoded: textEncoder('حلقات البصل'), width: 7),
  //   //   PosColumn(
  //   //       text: '0.99', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '1.98', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   // bytes += ticket.row([
  //   //   PosColumn(text: '1', width: 1),
  //   //   PosColumn(textEncoded: textEncoder('بيتزا'), width: 7),
  //   //   PosColumn(
  //   //       text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   // bytes += ticket.row([
  //   //   PosColumn(text: '1', width: 1),
  //   //   PosColumn(textEncoded: textEncoder('سبرينق رول'), width: 7),
  //   //   PosColumn(
  //   //       text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   // bytes += ticket.row([
  //   //   PosColumn(text: '3', width: 1),
  //   //   PosColumn(textEncoded: textEncoder('أصابع كرانشي'), width: 7),
  //   //   PosColumn(
  //   //       text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '2.55', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   // bytes += ticket.hr();
  //   //
  //   // bytes += ticket.row([
  //   //   PosColumn(
  //   //       textEncoded: textEncoder('الاجمالي'),
  //   //       width: 6,
  //   //       styles: PosStyles(
  //   //         height: PosTextSize.size2,
  //   //         width: PosTextSize.size2,
  //   //       )),
  //   //   PosColumn(
  //   //       text: '\$10.97',
  //   //       width: 6,
  //   //       styles: PosStyles(
  //   //         align: PosAlign.right,
  //   //         height: PosTextSize.size2,
  //   //         width: PosTextSize.size2,
  //   //       )),
  //   // ]);
  //   //
  //   // bytes += ticket.hr(ch: '=', linesAfter: 1);
  //   //
  //   // bytes += ticket.row([
  //   //   PosColumn(
  //   //       textEncoded: textEncoder('كاش'),
  //   //       width: 7,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   //   PosColumn(
  //   //       text: '\$15.00',
  //   //       width: 5,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   // ]);
  //   // bytes += ticket.row([
  //   //   PosColumn(
  //   //       textEncoded: textEncoder('تغيير'),
  //   //       width: 7,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   //   PosColumn(
  //   //       text: '\$4.03',
  //   //       width: 5,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   // ]);
  //   //
  //   // bytes += ticket.feed(2);
  //   // bytes += ticket.textEncoded(textEncoder('شكرا !'),
  //   //     styles: PosStyles(align: PosAlign.center, bold: true));
  //   //
  //   // final now = DateTime.now();
  //   // final formatter = DateFormat('MM/dd/yyyy H:m');
  //   // final String timestamp = formatter.format(now);
  //   // bytes += ticket.text(timestamp,
  //   //     styles: PosStyles(align: PosAlign.center), linesAfter: 2);
  //
  //   // Print QR Code from image
  //   // try {
  //   //   const String qrData = 'example.com';
  //   //   const double qrSize = 200;
  //   //   final uiImg = await QrPainter(
  //   //     data: qrData,
  //   //     version: QrVersions.auto,
  //   //     gapless: false,
  //   //   ).toImageData(qrSize);
  //   //   final dir = await getTemporaryDirectory();
  //   //   final pathName = '${dir.path}/qr_tmp.png';
  //   //   final qrFile = File(pathName);
  //   //   final imgFile = await qrFile.writeAsBytes(uiImg!.buffer.asUint8List());
  //   //   final img = decodeImage(imgFile.readAsBytesSync());
  //
  //   //   bytes += ticket.image(img!);
  //   // } catch (e) {
  //   //   print(e);
  //   // }
  //
  //
  //   // bytes += ticket.qrcode('example.com');
  //
  //   ticket.feed(2);
  //   ticket.cut();
  //   return bytes;}
  //
  // Future<List<int>> demoReceipt3(
  //     PaperSize paper, CapabilityProfile profile) async {
  //   final Generator ticket = Generator(paper, profile);
  //   List<int> bytes = [];
  //
  //   // Print image
  //   // final ByteData data = await rootBundle.load('assets/jahez.png');
  //   // final Uint8List imageBytes = data.buffer.asUint8List();
  //   // final image = decodeImage(imageBytes);
  //   // bytes += ticket.image(image!);
  //   //
  //   // bytes += ticket.textEncoded(textEncoder('جاهز'),
  //   //     styles: PosStyles(
  //   //       align: PosAlign.center,
  //   //       height: PosTextSize.size2,
  //   //       width: PosTextSize.size2,
  //   //     ),
  //   //     linesAfter: 1);
  //   //
  //   // bytes += ticket.textEncoded(textEncoder('مكة المكرمة'),
  //   //     styles: PosStyles(align: PosAlign.center));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 333',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'PC437'));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 333',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'Katakana'));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 333',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'PC850'));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس 3333',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'PC860'));
  //   bytes += ticket.text('الرصيفة بجوار ستاربكس333 ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'PC863')); bytes += ticket.text('الرصيفة بجوار ستاربكس 3333',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'PC865')); bytes += ticket.text('الرصيفة بجوار ستاربكس 333',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'PC857')); bytes += ticket.text('الرصيفة بجوار ستاربكس 333',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'PC737')); bytes += ticket.text('الرصيفة بجوار ستاربكس 333',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'ISO8859-7')); bytes += ticket.text('333الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'WPC1252')); bytes += ticket.text('الرصيفة بجوار ستاربكس333 ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'PC866')); bytes += ticket.text('الرصيفة بجوار ستاربكس333 ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'PC852')); bytes += ticket.text('الرصيفة بجوار ستاربكس333 ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'PC858')); bytes += ticket.text('333الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'KU42')); bytes += ticket.text('333الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'PC720')); bytes += ticket.text('333الرصيفة بجوار ستاربكس ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'PC864')); bytes += ticket.text('الرصيفة بجوار ستاربكس 3333',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'WPC1256')); bytes += ticket.text('الرصيفة بجوار ستاربكس333 ',
  //       styles: PosStyles(align: PosAlign.center,
  //           codeTable: 'ISO-8859-6'));
  //
  //
  //
  //
  //   // bytes += ticket.textEncoded(textEncoder('الموقع : www.example.com'),
  //   //     styles: PosStyles(align: PosAlign.center), linesAfter: 1);
  //   //
  //   // bytes += ticket.hr();
  //   // bytes += ticket.row([
  //   //   PosColumn(textEncoded: textEncoder('الكمية'), width: 1),
  //   //   PosColumn(textEncoded: textEncoder('الصنف'), width: 7),
  //   //   PosColumn(
  //   //       textEncoded: textEncoder('السعر'), width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       textEncoded: textEncoder('الاجمالي'), width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   //
  //   // bytes += ticket.row([
  //   //   PosColumn(text: '2', width: 1),
  //   //   PosColumn(textEncoded: textEncoder('حلقات البصل'), width: 7),
  //   //   PosColumn(
  //   //       text: '0.99', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '1.98', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   // bytes += ticket.row([
  //   //   PosColumn(text: '1', width: 1),
  //   //   PosColumn(textEncoded: textEncoder('بيتزا'), width: 7),
  //   //   PosColumn(
  //   //       text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '3.45', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   // bytes += ticket.row([
  //   //   PosColumn(text: '1', width: 1),
  //   //   PosColumn(textEncoded: textEncoder('سبرينق رول'), width: 7),
  //   //   PosColumn(
  //   //       text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '2.99', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   // bytes += ticket.row([
  //   //   PosColumn(text: '3', width: 1),
  //   //   PosColumn(textEncoded: textEncoder('أصابع كرانشي'), width: 7),
  //   //   PosColumn(
  //   //       text: '0.85', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   //   PosColumn(
  //   //       text: '2.55', width: 2, styles: PosStyles(align: PosAlign.right)),
  //   // ]);
  //   // bytes += ticket.hr();
  //   //
  //   // bytes += ticket.row([
  //   //   PosColumn(
  //   //       textEncoded: textEncoder('الاجمالي'),
  //   //       width: 6,
  //   //       styles: PosStyles(
  //   //         height: PosTextSize.size2,
  //   //         width: PosTextSize.size2,
  //   //       )),
  //   //   PosColumn(
  //   //       text: '\$10.97',
  //   //       width: 6,
  //   //       styles: PosStyles(
  //   //         align: PosAlign.right,
  //   //         height: PosTextSize.size2,
  //   //         width: PosTextSize.size2,
  //   //       )),
  //   // ]);
  //   //
  //   // bytes += ticket.hr(ch: '=', linesAfter: 1);
  //   //
  //   // bytes += ticket.row([
  //   //   PosColumn(
  //   //       textEncoded: textEncoder('كاش'),
  //   //       width: 7,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   //   PosColumn(
  //   //       text: '\$15.00',
  //   //       width: 5,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   // ]);
  //   // bytes += ticket.row([
  //   //   PosColumn(
  //   //       textEncoded: textEncoder('تغيير'),
  //   //       width: 7,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   //   PosColumn(
  //   //       text: '\$4.03',
  //   //       width: 5,
  //   //       styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
  //   // ]);
  //   //
  //   // bytes += ticket.feed(2);
  //   // bytes += ticket.textEncoded(textEncoder('شكرا !'),
  //   //     styles: PosStyles(align: PosAlign.center, bold: true));
  //   //
  //   // final now = DateTime.now();
  //   // final formatter = DateFormat('MM/dd/yyyy H:m');
  //   // final String timestamp = formatter.format(now);
  //   // bytes += ticket.text(timestamp,
  //   //     styles: PosStyles(align: PosAlign.center), linesAfter: 2);
  //
  //   // Print QR Code from image
  //   // try {
  //   //   const String qrData = 'example.com';
  //   //   const double qrSize = 200;
  //   //   final uiImg = await QrPainter(
  //   //     data: qrData,
  //   //     version: QrVersions.auto,
  //   //     gapless: false,
  //   //   ).toImageData(qrSize);
  //   //   final dir = await getTemporaryDirectory();
  //   //   final pathName = '${dir.path}/qr_tmp.png';
  //   //   final qrFile = File(pathName);
  //   //   final imgFile = await qrFile.writeAsBytes(uiImg!.buffer.asUint8List());
  //   //   final img = decodeImage(imgFile.readAsBytesSync());
  //
  //   //   bytes += ticket.image(img!);
  //   // } catch (e) {
  //   //   print(e);
  //   // }
  //
  //
  //   // bytes += ticket.qrcode('example.com');
  //
  //   ticket.feed(2);
  //   ticket.cut();
  //   return bytes;}




  @override
  Widget build(BuildContext context) {
    final status = Permission.location.request().isGranted;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "printing",
              style: TextStyle(color: Colors.blue),
            ),
            GestureDetector(
              onTap: (){
              Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_forward,
                color:  Colors.blue,
                size: 30,
              ),
            )
          ],
        ),
      ),
      body: _devices.isEmpty
          ? Center(child: Text(_devicesMsg ?? ''))
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (c, i) => ListTile(
                leading: const Icon(Icons.print),
                title: Text(_devices[i].name!),
                subtitle: Text(_devices[i].address!),
                onTap: () {
                  _startPrint(_devices[i]);
                  // _startPrint1(_devices[i]);
                  // _startPrint2(_devices[i]);
                  // _startPrint3(_devices[i]);
                  print(_devices[i]);
                  print("***********************");

                },
              ),
            ),
    );
  }
}
