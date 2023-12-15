import 'package:donaciones/kernel/models/annexes.dart';

class Route {
  String id;
  String name;
  String reference;
  String nameLinkPerson;
  List<String> phones;
  String status;
  Annexes? annexes;
  DateTime? dateEnd;

  Route({
    required this.id,
    required this.name,
    required this.reference,
    required this.nameLinkPerson,
    required this.phones,
    required this.status,
    this.annexes,
    this.dateEnd,
  });

  String get acronym => name.substring(0, 2).toUpperCase();

  static Route fromMap(Map<String, dynamic> map) => Route(
    id: (map['_id'] ?? map['id'])!,
    name: map['name']!,
    reference: map['reference']!,
    nameLinkPerson: map['nameLinkPerson']!,
    phones: map['phones']!.whereType<String>().toList(),
    status: map['status']!,
    annexes: map['annexes'] != null ? Annexes.fromMap(map['annexes']) : null,
    dateEnd: map['dateEnd'] != null ? DateTime.parse(map['dateEnd']) : null,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'reference': reference,
    'nameLinkPerson': nameLinkPerson,
    'phones': phones,
    'status': status,
    'annexes': annexes?.toMap(),
    'dateEnd': dateEnd?.toIso8601String(),
  };
}
