import 'dart:convert';

import 'package:donaciones/kernel/models/annexes.dart';
import 'package:donaciones/kernel/models/delivery.dart';
import 'package:donaciones/kernel/models/response.dart';
import 'package:donaciones/kernel/models/route.dart';
import 'package:donaciones/kernel/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryService {
  final ApiService _apiService = ApiService();

  Future<List<Delivery>> get({
    int page = 1,
    int rowsPerPage = 10,
    String? order,
    String? orderBy,
    String? filter,
    String? filterBy,
  }) async {
    Map<String, dynamic> params = {
      'page': page,
      'rowsPerPage': rowsPerPage,
    };

    if (order != null && orderBy != null) {
      params['order'] = order;
      params['orderBy'] = orderBy;
    }

    if (filter != null && filterBy != null) {
      params['filter'] = filter;
      params['filterBy'] = filterBy;
    }

    final response =
        await _apiService.get('/deliveries', queryParameters: params);

    final res = Response.fromMap(response.data);

    return res.data['deliveries']!
        .map((map) => Delivery.fromMap(map))
        .whereType<Delivery>()
        .toList();
  }

  Future<Delivery> getById(String id) async {
    final response = await _apiService.get('/deliveries/$id');

    final res = Response.fromMap(response.data);

    return Delivery.fromMap(res.data['delivery']!);
  }

  Future<bool> start(String id) async {
    final response = await _apiService.patch('/deliveries/start/$id');

    final res = Response.fromMap(response.data);

    print(response);

    if (res.statusCode != 200) return false;

    setOffline(await getById(id));

    return true;
  }

  Future<bool> end(String id, List<Route> routes) async {
    final response = await _apiService.patch('/deliveries/end/$id', data: {
      'routes': routes.map((route) => {
            'id': route.id,
            'name': route.name,
            'refrence': route.reference,
            'nameLinkPerson': route.nameLinkPerson,
            'phones': route.phones,
            'status': route.status,
            'annexes': {
              'commentary': route.annexes!.commentary,
              'photos': route.annexes!.photos,
            },
            'dateEnd': DateTime.now().toIso8601String(),
          })
    });

    final res = Response.fromMap(response.data);

    return res.statusCode == 200;
  }

  Future<bool> cancel(String id, Annexes generalAnnexes) async {
    final response = await _apiService.patch('/deliveries/cancel/$id', data: {
      'generalAnnexes': {
        'commentary': generalAnnexes.commentary,
        'photos': generalAnnexes.photos,
      },
      'dateEnd': DateTime.now().toIso8601String(),
    });

    final res = Response.fromMap(response.data);

    return res.statusCode == 200;
  }

  Future<Delivery?> getOffline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('offline_delivery');

    if (json == null) return null;

    return Delivery.fromMap(jsonDecode(json));
  }

  Future<void> setOffline(Delivery delivery) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final json = jsonEncode(delivery.toMap());

    await prefs.setString('offline_delivery', json);
  }

  Future<void> sync() async {
    final delivery = await getOffline();

    if (delivery == null ||
        delivery.status == 'Pendiente' ||
        delivery.status == 'En proceso') return;

    if (delivery.status == 'Finalizada') {
      await end(delivery.id, delivery.routes);
    } else if (delivery.status == 'Cancelada') {
      await cancel(delivery.id, delivery.generalAnnexes!);
    }
  }
}
