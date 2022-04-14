import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'data/drift_database.dart';

void createAndSavePdf(var itemData, Client client) async {
  // Date Formatting
  List<String> dateElements =
      DateTime.now().toString().split(" ")[0].split('-');
  final date = dateElements[2] + "-" + dateElements[1] + "-" + dateElements[0];

  print("Button Pressed");
  final pdf = pw.Document();

  final logo = pw.MemoryImage(
    File('assets/bds-logo.png').readAsBytesSync(),
  );

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Column(
            children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(logo, width: 80),
                    pw.Text('INVOICE', style: const pw.TextStyle(fontSize: 30)),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            "Bharat Diesel Service",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text("Address Line 1"),
                          pw.Text("Address Line 2"),
                          pw.Text("Pin Code"),
                          pw.Text("Contact Number"),
                        ])
                  ]),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.SizedBox(height: 20),

              //Client Name and Invoice Number/Date
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(client.name,
                          style: pw.TextStyle(
                              fontSize: 20, fontWeight: pw.FontWeight.bold)),
                      pw.Text("Item Description",
                          style: const pw.TextStyle(fontSize: 16))
                    ],
                  ),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text("Invoice#"),
                            pw.Text("Fiche No#"),
                            pw.Text("Invoice Date"),
                          ]),
                      pw.SizedBox(width: 20),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("BDS-01"),
                            pw.Text("002"),
                            pw.Text(date)
                          ]),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 40),

              // Item Descriptions Heading
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Row(children: [
                        pw.Text("#",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 12)),
                        pw.SizedBox(width: 40),
                        pw.Text("ITEM DESCRIPTION",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 12)),
                      ]),
                      pw.Text("AMOUNT",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 12)),
                    ]),
              ),
              pw.Divider(),
              // Actual items data
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: pw.ListView.builder(
                    itemBuilder: (context, index) => pw.Column(children: [
                          pw.Wrap(children: [
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Row(children: [
                                    pw.Text(itemData[index]["id"].toString(),
                                        style:
                                            const pw.TextStyle(fontSize: 12)),
                                    pw.SizedBox(width: 40),
                                    pw.Text(itemData[index]["desc"].toString(),
                                        style:
                                            const pw.TextStyle(fontSize: 12)),
                                  ]),
                                  pw.Text(itemData[index]["amount"].toString(),
                                      style: const pw.TextStyle(fontSize: 12)),
                                ]),
                            pw.SizedBox(height: 8),
                          ]),
                        ]),
                    itemCount: itemData.length),
              ),
            ],
          )
        ]; // Center
      },
    ),
  ); // Page

  // Saving the file
  final output = await getApplicationDocumentsDirectory();
  final file = File("${output.path}/example.pdf");
  await file.writeAsBytes(await pdf.save());
}
