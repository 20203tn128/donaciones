// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:donaciones/kernel/models/annexes.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/pickups/services/pickup_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickupGeneralAnnexesForm extends StatefulWidget {
  final Function reloadParent;
  final Function closeFunction;
  const PickupGeneralAnnexesForm({super.key, required this.reloadParent, required this.closeFunction});

  @override
  State<PickupGeneralAnnexesForm> createState() => _PickupGeneralAnnexesFormState();
}

class _PickupGeneralAnnexesFormState extends State<PickupGeneralAnnexesForm> {
  final PickupService _pickupService = PickupService();
  final _formKey = GlobalKey<FormState>();
  final List<File> _images = [];
  final TextEditingController _comments = TextEditingController(text: '');
  Future _getImageFromCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    _addImage(pickedFile);
  }

  Future _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

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
                  color: Color.fromARGB(255, 245, 219, 126),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber_outlined),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Realiza un comentario referente a el reparto',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color.fromARGB(115, 43, 42, 42)),
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
                      margin: const EdgeInsets.all(8),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Comentarios: *',
                          border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: ColorsApp.secondaryColor)),
                        ),
                        controller: _comments,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                      ),
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
                                  child: Image.file(image, height: 100, width: 100),
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Seleccione una opción'),
                                content: const SizedBox(
                                  width: 250,
                                  child: Text(
                                    'Selecione una opción desde la cual podra subir el archivo deseado',
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context).textTheme.labelLarge,
                                    ),
                                    child: const Text('Cámara'),
                                    onPressed: () {
                                      _getImageFromCamera();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context).textTheme.labelLarge,
                                    ),
                                    child: const Text('Galería'),
                                    onPressed: () {
                                      _getImageFromGallery();
                                      Navigator.pop(context);
                                    },
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
                      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => {Navigator.pushNamed(context, '/home/recolections_detail')},
                            style: ElevatedButton.styleFrom(minimumSize: const Size(150, 50), backgroundColor: ColorsApp.dangerColor, foregroundColor: Colors.white),
                            child: const Text('Cancelar'),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              final pickup = await _pickupService.getOffline();
                              if (pickup != null) {
                                pickup.generalAnnexes = Annexes(
                                    commentary: _comments.text,
                                    photos: _images.map((e) {
                                      final String bytes = base64Encode(e.readAsBytesSync());
                                      return 'data:image/jpeg;base64,$bytes';
                                    }).toList());
                                pickup.status = 'Cancelada';

                                await _pickupService.setOffline(pickup);
                                widget.reloadParent();
                                if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
                                  _pickupService.sync();
                                }

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Éxito'),
                                      content: const Text('Se ha cancelado la ruta'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              widget.closeFunction();
                                            },
                                            child: const Text('OK'))
                                      ],
                                    );
                                  }
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(minimumSize: const Size(150, 50), backgroundColor: ColorsApp.successColor, foregroundColor: Colors.white),
                            child: const Text('Guardar'),
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
