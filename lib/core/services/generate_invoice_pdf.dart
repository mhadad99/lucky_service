import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../features/data/models/invoice_model.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  directory.create(recursive: false);
  return directory.path;
}

class GeneratePDF {
  Future<void> generateInvoicePdf(
      InvoiceModel invoiceModel, int enteredIva, String total) async {
    final pdf = pw.Document();
    double iva = double.parse(total) * (enteredIva / 100);
    double finalTotal = double.parse(total) + iva;
    int id = 0;

    String indexOfColumn() {
      return "${++id}";
    }

    final columnWidths = {
      0: const pw.FixedColumnWidth(
          40), // Fixed width of 100 for the first column
      1: const pw.FlexColumnWidth(), // Fixed width of 100 for the first column
      2: const pw.FixedColumnWidth(
          60), // Fixed width of 80 for the third column
      3: const pw.FixedColumnWidth(
          60), // Fixed width of 80 for the third column
      4: const pw.FixedColumnWidth(
          60), // Fixed width of 80 for the third column
      5: const pw.FixedColumnWidth(
          60), // Fixed width of 80 for the third column
      // ... add widths for other columns as needed
    };

    // Add content to the PDF document, including the table
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.SizedBox(
              width: double.infinity,
              child: pw.Text('LUCKY SERVICE',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 45),
                  textAlign: pw.TextAlign.center),
            ),
            pw.SizedBox(
              width: double.infinity,
              child: pw.Text('via spalato, 2, Milano',
                  style: pw.TextStyle(fontSize: 12),
                  textAlign: pw.TextAlign.center),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              'luckyservice.edile@gmail.com',
              style: pw.TextStyle(
                  fontSize: 12, fontItalic: pw.Font(), color: PdfColors.blue),
            ),
            pw.SizedBox(height: 4), // Add some spacing
            pw.Text(
                'Milano ${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}',
                style: pw.TextStyle(fontSize: 12)),
            pw.Row(children: [
              pw.Text("preventivo ${invoiceModel.id}"),
              pw.Spacer(),
              pw.Text("Committente: ${invoiceModel.name}"),
            ]),

            pw.SizedBox(height: 20), // Add some spacing
            pw.Center(
              child: pw.TableHelper.fromTextArray(
                columnWidths: columnWidths,
                context: context,
                data: <List<String>>[
                  <String>[
                    "N",
                    'Descrizione',
                    'u.d.m',
                    'quantita',
                    'importo u.',
                    'importo t.'
                  ],
                  ...invoiceModel.services.map((item) => [
                        (indexOfColumn()),
                        item.disc,
                        item.udm,
                        item.quantity.toString(),
                        item.price.toString(),
                        "${item.total.toString()}",
                      ]),
                  <String>[" \n ", " ", " ", " "],
                  if (enteredIva > 0)
                    <String>[
                      "",
                      "Totale Preventivo +IVA",
                      "",
                      "",
                      "",
                      "$total"
                    ],
                  if (enteredIva > 0)
                    <String>[
                      "",
                      "IVA",
                      "",
                      "",
                      "$enteredIva.00%",
                      (iva.toStringAsFixed(2))
                    ],
                  <String>[
                    "",
                    "Totale Preventivo compreso iva",
                    "",
                    "",
                    "",
                    "${finalTotal.toString()}"
                  ],
                ],
              ),
            )
          ];
        },
      ),
    );

    // Save or share the PDF document
    final path = await _localPath;

    // Create a file with a unique name (e.g., using a timestamp)
    final file = File('$path\\invoice_${invoiceModel.name}.pdf');

    // Save the PDF to the file
    await file.writeAsBytes(await pdf.save());

    // Optionally, you can print the file path for debugging
    print('PDF saved to: ${file.path}');

    OpenFile.open(file.path);
  }
}
