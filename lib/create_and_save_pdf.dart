import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:winapp/data/models/invoice_items.dart';

import 'data/drift_database.dart';

void createAndSavePdf(List<InvoiceItems> itemData, Client client) async {
  //Initialize HiveDB
  await Hive.initFlutter();
  var sequence = await Hive.openBox('sequences');
  if (sequence.get('invoice_no') == null) sequence.put('invoice_no', 0);
  if (sequence.get('fiche_no') == null) sequence.put('fiche_no', 0);

  int ficheNum = 0, invoiceNum = 0;

  if ((sequence.get('fiche_no') != null) &&
      (sequence.get('invoice_no') != null)) {
    ficheNum = sequence.get('fiche_no');
    invoiceNum = sequence.get('fiche_no');
    ficheNum++;
    invoiceNum++;
    sequence.put('invoice_no', invoiceNum);
    sequence.put('fiche_no', invoiceNum);
  }

  // Date Formatting
  List<String> dateElements =
      DateTime.now().toString().split(" ")[0].split('-');
  final date = dateElements[2] + "-" + dateElements[1] + "-" + dateElements[0];

  double subtotal = 0;
  //tax percentage
  double taxper = 16;
  //total calculated tax
  double tax = 0;
  double total = 0;

  for (var item in itemData) {
    subtotal += (item.price! * item.quantity!);
  }

  tax = (subtotal * taxper) / 100;
  total = subtotal + tax;

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
                            "Bharat Diesel Service SARL",
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                          pw.Text("Marva Center"),
                          pw.Text("Lubumbashi"),
                          // pw.Text("Pin Code"),
                        ])
                  ]),
              pw.Text(
                  "License Number: CD/LSH/RCCM22-B-01913,IF-NAT 05-F4300-N03248T"),
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
                      // pw.Text("Item Description",
                      //     style: const pw.TextStyle(fontSize: 16))
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
                            pw.Text("BDS-$invoiceNum"),
                            pw.Text("$ficheNum"),
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
                        pw.SizedBox(width: 20),
                        pw.Text("ITEM DESCRIPTION",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 12)),
                      ]),
                      pw.Row(children: [
                        pw.Text("QUANTITY",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 12)),
                        pw.SizedBox(width: 20),
                        pw.Text("AMOUNT",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 12)),
                      ]),
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
                                    pw.Text("${index + 1}",
                                        style:
                                            const pw.TextStyle(fontSize: 12)),
                                    pw.SizedBox(width: 20),
                                    pw.Text(
                                        itemData[index]
                                                    .inventorie
                                                    .itemName
                                                    .toString()
                                                    .length >
                                                48
                                            ? itemData[index]
                                                    .inventorie
                                                    .itemName
                                                    .substring(0, 48) +
                                                "..."
                                            : itemData[index]
                                                .inventorie
                                                .itemName
                                                .toString(),
                                        softWrap: true,
                                        style:
                                            const pw.TextStyle(fontSize: 12)),
                                  ]),
                                  pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      mainAxisSize: pw.MainAxisSize.max,
                                      children: [
                                        pw.Text(
                                            itemData[index].quantity.toString(),
                                            style: const pw.TextStyle(
                                                fontSize: 12)),
                                        pw.SizedBox(width: 30),
                                        pw.Text(
                                            'USD ' +
                                                itemData[index]
                                                    .price
                                                    .toString(),
                                            style: const pw.TextStyle(
                                                fontSize: 12)),
                                      ])
                                ]),
                            pw.SizedBox(height: 8),
                          ]),
                        ]),
                    itemCount: itemData.length),
              ),
              pw.SizedBox(height: 8),
              pw.Divider(),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text("Subtotal",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 30),
                    pw.Text("USD $subtotal"),
                    pw.SizedBox(width: 8),
                  ],
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text("Tax@$taxper%",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 30),
                    pw.Text("USD $tax"),
                    pw.SizedBox(width: 8),
                  ],
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Divider(),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text("Total",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 30),
                    pw.Text("USD $total"),
                    pw.SizedBox(width: 8),
                  ],
                ),
              ),
              pw.Divider(),
            ],
          )
        ]; // Center
      },
    ),
  ); // Page

  // Saving the file
  final output = await getApplicationDocumentsDirectory();
  final file = File("${output.path}/${client.name}.pdf");
  await file.writeAsBytes(await pdf.save());
}
