import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucky_service/core/services/generate_invoice_pdf.dart';
import 'package:lucky_service/features/data/cubit/my_app_cubit.dart';
import 'package:lucky_service/features/data/models/invoice_model.dart';

import '../widgets/service_body.dart';
import '../widgets/service_bottom_sheet.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key, required this.invoiceModel});
  final InvoiceModel invoiceModel;

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  TextEditingController ivaController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.invoiceModel.name),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(4)),
                      height: 200,
                      width: MediaQuery.sizeOf(context).width * .3,
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.warning_amber,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("Please, Enter IVA"),
                                  //TextFormField(decoration: InputDecoration())
                                ],
                              ),
                              TextFormField(
                                controller: ivaController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "يعم عيب عليك";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                              ),
                              TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      Navigator.pop(context);
                                      GeneratePDF().generateInvoicePdf(
                                          widget.invoiceModel,
                                          int.parse(ivaController.text),
                                          context
                                              .read<MyAppCubit>()
                                              .calculateTotalOfInvoice(
                                                  widget.invoiceModel)
                                              .toString());
                                    }
                                  },
                                  child: const Text("Ok"))
                            ],
                          ),
                        ),
                      )),
                ),
              );
            },
            child: Text("My Invoice"),
          )
        ],
      ),
      body: ServiceBody(
        invoiceModel: widget.invoiceModel,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => ServiceBottomSheet(
              invoiceModel: widget.invoiceModel,
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
