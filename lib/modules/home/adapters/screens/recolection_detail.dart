import 'package:dio/dio.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/home/widgets/all-coments-form.dart';
import 'package:donaciones/modules/home/widgets/products-card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecolectionDetail extends StatefulWidget {
  final String idPickup;
  const RecolectionDetail({super.key, required this.idPickup});

  @override
  State<RecolectionDetail> createState() =>
      _RecolectionState(idPickup: idPickup);
}

class _RecolectionState extends State<RecolectionDetail> {
  List<dynamic> items = [];
  final String idPickup;
  _RecolectionState({required this.idPickup});
  int total = 0;
  final dio = Dio();
  String status = 'Cancelada';
  Future<void> init() async {
    Response response;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token')!;
    response = await dio.get('http://192.168.1.69:3000/api/pickups/$idPickup',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    total = response.data['data']['pickup']['products'].length;
    status = response.data['data']['pickup']['status'];
    print(status);
    setState(() {
      items = response.data['data']['pickup']['products']
          .asMap()
          .entries
          .map((entry) {
        int idx = entry.key;
        dynamic val = entry.value;
        return {
          'name': val['name'],
          'quantity': val['quantity'],
          'idPickup': idPickup,
          'index': idx,
          'isAnnexes': val['annexes'] != null &&
              val['annexes']['commentary'] != null &&
              val['annexes']['photos'] != null,
          'status': status
        };
      }).toList();
    });

    print(response.data['data']['pickup']['products']);
    print(response.data['data']['pickup']['products'].runtimeType);
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
            child: status == 'En proceso' ||
                    status == 'Finalizado' ||
                    status == 'Cancelada'
                ? Column(
                    children: items
                        .map((e) => ProductCard(
                              name: e['name'],
                              quantity: e['quantity'],
                              index: e['index'],
                              idPickup: idPickup,
                              isAnnexes: e['isAnnexes'],
                              status: e['status'],
                            ))
                        .toList())
                : SizedBox.shrink(),
          ),
          status == 'En proceso' ||
                  status == 'Finalizado' ||
                  status == 'Cancelada'
              ? Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'Total:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      total.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                    SizedBox(
                      width: 180,
                    ),
                    status == 'En proceso'
                        ? Align(
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
                                  side: const BorderSide(
                                      color: ColorsApp.successColor),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16))),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                )
              : Card(
                  elevation: 5,
                  color: Color.fromARGB(255, 245, 219, 126),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber_outlined),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: SizedBox(
                            width: 300,
                            child: Text(
                              'Para observar los productos de esta recolección primero debes de iniciarla',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(115, 43, 42, 42)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      )),
    );
  }
}
