import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:lucky_service/features/data/cubit/my_app_cubit.dart';
import 'package:lucky_service/features/widgets/home_body.dart';

import '../widgets/my_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController invoiceNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lucky Services"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                context.read<MyAppCubit>().changeTheme();
              },
              icon: Icon(Icons.sunny),
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4)),
                          height: 200,
                          width: MediaQuery.sizeOf(context).width * .3,
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
                                    Text("Please, Enter New Invoice Number"),
                                    //TextFormField(decoration: InputDecoration())
                                  ],
                                ),
                                TextFormField(
                                  controller: invoiceNumberController,
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
                                      Navigator.pop(context);
                                      context.read<MyAppCubit>().id = int.parse(
                                          invoiceNumberController.text);
                                      Hive.box<int>("idCounter").put(
                                          "id", context.read<MyAppCubit>().id);
                                    },
                                    child: const Text("Ok"))
                              ],
                            ),
                          )),
                    ),
                  );
                },
                icon: Icon(Icons.reorder_outlined))
          ],
        ),
        body: HomeBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => MyBottomSheet(),
            );
          },
          child: Icon(Icons.add),
        ));
  }
}
