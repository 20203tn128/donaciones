import 'dart:convert';

import 'package:donaciones/kernel/models/annexes.dart';
import 'package:donaciones/kernel/models/pickup.dart';
import 'package:donaciones/kernel/models/product.dart';
import 'package:donaciones/kernel/models/response.dart';
import 'package:donaciones/kernel/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PickupService {
  final ApiService _apiService = ApiService();

  Future<List<Pickup>> get({
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

    final response = await _apiService.get('/pickups', queryParameters: params);

    final res = Response.fromMap(response.data);

    return res.data['pickups']!.map((map) => Pickup.fromMap(map)).whereType<Pickup>().toList();
  }

  Future<Pickup> getById(String id) async {
    final response = await _apiService.get('/pickups/$id');

    final res = Response.fromMap(response.data);

    return Pickup.fromMap(res.data['pickup']!);
  }

  Future<bool> start(String id) async {
    final response = await _apiService.patch('/pickups/start/$id');

    final res = Response.fromMap(response.data);

    if (res.statusCode != 200) return false;

    setOffline(await getById(id));

    return true;
  }

  Future<bool> end(String id, List<Product> products) async {
    final response = await _apiService.patch('/pickups/end/$id', data: {
      'products': products.map((product) => {
        'id': product.id,
        'name': product.name,
        'quantity': product.quantity,
        'annexes': product.annexes != null
          ? {
              'commentary': product.annexes!.commentary,
              'photos': product.annexes!.photos,
            }
          : null,
        'recolected': product.recolected ?? false,
      }).toList()
    });

    final res = Response.fromMap(response.data);

    return res.statusCode == 200;
  }

  Future<bool> cancel(String id, Annexes generalAnnexes) async {
    final response = await _apiService.patch('/pickups/cancel/$id', data: {
      'generalAnnexes': {
        'commentary': generalAnnexes.commentary,
        'photos': generalAnnexes.photos,
      }
    });

    final res = Response.fromMap(response.data);

    return res.statusCode == 200;
  }

  Future<Pickup?> getOffline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('offline_pickup');
    if (json == null) return null;
    return Pickup.fromMap(jsonDecode(json));
  }

  Future<void> setOffline(Pickup pickup) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(pickup.toMap());
    await prefs.setString('offline_pickup', json);
  }

  Future<void> clearOffline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('offline_pickup');
  }

  Future<void> sync() async {
    final pickup = await getOffline();

    if (pickup == null || pickup.status == 'Pendiente' || pickup.status == 'En proceso') return;

    if (pickup.status == 'Finalizada') {
      await end(pickup.id, pickup.products);
    } else if (pickup.status == 'Cancelada') {
      await cancel(pickup.id, pickup.generalAnnexes!);
    }

    await clearOffline();
  }
}
