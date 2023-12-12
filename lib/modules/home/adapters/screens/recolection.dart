import 'package:dio/dio.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/kernel/widgets/navigation/botton-navigation-tab.dart';
import 'package:donaciones/modules/home/widgets/home-container.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Recolection extends StatefulWidget {
  const Recolection({super.key});

  @override
  State<Recolection> createState() => _HomeState();
}

class _HomeState extends State<Recolection> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<dynamic> items = [
    // {
    //   'title': 'Chedraui',
    //   'acronimous': 'CH',
    //   'quantity': '12',
    //   'status': 'Pendiente'
    // },
    // {
    //   'title': 'Walmart',
    //   'acronimous': 'WL',
    //   'quantity': '12',
    //   'status': 'Pendiente'
    // }
  ];

  final dio = Dio();
  Future<void> init() async {
    Response response;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token')!;
    response = await dio.get('http://192.168.0.44:3000/pickups',
        queryParameters: {'page': 1, 'rowsPerPage': 10},
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    print(response.data['data']['pickups'][0]['id']);
    setState(() {
      items = response.data['data']['pickups']
          .map((e) => {
                'title': e['name'],
                'acronimous': e['name'].substring(0, 2).toUpperCase(),
                'quantity': e['products'].length,
                'status': e['status'],
                'address': e['chain']['address'],
                'personName': e['chain']['nameLinkPerson'],
                'phones': e['chain']['phones'],
                'chainsName': e['chain']['name'],
                'idPickup': e['id'],
                'status':e['status'],
              })
          .toList();
    });
    print('Esto es lo que esta imprimiendo');
    print(response.data['data']['pickups']);
    print(response.data['data']['pickups'].runtimeType);
  }

  @override
  void initState() {
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recolecciones'),
        backgroundColor: ColorsApp.prmaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text("Buscar"),
                    Expanded(child: TextField()),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                    )
                  ],
                ),
              ),
              Column(
                  children: items
                      .map((e) => HomeContainer(
                            tittle: e['title'],
                            acronimous: e['acronimous'],
                            quantity: e['quantity'].toString(),
                            status: e['status'],
                            address: e['address'],
                            personName: e['personName'],
                            phones: e['phones'].whereType<String>().toList(),
                            chainsName: e['chainsName'],
                            idPickup: e['idPickup'],
                          ))
                      .toList()),
              // ListView(
              //   padding: const EdgeInsets.all(16),
              //   children: [

              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
