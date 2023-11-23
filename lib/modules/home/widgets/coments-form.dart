import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ComentsForm extends StatefulWidget {
  const ComentsForm({super.key});

  @override
  State<ComentsForm> createState() => _ComentsFormState();
}

class _ComentsFormState extends State<ComentsForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Comentarios'),
        backgroundColor: ColorsApp.secondaryColor,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      margin: EdgeInsets.all(8),
                      child: const TextField(
                        decoration: InputDecoration(
                          labelText: 'Comentarios: *',
                          labelStyle: TextStyle(),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: ColorsApp.secondaryColor)),
                        ),
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: () => {
                          Navigator.of(context).pushNamed('/home/coments-form')
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
                              Navigator.of(context)
                                  .pushNamed('/home/coments-form')
                            },
                            child: const Text('Cancelar'),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(150, 50),
                                backgroundColor: ColorsApp.dangerColor),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () => {
                              Navigator.of(context)
                                  .pushNamed('/home/coments-form')
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
