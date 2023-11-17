import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeContainer extends StatelessWidget {
  final String tittle;
  final String date;
  final String hours;
  final String status;

  const HomeContainer(
      {super.key,
      required this.tittle,
      required this.date,
      required this.hours,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              tittle,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.successColor),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Fecha:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                      fontSize: 12, color: ColorsApp.secondaryColor),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Hora:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  hours,
                  style: const TextStyle(
                      fontSize: 12, color: ColorsApp.secondaryColor),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Status:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  status,
                  style: const TextStyle(
                      fontSize: 12, color: ColorsApp.secondaryColor),
                ),
                const SizedBox(
                  width: 16,
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                        onPressed: () => {
                              Navigator.of(context)
                                  .pushNamed('/home/recolections')
                            },
                        icon: const Icon(Icons.search)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
