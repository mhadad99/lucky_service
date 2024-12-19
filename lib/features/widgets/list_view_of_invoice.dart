import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucky_service/features/data/cubit/my_app_cubit.dart';
import 'package:lucky_service/features/screens/service_screen.dart';

class ListViewOfInvoice extends StatelessWidget {
  const ListViewOfInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAppCubit, MyAppState>(
      builder: (context, state) {
        return ListView.builder(
          padding: EdgeInsets.all(8),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceScreen(
                          invoiceModel:
                              context.read<MyAppCubit>().invoices[index]),
                    ));
              },
              leading: CircleAvatar(
                child: Text(context.read<MyAppCubit>().invoices[index].id),
              ),
              title: Text(context.read<MyAppCubit>().invoices[index].name),
              trailing: IconButton(
                onPressed: () {
                  context.read<MyAppCubit>().deleteInvoice(
                      context.read<MyAppCubit>().invoices[index]);
                },
                icon: Icon(FontAwesomeIcons.trash),
              ),
            ),
          ),
          itemCount: context.read<MyAppCubit>().invoices.length,
        );
      },
    );
  }
}
