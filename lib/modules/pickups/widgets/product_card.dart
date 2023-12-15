// ignore_for_file: no_logic_in_create_state

import 'package:donaciones/kernel/models/pickup.dart';
import 'package:donaciones/kernel/models/product.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/pickups/services/pickup_service.dart';
import 'package:donaciones/modules/pickups/widgets/product_annexes_form.dart';
import 'package:donaciones/modules/pickups/widgets/product_detail.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Function reloadParent;
  final PickupService _pickupService = PickupService();
  final Pickup pickup;
  final Product product;
  final int index;

  ProductCard({
    super.key,
    required this.pickup,
    required this.product,
    required this.reloadParent,
    required this.index,
  });

  @override
  State<ProductCard> createState() => _ProductCardState(product: product);
}

class _ProductCardState extends State<ProductCard> {
  Product product;
  _ProductCardState({required this.product}) {
    isChecked = product.recolected ?? false;
  }

  late bool isChecked;
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
      elevation: 3,
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
              Text(widget.product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorsApp.secondaryColor)),
              Row(
                children: [
                  const Text('Cantidad:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ColorsApp.secondaryColor)),
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
                    onChanged: (bool? value) async {
                      final offlineProduct = await widget._pickupService.getOffline();
                      if (offlineProduct != null) {
                        offlineProduct.products[widget.index].recolected = value;
                        await widget._pickupService.setOffline(offlineProduct);
                      }
                      widget.reloadParent();
                      setState(() {
                        isChecked = value!;
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
                        return SizedBox(
                          height: 400,
                          child: Center(
                            child: ProductAnnexesForm(
                                closeFunction: () {
                                  Navigator.pop(context);
                                },
                                reloadParents: () async {
                                  final offlinePickup = await widget._pickupService.getOffline();
                                  if (offlinePickup != null) {
                                    setState(() {
                                      product = offlinePickup.products[widget.index];
                                    });
                                  }
                                  widget.reloadParent();
                                },
                                product: product),
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
                    color: ColorsApp.primaryColor,
                    semanticLabel: 'Detalles',
                  ))
              : const Spacer(),
          const SizedBox.shrink()
        ],
      ),
    );
  }
}
