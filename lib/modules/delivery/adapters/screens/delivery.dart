import 'package:dio/dio.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/delivery/adapters/widgets/delivery_container.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Delivery extends StatefulWidget {
  const Delivery({super.key});

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  final Map<String, dynamic> item = {
    'title': 'Chedraui',
    'acronimous': 'CH',
    'date': '12 de Noviembre del 2023',
  };
  final Map<String, dynamic> item2 = {
    'title': 'Walmart',
    'acronimous': 'WL',
    'date': '15 de Diciembre del 2023',
  };

  List<dynamic> items = [];

  final dio = Dio();
  Future<void> init() async {
    Response response;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token')!;
    response = await dio.get('http://192.168.0.44:3000/deliveries',
        queryParameters: {'page': 1, 'rowsPerPage': 10},
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    setState(() {
      items = response.data['data']['deliveries']
          .map((e) => {
                'title': e['name'],
                'acronimous': e['name'].substring(0, 2).toUpperCase(),
                'status': e['status'],
                'date': DateTime.parse(e['date']),
                'idDelivery': e['id'],
              })
          .toList();
    });
    print('Esto es lo que esta imprimiendo');
    print(response.data['data']['deliveries']);
    print(response.data['data']['deliveries'].runtimeType);
  }

  @override
  void initState() {
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repartos'),
        backgroundColor: ColorsApp.prmaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            Row(
              children: [
                Text("Buscar"),
                Expanded(child: TextField()),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                )
              ],
            ),
            Column(
                children: items
                    .map((e) => DeliveryContainer(
                          tittle: e['title'],
                          acronimous: e['acronimous'],
                          date: e['date'],
                          idDelivery: e['idDelivery'],
                          status: e['status'],
                        ))
                    .toList()),
          ]),
        ),
      ),
    );
  }
}
