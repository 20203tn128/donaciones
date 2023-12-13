import 'package:donaciones/kernel/models/annexes.dart';
import 'package:donaciones/kernel/models/route.dart';
import 'package:donaciones/kernel/models/user.dart';

class Delivery {
  String id;
  String name;
  List<Route> routes;
  User user;
  DateTime date;
  String status;
  Annexes? generalAnnexes;

  Delivery({
    required this.id,
    required this.name,
    required this.routes,
    required this.user,
    required this.date,
    required this.status,
    this.generalAnnexes,
  });
  String get acronym => name.substring(0, 2).toUpperCase();

  static Delivery fromMap(Map<String, dynamic> map) => Delivery(
        id: (map['_id'] ?? map['id'])!,
        name: map['name']!,
        routes: map['routes']!
            .map((map) => Route.fromMap(map))
            .whereType<Route>()
            .toList(),
        user: User.fromMap(map['user']!),
        date: DateTime.parse(map['date']!),
        status: map['status']!,
        generalAnnexes: map['generalAnnexes'] != null
            ? Annexes.fromMap(map['generalAnnexes'])
            : null,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'routes': routes.map((route) => route.toMap()).toList(),
        'user': user.toMap(),
        'date': date.toIso8601String(),
        'status': status,
        'generalAnnexes': generalAnnexes?.toMap(),
      };
}
