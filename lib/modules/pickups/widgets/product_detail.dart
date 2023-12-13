import 'dart:convert';
import 'dart:typed_data';

import 'package:donaciones/kernel/models/product.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

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
                padding: EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  color: ColorsApp.prmaryColor,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Detalles del producto',
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
                  product.annexes?.commentary != null
                      ? Container(
                          margin: const EdgeInsets.all(8),
                          child: SizedBox(
                            width: 250,
                            child: Text(
                              product.annexes!.commentary!,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black45),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  Container(
                      margin: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: product.annexes!.photos!.map((e) {
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
                              return const SizedBox.shrink();
                            }
                          }).toList(),
                        ),
                      )),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () => {
                        Navigator.pop(context),
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 50),
                          backgroundColor: ColorsApp.dangerColor),
                      child: const Text('Salir'),
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