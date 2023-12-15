import 'dart:convert';
import 'dart:io';

import 'package:donaciones/kernel/models/annexes.dart';
import 'package:donaciones/kernel/models/product.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/pickups/services/pickup_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAnnexesForm extends StatefulWidget {
  final Product product;
  final Function reloadParents;
  final Function closeFunction;

  const ProductAnnexesForm({
    super.key,
    required this.reloadParents,
    required this.product,
    required this.closeFunction,
  });

  @override
  State<ProductAnnexesForm> createState() => _ProductAnnexesFormState(
        product: product,
      );
}

class _ProductAnnexesFormState extends State<ProductAnnexesForm> {
  Product product;
  _ProductAnnexesFormState({required this.product});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _comments = TextEditingController(text: '');
  final List<File> _images = [];

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
    final PickupService _pickupService = PickupService();
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
                      child: TextField(
                        controller: _comments,
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
                                content: const SizedBox(
                                  width: 250,
                                  child: Text(
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
                                    onPressed: () {
                                      _getImageFromCamera();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Camara'),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    onPressed: () {
                                      _getImageFromGallery();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Galeria'),
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
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                {Navigator.pushNamed(context, '/detail')},
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 50),
                                backgroundColor: ColorsApp.dangerColor),
                            child: const Text('Cancelar'),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              final pickup = await _pickupService.getOffline();
                              if (pickup != null) {
                                int index = pickup.products.indexWhere(
                                    (element) => element.id == product.id);
                                pickup.products[index].annexes = Annexes(
                                    commentary: _comments.text,
                                    photos: _images.map((e) {
                                      final String bytes =
                                          base64Encode(e.readAsBytesSync());
                                      return 'data:image/jpeg;base64,$bytes';
                                    }).toList());

                                await _pickupService.setOffline(pickup);
                                widget.reloadParents();
                                // ignore: use_build_context_synchronously
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Exito'),
                                        content: Text('Se ha agregado la nota'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  product =
                                                      pickup.products[index];
                                                });
                                                Navigator.pop(context);
                                                widget.closeFunction();
                                              },
                                              child: const Text('OK'))
                                        ],
                                      );
                                    });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 50),
                                backgroundColor: ColorsApp.successColor),
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
