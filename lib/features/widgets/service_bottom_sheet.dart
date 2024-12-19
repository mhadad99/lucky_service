import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucky_service/features/data/cubit/my_app_cubit.dart';
import 'package:lucky_service/features/data/models/invoice_model.dart';
import 'package:lucky_service/features/data/models/service_model.dart';

class ServiceBottomSheet extends StatefulWidget {
  const ServiceBottomSheet({super.key, required this.invoiceModel});
  final InvoiceModel invoiceModel;

  @override
  State<ServiceBottomSheet> createState() => _ServiceBottomSheetState();
}

class _ServiceBottomSheetState extends State<ServiceBottomSheet> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController subController = TextEditingController();
  TextEditingController udmController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Add New Service"),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Description"),
                ),
                controller: subController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "اكتب يسطا هنا اي حاجة عيب ";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("U.D.M"),
                ),
                controller: udmController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "اكتب يسطا هنا اي حاجة عيب";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Quantity"),
                ),
                controller: quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "اكتب يسطا هنا اي حاجة عيب";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Price"),
                ),
                controller: priceController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Don't small us يا عم محمد عيب";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context.read<MyAppCubit>().addService(
                        ServiceModel(
                          disc: subController.text,
                          udm: udmController.text,
                          quantity: int.parse(quantityController.text),
                          price: double.parse(priceController.text),
                          total: int.parse(quantityController.text) *
                              double.parse(priceController.text),
                        ),
                        widget.invoiceModel);
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
      ),
    );
  }
}
