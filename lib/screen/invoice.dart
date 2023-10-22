// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../utils/util.dart';
import 'package:printing/printing.dart';

class Invoice extends StatefulWidget {
  Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  final pdf = pw.Document();

  @override
  // Pdf .................................
  void initState() {
    super.initState();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Padding(
            padding: pw.EdgeInsets.all(16.0),
            child: pw.Column(
              children: [
                // Invoice header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text(
                          'Invoice',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 28),
                        ),
                        pw.Divider(
                          thickness: 2,
                          color: PdfColors.black,
                        ),
                        pw.SizedBox(
                          height: 20,
                        ),
                        pw.Text(
                          'Royal Roy 36',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 16),
                        ),
                        pw.Text(
                          'Bravo Street S,',
                          style: pw.TextStyle(fontSize: 16),
                        ),
                        pw.Text(
                          'jakarta, indonesia 2850',
                          style: pw.TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 50),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          pw.Row(
                            children: [
                              pw.Text(
                                'INVOICE      2020-123',
                                style: pw.TextStyle(
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ],
                          ),
                          pw.Divider(thickness: 2, color: PdfColors.black),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                            children: [
                              pw.Text(
                                'Item',
                                style: pw.TextStyle(
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                              pw.Text(
                                'Product Name',
                                style: pw.TextStyle(
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                              pw.Text(
                                'Qty',
                                style: pw.TextStyle(
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                              pw.Text(
                                'Price/per',
                                style: pw.TextStyle(
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                              pw.Text(
                                'Total',
                                style: pw.TextStyle(
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ],
                          ),
                          pw.Divider(thickness: 2, color: PdfColors.black),
                          ...Global.cartProducts.map((e) {
                            count++;
                            return pw.Column(
                              children: [
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceAround,
                                  children: [
                                    pw.Text(
                                      '$count',
                                      style: pw.TextStyle(fontSize: 16),
                                    ),
                                    pw.SizedBox(
                                      width: 100,
                                      child: pw.Text(
                                        '${e['title']}',
                                        style: pw.TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    pw.Text(
                                      '${e['stock']}',
                                      style: pw.TextStyle(fontSize: 16),
                                    ),
                                    pw.Text(
                                      '${e['price']}',
                                      style: pw.TextStyle(fontSize: 16),
                                    ),
                                    pw.Text(
                                      '${e['subTotal']}',
                                      style: pw.TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                pw.Divider(
                                    thickness: 2, color: PdfColors.black),
                              ],
                            );
                          }).toList(),
                          pw.SizedBox(
                            height: 30,
                          ),
                          pw.Row(
                            children: [
                              pw.SizedBox(
                                width: 90,
                              ),
                              pw.Expanded(
                                child: pw.Table(
                                  children: [
                                    pw.TableRow(
                                      children: [
                                        pw.Text(
                                          'Sub-total',
                                          style: pw.TextStyle(
                                              fontSize: 16,
                                              fontWeight: pw.FontWeight.bold),
                                        ),
                                        pw.Text(
                                          '${Global.subsum}',
                                          style: pw.TextStyle(
                                              fontSize: 16,
                                              fontWeight: pw.FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    pw.TableRow(
                                      children: [
                                        pw.Text(
                                          'Tax',
                                          style: pw.TextStyle(
                                              fontSize: 16,
                                              fontWeight: pw.FontWeight.bold),
                                        ),
                                        pw.Text(
                                          '${Global.discount}',
                                          style: pw.TextStyle(
                                              fontSize: 16,
                                              fontWeight: pw.FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    pw.TableRow(
                                      children: [
                                        pw.Text(
                                          'Amount due',
                                          style: pw.TextStyle(
                                              fontSize: 16,
                                              fontWeight: pw.FontWeight.bold),
                                        ),
                                        pw.Text(
                                          '${Global.finalsum}',
                                          style: pw.TextStyle(
                                              fontSize: 16,
                                              fontWeight: pw.FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() async {
                Directory? res = await getExternalStorageDirectory();

                String path = res!.path;

                File file = File('$path/resume.pdf');

                await file.writeAsBytes(await pdf.save()).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      content: Text("Saved successfully"),
                    ),
                  );
                });
              });
            },
            child: const Icon(Icons.download),
          ),
          FloatingActionButton(
            onPressed: () async {
              Printing.layoutPdf(onLayout: (format) {
                return pdf.save();
              });
            },
            child: const Icon(Icons.print),
          ),
        ],
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Invoice header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        'Invoice',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Royal Roy 36',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        'Bravo Street S,',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        'jakarta, indonesia 2850',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'INVOICE      2020-123',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Divider(thickness: 2, color: Colors.black),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Item',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Product Name',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Qty',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Price/per',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Total',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Divider(thickness: 2, color: Colors.black),
                        ...Global.cartProducts.map((e) {
                          count++;
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '$count',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      '${e['title']}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    '${e['stock']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${e['price']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${e['subTotal']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Divider(thickness: 2, color: Colors.black),
                            ],
                          );
                        }).toList(),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 90,
                            ),
                            Expanded(
                              child: Table(
                                children: [
                                  TableRow(
                                    children: [
                                      Text(
                                        'Sub-total',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${Global.subsum}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text(
                                        'Tax',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${Global.discount}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Text(
                                        'Amount due',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${Global.finalsum}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
