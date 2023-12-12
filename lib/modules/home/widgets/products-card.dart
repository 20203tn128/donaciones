import 'package:dio/dio.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/home/widgets/coments-form.dart';
import 'package:donaciones/modules/home/widgets/products_detail.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final int quantity;
  final int index;
  final String idPickup;
  final bool isAnnexes;
  final String status;
  const ProductCard(
      {super.key,
      required this.name,
      required this.quantity,
      required this.index,
      required this.idPickup,
      required this.isAnnexes,
      required this.status});

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
              Text(widget.name,
                  style: TextStyle(
                      fontSize: 16,
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
                  Text(widget.quantity.toString()),
                ],
              )
            ],
          ),
          Spacer(),
          widget.status == 'En proceso'
              ? Padding(
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
                  ))
              : SizedBox.shrink(),
          widget.status == 'En proceso'
              ? IconButton(
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
                  ))
              : SizedBox.shrink(),
          widget.isAnnexes
              ? IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 400,
                          child: Center(
                            child: ProductsDetail(
                              index: widget.index,
                              idPickup: widget.idPickup,
                            ),
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
              : Spacer(),
          SizedBox.shrink()
        ],
      ),
    );
  }
}
