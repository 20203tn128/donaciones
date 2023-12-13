import 'package:donaciones/kernel/models/pickup.dart';
import 'package:donaciones/kernel/models/product.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/pickups/widgets/product_annexes_form.dart';
import 'package:donaciones/modules/pickups/widgets/product_detail.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Function reload;
  final Pickup pickup;
  final Product product;

  const ProductCard({
    super.key,
    required this.pickup,
    required this.product,
    required this.reload,
  });

  @override
  State<ProductCard> createState() => _ProductCardState(reload: reload);
}

class _ProductCardState extends State<ProductCard> {
  final Function reload;

  _ProductCardState({required this.reload});

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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.inventory_2_rounded,
              color: Colors.black45,
            ),
          ),
          Column(
            children: [
              Text(widget.product.name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorsApp.secondaryColor)),
              Row(
                children: [
                  const Text('Cantidad:',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ColorsApp.secondaryColor)),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(widget.product.quantity.toString()),
                ],
              )
            ],
          ),
          const Spacer(),
          widget.pickup.status == 'En proceso'
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
              : const SizedBox.shrink(),
          widget.pickup.status == 'En proceso'
              ? IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const SizedBox(
                          height: 400,
                          child: Center(
                            child: ProductAnnexesForm(reload: reload),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.note_add_rounded,
                    color: Colors.black45,
                    semanticLabel: 'Agrega nota',
                  ))
              : const SizedBox.shrink(),
          widget.product.annexes != null
              ? IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 400,
                          child: Center(
                            child: ProductDetail(product: widget.product),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.info_outline_rounded,
                    color: ColorsApp.prmaryColor,
                    semanticLabel: 'Detalles',
                  ))
              : const Spacer(),
          const SizedBox.shrink()
        ],
      ),
    );
  }
}
