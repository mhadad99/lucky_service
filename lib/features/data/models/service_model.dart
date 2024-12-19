import 'package:hive/hive.dart';

part 'service_model.g.dart'; // This part directive links to the generated adapter file for Services

@HiveType(typeId: 0)
class ServiceModel extends HiveObject {
  @HiveField(0)
  late String disc;

  @HiveField(1)
  late String udm;

  @HiveField(2)
  late int quantity;

  @HiveField(3)
  late double price;

  @HiveField(4)
  double? total;

  ServiceModel({
    required this.disc,
    required this.udm,
    required this.quantity,
    required this.price,
    required this.total,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    disc = json['disc'];
    udm = json['udm'];
    quantity = json['quantity'];
    price = json['price'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['disc'] = disc;
    data['udm'] = udm;
    data['quantity'] = quantity;
    data['price'] = price;
    data['total'] = total;
    return data;
  }
}
