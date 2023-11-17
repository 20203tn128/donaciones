import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';

class Recolection extends StatelessWidget {
  const Recolection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recolección'),
        backgroundColor: ColorsApp.secondaryColor,
      ),
      body: Container(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Productos',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.prmaryColor),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  border: TableBorder.all(
                      color: ColorsApp.prmaryColor,
                      borderRadius: BorderRadius.circular(2)),
                  children: [
                    TableRow(children: <Widget>[
                      Container(
                          child: const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Producto',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorsApp.secondaryColor)),
                      )),
                      Container(
                          child: const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Cantidad',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorsApp.secondaryColor)),
                      )),
                      Container(
                          child: const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Acciones',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorsApp.secondaryColor)),
                      ))
                    ]),
                    TableRow(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(child: Text('Latas de atún')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(child: const Text('12 piezas')),
                      ),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () => {
                                      Navigator.of(context)
                                          .pushNamed('/home/recolections')
                                    },
                                icon: const Icon(Icons.cancel,
                                    color: ColorsApp.dangerColor)),
                            IconButton(
                                onPressed: () => {
                                      Navigator.of(context)
                                          .pushNamed('/home/recolections')
                                    },
                                icon: const Icon(Icons.check_circle,
                                    color: ColorsApp.successColor))
                          ],
                        ),
                      ),
                    ]),
                    TableRow(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(child: Text('Latas de atún')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(child: const Text('12 piezas')),
                      ),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () => {
                                      Navigator.of(context)
                                          .pushNamed('/home/recolections')
                                    },
                                icon: const Icon(Icons.cancel,
                                    color: ColorsApp.dangerColor)),
                            IconButton(
                                onPressed: () => {
                                      Navigator.of(context)
                                          .pushNamed('/home/recolections')
                                    },
                                icon: const Icon(Icons.check_circle,
                                    color: ColorsApp.successColor))
                          ],
                        ),
                      ),
                    ]),
                    TableRow(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(child: Text('Latas de atún')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(child: const Text('12 piezas')),
                      ),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () => {
                                      Navigator.of(context)
                                          .pushNamed('/home/recolections')
                                    },
                                icon: const Icon(Icons.cancel,
                                    color: ColorsApp.dangerColor)),
                            IconButton(
                                onPressed: () => {
                                      Navigator.of(context)
                                          .pushNamed('/home/recolections')
                                    },
                                icon: const Icon(Icons.check_circle,
                                    color: ColorsApp.successColor))
                          ],
                        ),
                      ),
                    ]),
                    TableRow(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(child: Text('Latas de atún')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(child: const Text('12 piezas')),
                      ),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () => {
                                      Navigator.of(context)
                                          .pushNamed('/home/coments-form')
                                    },
                                icon: const Icon(Icons.cancel,
                                    color: ColorsApp.dangerColor)),
                            IconButton(
                                onPressed: () => {
                                      Navigator.of(context)
                                          .pushNamed('/home/recolections')
                                    },
                                icon: const Icon(Icons.check_circle,
                                    color: ColorsApp.successColor))
                          ],
                        ),
                      ),
                    ]),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
