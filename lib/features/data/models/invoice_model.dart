import 'package:hive/hive.dart';
import 'package:lucky_service/features/data/models/service_model.dart';

part 'invoice_model.g.dart'; // This part directive links to the generated adapter file for Services

@HiveType(typeId: 1)
class InvoiceModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  List<ServiceModel> services = [];

  InvoiceModel({
    required this.id,
    required this.name,
  });

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    services = <ServiceModel>[];
    json['services'].forEach((service) {
      services.add(ServiceModel.fromJson(service));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['services'] = services.map((v) => v.toJson()).toList();
    return data;
  }
}
