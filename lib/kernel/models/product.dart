import 'package:donaciones/kernel/models/annexes.dart';

class Product {
  String id;
  String name;
  int quantity;
  bool? recolected;
  Annexes? annexes;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    this.recolected,
    this.annexes,
  });

  static Product fromMap(Map<String, dynamic> map) => Product(
    id: (map['_id'] ?? map['id'])!,
    name: map['name']!,
    quantity: map['quantity']!,
    recolected: map['recolected'],
    annexes: map['annexes'] != null ? Annexes.fromMap(map['annexes']) : null,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'quantity': quantity,
    'recolected': recolected,
    'annexes': annexes?.toMap(),
  };
}
