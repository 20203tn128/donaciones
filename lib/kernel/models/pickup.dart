import 'package:donaciones/kernel/models/annexes.dart';
import 'package:donaciones/kernel/models/chain.dart';
import 'package:donaciones/kernel/models/product.dart';
import 'package:donaciones/kernel/models/user.dart';

class Pickup {
  String id;
  String name;
  DateTime date;
  String status;
  Chain chain;
  List<Product> products;
  Annexes? generalAnnexes;
  User user;
  
  Pickup({
    required this.id,
    required this.name,
    required this.date,
    required this.status,
    required this.chain,
    required this.products,
    this.generalAnnexes,
    required this.user,
  });

  String get acronym => name.substring(0, 2).toUpperCase();

  static Pickup fromMap(Map<String, dynamic> map) => Pickup(
    id: (map['_id'] ?? map['id'])!,
    name: map['name']!,
    date: DateTime.parse(map['date']!),
    status: map['status']!,
    chain: Chain.fromMap(map['chain']!),
    products: map['products']!.map((map) => Product.fromMap(map)).whereType<Product>().toList(),
    generalAnnexes: map['generalAnnexes'] != null ? Annexes.fromMap(map['generalAnnexes']!) : null,
    user: User.fromMap(map['user']!),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'date': date.toIso8601String(),
    'status': status,
    'chain': chain.toMap(),
    'products': products.map((product) => product.toMap()).toList(),
    'generalAnnexes': generalAnnexes?.toMap(),
    'user': user.toMap(),
  };
}