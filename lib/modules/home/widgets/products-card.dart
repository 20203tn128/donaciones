import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/home/widgets/coments-form.dart';
import 'package:donaciones/modules/home/widgets/products_detail.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final _formKey = GlobalKey<FormState>();
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.selected,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return ColorsApp.successColor;
      }
      return Colors.black45;
    }

    return Card(
      elevation: 5,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.inventory_2_rounded,
              color: Colors.black45,
            ),
          ),
          Column(
            children: [
              Text('Chiles',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorsApp.secondaryColor)),
              Row(
                children: [
                  Text('Cantidad:',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ColorsApp.secondaryColor)),
                  SizedBox(
                    width: 6,
                  ),
                  Text('12'),
                ],
              )
            ],
          ),
          Spacer(),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Checkbox(
                tristate: false,
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              )),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 400,
                      child: Center(
                        child: ComentsForm(),
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.note_add_rounded,
                color: Colors.black45,
                semanticLabel: 'Agrega nota',
              )),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 400,
                      child: Center(
                        child: ProductsDetail(),
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.info_outline_rounded,
                color: ColorsApp.prmaryColor,
                semanticLabel: 'Detalles',
              ))
        ],
      ),
    );
  }
}
