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
          child: Column(
        children: [
          Form(
            key: _formKey,
            onChanged: () => {},
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Comentarios: *',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: ColorsApp.secondaryColor))),
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () =>
                        {Navigator.of(context).pushNamed('/home/coments-form')},
                    child: Icon(
                      Icons.camera_alt,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.of(context).pushNamed('/home/coments-form')
                        },
                        child: const Text('Cancelar'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(300, 50),
                            backgroundColor: ColorsApp.dangerColor),
                      ),
                      SizedBox(
                        width: 8,
                      ), 
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.of(context).pushNamed('/home/coments-form')
                        },
                        child: const Text('Guardar'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(300, 50),
                            backgroundColor: ColorsApp.successColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
