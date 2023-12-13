import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:donaciones/modules/deliveries/services/delivery_service.dart';
import 'package:donaciones/modules/pickups/services/pickup_service.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final Function(int) setItem;
  const Dashboard({super.key, required this.setItem});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PickupService _pickupService = PickupService();
  final DeliveryService _deliveryService = DeliveryService();
  int pickups = 13;
  int deliveries = 8;

  Future<void> _init() async {
    // final pickups = (await _pickupService.get(
    //         rowsPerPage: 100))
    //     .length;
    // final deliveries = (await _deliveryService.get(
    //         rowsPerPage: 100))
    //     .length;
    // setState(() {
    //   this.pickups = pickups;
    //   this.deliveries = deliveries;
    // });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo-gob-zapata.jpg',
              width: 300,
              height: 180,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Column(children: [
                  SizedBox(
                    height: 200,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: ColorsApp.prmaryColor,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$pickups',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsApp.secondaryColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Recolecciones pendientes',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black45),
                                  )
                                ],
                              ),
                            )
                          ]),
                    ),
                  )
                ]),
                Column(children: [
                  SizedBox(
                    height: 200,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: ColorsApp.prmaryColor,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$deliveries',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsApp.secondaryColor),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Repartos pendientes',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black45),
                                  ),
                                )
                              ],
                            )
                          ]),
                    ),
                  )
                ]),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  widget.setItem(1);
                },
                child: const Text('Ir a mis recolecciones'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(300, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    backgroundColor: ColorsApp.successColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  widget.setItem(2);
                },
                child: const Text('Ir a mis repartos'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(300, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    backgroundColor: ColorsApp.successColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
