import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';

class DeliveryContainer extends StatelessWidget {
  final String tittle;
  final String acronimous;
  final String date;
  const DeliveryContainer(
      {super.key,
      required this.tittle,
      required this.acronimous,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: ColorsApp.prmaryColor,
                foregroundColor: Colors.white,
                child: Text(acronimous),
              ),
              title: Text(
                tittle,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.secondaryColor),
              ),
              subtitle: Text(
                date,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home/delivery-route');
                        },
                        child: const Text('Ver ruta'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(30, 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22)),
                            backgroundColor: ColorsApp.successColor),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home/start-delivery');
                        },
                        child: const Text('Iniciar reparto'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(30, 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22)),
                            backgroundColor: ColorsApp.successColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
