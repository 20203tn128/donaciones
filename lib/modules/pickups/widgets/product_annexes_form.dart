import 'dart:io';

import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAnnexesForm extends StatefulWidget {
  final Function reload;

  const ProductAnnexesForm({super.key, required this.reload});

  @override
  State<ProductAnnexesForm> createState() => _ProductAnnexesFormState();
}

class _ProductAnnexesFormState extends State<ProductAnnexesForm> {
  final _formKey = GlobalKey<FormState>();
  List<File> _images = [];

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
                            'Realiza un comentario referente a la recolección',
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
                      margin: const EdgeInsets.all(8),
                      child: const TextField(
                        decoration: InputDecoration(
                          labelText: 'Comentarios: *',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: ColorsApp.secondaryColor)),
                        ),
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
                            onPressed: () => {
                              Navigator.pushNamed(context, '/detail')
                            },
                            child: const Text('Cancelar'),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(150, 50),
                                backgroundColor: ColorsApp.dangerColor),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () => {
                              Navigator.pushNamed(
                                  context, '/detail')
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
