import 'package:dio/dio.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/home/widgets/all-coments-form.dart';
import 'package:donaciones/modules/home/widgets/products-card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecolectionDetail extends StatefulWidget {
  const RecolectionDetail({super.key});

  @override
  State<RecolectionDetail> createState() => _RecolectionState();
}

class _RecolectionState extends State<RecolectionDetail> {
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
    var id = await prefs.getString('id')!;
    response = await dio.get('http://192.168.75.139:3000/pickups/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    setState(() {
      items = response.data['data']['pickup']['products']
          .map((e) => {
                'name': e['name'],
                'quantity': 12,
              })
          .toList();
    });

    print(response.data['data']['chains']);
    print(response.data['data']['chains'].runtimeType);
  }

  @override
  void initState() {
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la recolección'),
        backgroundColor: ColorsApp.prmaryColor,
      ),
      body: Container(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Lista de productos',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.secondaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  children: items
                      .map((e) => ProductCard(
                            name: e['name'],
                            quantity: e['quantity'],
                          ))
                      .toList()),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Total:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '12',
                  style: TextStyle(fontSize: 16, color: Colors.black45),
                ),
                SizedBox(
                  width: 180,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 400,
                            child: Center(
                              child: AllComentsForm(),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Guardar'),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: ColorsApp.successColor,
                        side: const BorderSide(color: ColorsApp.successColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
