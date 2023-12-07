import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:pbp_widget_a_klmpk4/pdf/preview_screen.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:uuid/uuid.dart';

Future<void> createPdf(
  String location,
  String carName,
  int price,
  String pickupDate,
  String returnDate,
  int id,
  BuildContext context,
) async {
  final doc = pw.Document();
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  const uuid = Uuid();
  String uId = uuid.v1();
  final imageLogo =
      (await rootBundle.load("assets/logo.png")).buffer.asUint8List();

  final imageInvoice = pw.MemoryImage(imageLogo);

  pw.ImageProvider pdfImageProvider(Uint8List imageBytes) {
    return pw.MemoryImage(imageBytes);
  }


  final pdfTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    buildBackground: (pw.Context context) {
      return pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColor.fromHex('#00A2E8'),
            width: 1,
          ),
        ),
      );
    },
  );

  doc.addPage(
    pw.MultiPage(
      pageTheme: pdfTheme,
      header: (pw.Context context) {
        return headerPDF();
      },
      build: (pw.Context context) {
        return [
          pw.Center(
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                pw.Container(
                    margin: const pw.EdgeInsets.symmetric(
                        horizontal: 2, vertical: 10)),

                pw.Image(imageInvoice, height: 180, width: 180),
                pw.SizedBox(height: 20),
                personalDataFromInput(
                    location, carName, price, pickupDate, returnDate),
                pw.SizedBox(height: 10),
                topOfInvoice(imageInvoice),
                // barcodeGaris(id.toString()),
                pw.SizedBox(height: 5),
                barcodeKotak(id.toString()),
                pw.SizedBox(height: 5),
                pw.Text('UUID : $uId', style: const pw.TextStyle(fontSize: 6)),
              ]))
        ];
      },
      footer: (pw.Context context) {
        return pw.Container(
            color: PdfColor.fromHex('#00A2E8'),
            child: footerPDF(formattedDate));
      },
    ),
  );

  // ignore: use_build_context_synchronously
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(doc: doc),
      ));
}

pw.Header headerPDF() {
  return pw.Header(
    margin: pw.EdgeInsets.zero,
    outlineColor: PdfColors.amber50,
    outlineStyle: PdfOutlineStyle.normal,
    level: 5,
    decoration: pw.BoxDecoration(
      shape: pw.BoxShape.rectangle,
      gradient: pw.LinearGradient(
        colors: [
          PdfColor.fromHex('#FFFFFF'),
          PdfColor.fromHex('#00A2E8'),
        ],
        begin: pw.Alignment.topCenter,
        end: pw.Alignment.bottomCenter,
      ),
    ),
    child: pw.Center(
      child: pw.Text(
        '- INVOICE -',
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 12,
        ),
      ),
    ),
  );
}

pw.Padding imageFromInput(
    pw.ImageProvider Function(Uint8List imageBytes) pdfImageProvider,
    Uint8List imageBytes) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 10),
    child: pw.FittedBox(
      child: pw.Image(pdfImageProvider(imageBytes), width: 200),
      fit: pw.BoxFit.fitHeight,
      alignment: pw.Alignment.center,
    ),
  );
}

pw.Padding personalDataFromInput(
  String location,
  String carName,
  int price,
  String pickupDate,
  String returnDate,
) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 1),
    child: pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: [
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              child: pw.Text(
                'Location',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              child: pw.Text(
                location,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              child: pw.Text(
                'Car Name',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              child: pw.Text(
                carName,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              child: pw.Text(
                'Price',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              child: pw.Text(
                price.toString(),
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              child: pw.Text(
                'Pickup Date',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              child: pw.Text(
                pickupDate,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              child: pw.Text(
                'Return Date',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 5),
              child: pw.Text(
                returnDate,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

pw.Padding topOfInvoice(pw.MemoryImage imageInvoice) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Expanded(
          child: pw.Container(
            height: 100,
            decoration: const pw.BoxDecoration(
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
              color: PdfColors.blue100,
            ),
            padding: const pw.EdgeInsets.only(
                left: 20, top: 10, bottom: 10, right: 20),
            alignment: pw.Alignment.centerLeft,
            child: pw.DefaultTextStyle(
              style: const pw.TextStyle(color: PdfColors.black, fontSize: 12),
              child: pw.GridView(
                crossAxisCount: 2,
                children: [
                  pw.Text('Car Rental',
                      style: const pw.TextStyle(
                          fontSize: 10, color: PdfColors.black)),
                  pw.Text('Babarsari Street 25, Yogyakarta 5111',
                      style: const pw.TextStyle(
                          fontSize: 10, color: PdfColors.black)),
                  pw.Text('Contact Us',
                      style: const pw.TextStyle(
                          fontSize: 10, color: PdfColors.black)),
                  pw.SizedBox(height: 1),
                  pw.Text('Phone Number',
                      style: const pw.TextStyle(
                          fontSize: 10, color: PdfColors.black)),
                  pw.Text('0812345678',
                      style: const pw.TextStyle(
                          fontSize: 10, color: PdfColors.black)),
                  pw.Text('Email',
                      style: const pw.TextStyle(
                          fontSize: 10, color: PdfColors.black)),
                  pw.Text('carrental@gmail.com',
                      style: const pw.TextStyle(
                          fontSize: 10, color: PdfColors.black)),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

pw.Padding contentOfInvoice(pw.Widget table) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Column(children: [
      pw.Text(
          "Dear Customer, thank you for buying our product, we hope the products can make your day."),
      pw.SizedBox(height: 3),
      table,
      pw.Text("Thanks for your trust, and till the next time."),
      pw.SizedBox(height: 3),
      pw.Text("Kind regards"),
      pw.SizedBox(height: 3),
      pw.Text("1008"),
    ]),
  );
}

pw.Padding barcodeKotak(String id) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(horizontal: 1, vertical: 5),
    child: pw.Center(
      child: pw.BarcodeWidget(
        barcode: pw.Barcode.qrCode(
          errorCorrectLevel: BarcodeQRCorrectionLevel.high,
        ),
        data: id,
        width: 100,
        height: 100,
      ),
    ),
  );
}

pw.Center footerPDF(String formattedDate) {
  return pw.Center(
      child: pw.Text('Created At $formattedDate',
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.white)));
}
