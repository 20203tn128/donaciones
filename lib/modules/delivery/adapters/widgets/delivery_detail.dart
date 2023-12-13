import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryDetail extends StatefulWidget {
  final int index;
  final String idDelivery;
  const DeliveryDetail(
      {Key? key, required this.index, required this.idDelivery})
      : super(key: key);

  @override
  State<DeliveryDetail> createState() => _DeliveryDetailState();
}

class _DeliveryDetailState extends State<DeliveryDetail> {
  final dio = Dio();
  String? comments = '';
  List<String> images = [];
  Future<void> init() async {
    Response response;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString('token')!;
    response = await dio.get(
        'http://192.168.1.69:3000/api/deliveries/${widget.idDelivery}',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    setState(() {
      comments = response.data['data']['delivery']['routes'][widget.index]
          ['annexes']?['commentary'];
      images = List<String>.from(response.data['data']['delivery']['routes']
              [widget.index]['annexes']?['photos'] ??
          []);
    });

    print('Esto es lo que esta imprimiendo');
    print(images);
  }

  @override
  void initState() {
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  color: ColorsApp.prmaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'Comentarios de la ruta',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  comments != null
                      ? Container(
                          margin: EdgeInsets.all(8),
                          child: SizedBox(
                            width: 250,
                            child: Text(
                              comments!,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black45),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  Container(
                      margin: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: images.map((e) {
                            try {
                              String base64String = e.split(',').last;
                              Uint8List bytes = base64.decode(base64String);
                              return Card(
                                child: Image.memory(
                                  bytes,
                                  height: 100,
                                  width: 100,
                                ),
                              );
                            } catch (error) {
                              print('Error decodificando base64: $error');
                              return SizedBox.shrink();
                            }
                          }).toList(),
                        ),
                      )),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () => {
                        Navigator.pop(context),
                      },
                      child: const Text('Salir'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 50),
                          backgroundColor: ColorsApp.dangerColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
