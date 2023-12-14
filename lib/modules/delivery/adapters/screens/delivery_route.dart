import 'package:dio/dio.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/delivery/adapters/widgets/delivery_route_container.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryRoute extends StatefulWidget {
  final String idDelivery;
  const DeliveryRoute({super.key, required this.idDelivery});

  @override
  State<DeliveryRoute> createState() => _DeliveryRouteState();
}

class _DeliveryRouteState extends State<DeliveryRoute> {
  final Map<String, dynamic> item = {
    'number': '1',
    'title': 'Otilio Montaño',
    'acronimous': 'OM',
    'name': 'Luis Perez',
    'phone': '7771234567',
    'address': 'Calle Otilio Motaño # 234',
    'references':
        'Parque sdjgfkasgdfkgasdfhgashdfjsadvjvsdachjvwsaegflweqfguigsadjhfsahvdfasdjfyawegflywfhvsdfv,safd,absfdawyerfyauwrvfjhz'
  };
  final Map<String, dynamic> item2 = {
    'number': '2',
    'title': '3 De Mayo',
    'acronimous': '3M',
    'name': 'Luis Perez',
    'phone': '7771234567',
    'address': 'Calle Otilio Motaño # 234',
    'references': 'Parque'
  };

  List<dynamic> items = [];

  final dio = Dio();
  Future<void> init() async {
    Response response;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Impresion del ideDelievry');
    print(widget.idDelivery);
    var token = await prefs.getString('token')!;
    response = await dio.get(
        'http://192.168.43.79:3000/api/deliveries/${widget.idDelivery}',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    setState(() {
      items = response.data['data']['delivery']['routes']
          .asMap()
          .entries
          .map((entry) {
        int idx = entry.key;
        dynamic val = entry.value;
        return {
          'name': val['name'],
          'acronimous': val['name'].substring(0, 2).toUpperCase(),
          'reference': val['reference'],
          'idDelivery': widget.idDelivery,
          'index': idx,
          'personName': val['nameLinkPerson'],
          'phones': val['phones'],
          'status': val['status'],
          'isAnnexes': val['annexes'] != null &&
              val['annexes']['commentary'] != null &&
              val['annexes']['photos'] != null,
        };
      }).toList();
    });
    print('imprimeira las deliveries');
    print(response.data['data']['delivery']['routes']);
    print(response.data['data']['delivery']['routes'].runtimeType);
  }

  @override
  void initState() {
    print('Hello wolrd');
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ruta de entrega'),
        backgroundColor: ColorsApp.prmaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: items
              .map((e) => DeliveryRouteContainer(
                    tittle: e['name'],
                    acronimous: e['acronimous'],
                    references: e['reference'],
                    name: e['personName'],
                    phones: e['phones'].whereType<String>().toList(),
                    status: e['status'],
                    index: e['index'],
                    idDelivery: e['idDelivery'],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
