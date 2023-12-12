import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/delivery/adapters/widgets/delivery_detail.dart';
import 'package:flutter/material.dart';

class DeliveryRouteContainer extends StatelessWidget {
  final String tittle;
  final String acronimous;
  final String references;
  final String name;
  final List<String> phones;
  final String status;
  final int index;
  final String idDelivery;
  const DeliveryRouteContainer({
    super.key,
    required this.tittle,
    required this.acronimous,
    required this.references,
    required this.name,
    required this.status,
    required this.index,
    required this.idDelivery,
    required this.phones,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
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
                    status,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                  children: [
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Referencias: ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ColorsApp.secondaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  references,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black45),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Enlaces: ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ColorsApp.secondaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black45),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Teléfonos: ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ColorsApp.secondaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Row(
                                  children: phones
                                      .map((e) => SizedBox(
                                            width: 80,
                                            child: Text(e,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black45)),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                          status == 'Finalizada' || status == 'Cancelada'
                              ? ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 400,
                                          child: Center(
                                            child: DeliveryDetail(
                                              index: index,
                                              idDelivery: idDelivery,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text('Ver comentarios'),
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(30, 30),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(22)),
                                      backgroundColor: ColorsApp.successColor),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
