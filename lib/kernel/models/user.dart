class User {
  String id;
  String name;
  String lastname;
  String? secondSurname;
  String email;
  String role;
  String phone;
  bool status;

  User({
    required this.id,
    required this.name,
    required this.lastname,
    this.secondSurname,
    required this.email,
    required this.role,
    required this.phone,
    required this.status,
  });

  String get fullname => '$name $lastname${secondSurname != null ? ' $secondSurname' : ''}';
  String get acronym => '${name[0]}${lastname[0]}'.toUpperCase();

  static User fromMap(Map<String, dynamic> map) => User(
    id: (map['_id'] ?? map['id'])!,
    name: map['name']!,
    lastname: map['lastname']!,
    secondSurname: map['secondSurname'],
    email: map['email']!,
    role: map['role']!,
    phone: map['phone']!,
    status: map['status']!,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'lastname': lastname,
    'secondSurname': secondSurname,
    'email': email,
    'role': role,
    'phone': phone,
    'status': status,
  };
}
