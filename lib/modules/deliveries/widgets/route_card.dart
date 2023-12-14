import 'package:donaciones/kernel/models/route.dart' as routemodel;
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/deliveries/services/delivery_service.dart';
import 'package:donaciones/modules/deliveries/widgets/route_annexes_form.dart';
import 'package:donaciones/modules/deliveries/widgets/route_detail.dart';
import 'package:flutter/material.dart';

class RouteCard extends StatefulWidget {
  final Function reloadParent;
  final DeliveryService _deliveryService = DeliveryService();
  final routemodel.Route route;
  final int index;
  RouteCard({
    super.key,
    required this.route,
    required this.index,
    required this.reloadParent,
  });

  @override
  State<RouteCard> createState() => _RouteCardState(route: route);
}

class _RouteCardState extends State<RouteCard> {
  routemodel.Route route;

  _RouteCardState({required this.route});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(8),
            elevation: 5,
            child: Column(
              children: [
                ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: ColorsApp.prmaryColor,
                    foregroundColor: Colors.white,
                    child: Text(route.acronym),
                  ),
                  title: Text(
                    route.name,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorsApp.secondaryColor),
                  ),
                  subtitle: Text(
                    route.status,
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                  children: [
                    const Divider(
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
                                  route.reference,
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
                                    route.nameLinkPerson,
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
                                Column(
                                  children: [
                                    Text(
                                      'Teléfonos: ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ColorsApp.secondaryColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: route.phones
                                          .map((e) => Row(
                                            children: [
                                              SizedBox(
                                                    width: 120,
                                                    child: Text(e,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black45)),
                                                  ),
                                            ],
                                          ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          route.status == 'Finalizada' ||
                                  route.status == 'Cancelada'
                              ? ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 400,
                                          child: Center(
                                            child: RouteDetail(
                                              route: route,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text('Ver comentarios'),
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(60, 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: ColorsApp.successColor),
                                )
                              : SizedBox.shrink(),
                          route.status == 'Pendiente'
                              ? ElevatedButton(
                                  onPressed: () async {
                                    final delivery = await widget
                                        ._deliveryService
                                        .getOffline();
                                    if (delivery != null) {
                                      delivery.routes[widget.index].status =
                                          'En proceso';
                                      await widget._deliveryService
                                          .setOffline(delivery);
                                      // ignore: use_build_context_synchronously
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Exito'),
                                              content: const Text(
                                                  'Se ha iniciado la ruta'),  // 
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        route = delivery
                                                            .routes[widget.index];
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('OK'))
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  child: const Text('Iniciar'),
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(30, 30),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(22)),
                                      backgroundColor: ColorsApp.successColor),
                                )
                              : SizedBox.shrink(),
                          route.status == 'En proceso'
                              ? Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: 400,
                                              child: Center(
                                                  child: RouteAnnexesForm(
                                                route: route,
                                                reloadParents: () async {
                                                  widget.reloadParent();
                                                  final offlineDelivery = await widget._deliveryService.getOffline();
                                                  if (offlineDelivery != null) {
                                                    setState(() {
                                                      route = offlineDelivery.routes[widget.index];
                                                  });
                                                  }
                                                },
                                                status: 'Finalizada',
                                              )),
                                            );
                                          },
                                        );
                                      },
                                      child: const Text('Finalizar'),
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(30, 30),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(22)),
                                          backgroundColor:
                                              ColorsApp.successColor),
                                    ),
                                    Spacer(),
                                    ElevatedButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: 400,
                                              child: Center(
                                                  child: RouteAnnexesForm(
                                                route: route,
                                                reloadParents: () async {
                                                  widget.reloadParent();
                                                  final offlineDelivery = await widget._deliveryService.getOffline();
                                                  if (offlineDelivery != null) {
                                                    setState(() {
                                                      route = offlineDelivery.routes[widget.index];
                                                  });
                                                  }
                                                },
                                                status: 'Cancelada',
                                              )),
                                            );
                                          },
                                        );
                                      },
                                      child: const Text('Cancelar'),
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(30, 30),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(22)),
                                          backgroundColor:
                                              ColorsApp.successColor),
                                    ),
                                  ],
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
