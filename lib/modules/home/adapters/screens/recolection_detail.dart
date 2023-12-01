import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/home/widgets/products-card.dart';
import 'package:flutter/material.dart';

class RecolectionDetail extends StatefulWidget {
  const RecolectionDetail({super.key});

  @override
  State<RecolectionDetail> createState() => _RecolectionState();
}

class _RecolectionState extends State<RecolectionDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la recolección'),
        backgroundColor: ColorsApp.prmaryColor,
      ),
      body: Container(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Lista de productos',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.secondaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                  ProductCard(),
                  ProductCard()
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Total:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '12',
                  style: TextStyle(fontSize: 16, color: Colors.black45),
                ),
                SizedBox(
                  width: 180,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home/all-coments-form');
                    },
                    child: const Text('Guardar'),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: ColorsApp.successColor,
                        side: const BorderSide(color: ColorsApp.successColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
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
