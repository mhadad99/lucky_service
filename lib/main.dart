import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lucky_service/features/data/cubit/my_app_cubit.dart';
import 'package:lucky_service/features/data/models/invoice_model.dart';
import 'package:lucky_service/features/data/models/service_model.dart';

import 'features/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(InvoiceModelAdapter());
  Hive.registerAdapter(ServiceModelAdapter());

  await Hive.openBox<InvoiceModel>("invoices");
  await Hive.openBox<bool>("isDark");
  await Hive.openBox<int>("idCounter");

  bool isDark = Hive.box<bool>("isDark").get("theme") ?? false;

  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isDark});
  final bool isDark;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAppCubit()..fetchAllInvoices(),
      child: BlocBuilder<MyAppCubit, MyAppState>(
        builder: (context, state) {
          return MaterialApp(
            theme: context.read<MyAppCubit>().isDark
                ? ThemeData()
                : ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
