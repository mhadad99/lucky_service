import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucky_service/features/data/cubit/my_app_cubit.dart';
import 'package:lucky_service/features/data/models/invoice_model.dart';

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({super.key});

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  TextEditingController invoiceName = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Add New Invoice"),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Invoice Name"),
              ),
              controller: invoiceName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "اكتب يسطا اسم الفاتورة عيب";
                }
                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  context.read<MyAppCubit>().addInvoice(InvoiceModel(
                      name: invoiceName.text,
                      id: "${context.read<MyAppCubit>().id}"));
                  Navigator.pop(context);
                }
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.green),
                width: MediaQuery.sizeOf(context).width,
                child: Text(
                  "Add",
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
