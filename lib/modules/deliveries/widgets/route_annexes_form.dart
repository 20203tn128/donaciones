import 'dart:convert';
import 'dart:io';

import 'package:donaciones/kernel/models/annexes.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/deliveries/services/delivery_service.dart';
import 'package:flutter/material.dart';
import 'package:donaciones/kernel/models/route.dart' as routemodel;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class RouteAnnexesForm extends StatefulWidget {
  final routemodel.Route route;
  const RouteAnnexesForm({super.key, required this.route});

  @override
  State<RouteAnnexesForm> createState() => _RouteAnnexesFormState(route: route);
}

class _RouteAnnexesFormState extends State<RouteAnnexesForm> {
  routemodel.Route route;

  _RouteAnnexesFormState({required this.route});
  final _formKey = GlobalKey<FormState>();
  List<File> _images = [];
  final TextEditingController _comments = TextEditingController(text: '');

  Future _getImageFromCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.camera);

    _addImage(pickedFile);
  }

  Future _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);

    _addImage(pickedFile);
  }

  void _addImage(XFile? pickedFile) {
    setState(() {
      if (pickedFile != null) {
        _images.add(File(pickedFile.path));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final DeliveryService _deliveryService = DeliveryService();

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
                  color: Color.fromARGB(255, 245, 219, 126),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber_outlined),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'Realiza un comentario referente a el reparto',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(115, 43, 42, 42)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                onChanged: () => {},
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Comentarios: *',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: ColorsApp.secondaryColor)),
                          ),
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          controller: _comments),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _images.map((image) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(image,
                                      height: 100, width: 100),
                                )),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: () => {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Seleccione una opción'),
                                content: SizedBox(
                                  width: 250,
                                  child: const Text(
                                    'Selecione una opción desde la cual podra subir el archivo deaseado',
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    child: const Text('Camara'),
                                    onPressed: _getImageFromCamera,
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    child: const Text('Galeria'),
                                    onPressed: _getImageFromGallery,
                                  ),
                                ],
                              );
                            },
                          )
                        },
                        child: const Icon(
                          Icons.camera_alt,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => {Navigator.pop(context)},
                            child: const Text('Cancelar'),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(150, 50),
                                backgroundColor: ColorsApp.dangerColor),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              final delivery =
                                  await _deliveryService.getOffline();
                              if (delivery != null) {
                                int index = delivery.routes.indexWhere(
                                    (element) => element.id == route.id);
                                delivery.routes[index].annexes = Annexes(
                                    commentary: _comments.text,
                                    photos: _images.map((e) {
                                      print('esto es una foto');
                                      final String bytes =
                                          base64Encode(e.readAsBytesSync());
                                      return 'data:image/jpeg;base64,$bytes';
                                    }).toList());
                                print('Que es esto');
                                print(delivery.toMap());
                                print('eso era lo de las fotos xd');
                                delivery.routes[index].status = 'Finalizada';
                                delivery.routes[index].dateEnd = DateTime.now();

                                await _deliveryService.setOffline(delivery);
                                final indes = await _deliveryService.getOffline();
                                print( indes?.toMap());
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Exito'),
                                        content: const Text(
                                            'Se ha finalizado la ruta'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  route =
                                                      delivery.routes[index];
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'))
                                        ],
                                      );
                                    });
                              }
                            },
                            child: const Text('Guardar'),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(150, 50),
                                backgroundColor: ColorsApp.successColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
