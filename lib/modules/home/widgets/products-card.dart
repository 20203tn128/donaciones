import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
      };
      if (states.any(interactiveStates.contains)) {
        return ColorsApp.successColor;
      }
      return ColorsApp.secondaryColor;
    }

    return Card(
      elevation: 5,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.food_bank,
              color: ColorsApp.warningColor,
            ),
          ),
          Container(
              child: Column(
            children: [
              Row(
                children: [
                  Text('Chiles',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorsApp.secondaryColor)),
                ],
              ),
              Row(
                children: [
                  Text('Cantidad:',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ColorsApp.secondaryColor)),
                  SizedBox(
                    width: 10,
                  ),
                  Text('12 piezas')
                ],
              ),
            ],
          )),
          SizedBox(
            width: 110,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Checkbox(
                tristate: true,
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value;
                    print(value);
                    if (isChecked == null) {
                      Navigator.of(context).pushNamed('/home/coments-form');
                    }
                  });
                },
              )),
        ],
      ),
    );
  }
}