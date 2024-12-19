import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucky_service/features/data/cubit/my_app_cubit.dart';
import 'package:lucky_service/features/data/models/invoice_model.dart';

class ServiceBody extends StatelessWidget {
  const ServiceBody({super.key, required this.invoiceModel});
  final InvoiceModel invoiceModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAppCubit, MyAppState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: invoiceModel.services.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    child: Text((index + 1).toString()),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * .4,
                            child: Text(invoiceModel.services[index].disc)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("u.d.m"),
                            Text(invoiceModel.services[index].udm),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Quantity"),
                            Text(invoiceModel.services[index].quantity
                                .toString()),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Importo unit"),
                            Text(invoiceModel.services[index].price.toString()),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Total"),
                          Text(invoiceModel.services[index].total.toString()),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<MyAppCubit>().deleteService(
                          invoiceModel.services[index], invoiceModel);
                    },
                    icon: Icon(FontAwesomeIcons.trash),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total of Invoice",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    context
                        .read<MyAppCubit>()
                        .calculateTotalOfInvoice(invoiceModel)
                        .toString(),
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
