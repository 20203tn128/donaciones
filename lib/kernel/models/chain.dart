class Chain {
  List<String> phones;
  String id;
  String name;
  String address;
  String nameLinkPerson;
  bool status;

  Chain({
    required this.phones,
    required this.id,
    required this.name,
    required this.address,
    required this.nameLinkPerson,
    required this.status,
  });

  static Chain fromMap(Map<String, dynamic> map) => Chain(
    phones: map['phones']!.whereType<String>().toList(),
    id: (map['_id'] ?? map['id'])!,
    name: map['name']!,
    address: map['address']!,
    nameLinkPerson: map['nameLinkPerson']!,
    status: map['status']!,
  );

  Map<String, dynamic> toMap() => {
    'phones': phones,
    'id': id,
    'name': name,
    'address': address,
    'nameLinkPerson': nameLinkPerson,
    'status': status,
  };
}