import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lucky_service/features/data/models/invoice_model.dart';
import 'package:lucky_service/features/data/models/service_model.dart';
import 'package:meta/meta.dart';

part 'my_app_state.dart';

class MyAppCubit extends Cubit<MyAppState> {
  MyAppCubit() : super(MyAppInitial());

  var invoicesBox = Hive.box<InvoiceModel>("invoices");
  List<InvoiceModel> invoices = [];
  bool isDark = false;
  int id = 1;
  fetchAllInvoices() async {
    invoices = invoicesBox.values.toList();
    isDark = Hive.box<bool>("isDark").get("theme") ?? false;
    id = Hive.box<int>("idCounter").get("id") ?? 1;

    emit(MyAppAddInvoice());
  }

  void addInvoice(InvoiceModel invoice) {
    invoices.add(invoice);
    invoicesBox.add(invoice);
    id++;
    Hive.box<int>("idCounter").put("id", id);
    emit(MyAppAddInvoice());
  }

  void deleteInvoice(InvoiceModel invoice) {
    invoices.remove(invoice);
    invoice.delete();
    emit(MyAppAddInvoice());
  }

  void addService(ServiceModel service, InvoiceModel invoice) {
    invoice.services.add(service);
    invoice.save();
    emit(MyAppAddServices());
  }

  void deleteService(ServiceModel service, InvoiceModel invoice) {
    invoice.services.remove(service);
    invoice.save();

    emit(MyAppAddServices());
  }

  double calculateTotalOfInvoice(InvoiceModel invoice) {
    double sum = 0;
    for (ServiceModel serviceModel in invoice.services) {
      sum += serviceModel.total ?? 0;
    }
    return sum;
  }

  void changeTheme() {
    isDark = !isDark;
    Hive.box<bool>("isDark").put("theme", isDark);
    emit(MyAppChangeTheme());
  }
}
