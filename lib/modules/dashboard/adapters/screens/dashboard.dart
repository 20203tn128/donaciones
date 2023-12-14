import 'package:donaciones/kernel/models/response.dart';
import 'package:donaciones/kernel/services/api_service.dart';
import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final Function(int) setItem;
  const Dashboard({super.key, required this.setItem});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ApiService _apiService = ApiService();

  int pickups = 0;
  int deliveries = 0;

  @override
  void initState() {
    super.initState();
    getPickups();
    getDeliveries();
  }

  void getPickups() async {
    final response = await _apiService.get('/pickups/pendings');
    final res = Response.fromMap(response.data);
    setState(() {
      pickups = res.data['count'];
    });
  }
  void getDeliveries() async {
    final response = await _apiService.get('/deliveries/pendings');
    final res = Response.fromMap(response.data);
    setState(() {
      deliveries = res.data['count'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(children: [
                      SizedBox(
                        height: 200,
                        width: 150,
                        child: Card(
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(
                              color: ColorsApp.prmaryColor,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$pickups',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Recolecciones',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'pendientes',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ]),
                        ),
                      )
                    ]),
                    Column(children: [
                      SizedBox(
                        height: 200,
                        width: 150,
                        child: Card(
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(
                              color: ColorsApp.prmaryColor,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$deliveries',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Repartos',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'pendientes',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
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
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 40.0),
              child: ElevatedButton(
                onPressed: () {
                  widget.setItem(1);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: ColorsApp.successColor, foregroundColor: Colors.white),
                child: const Text('Ir a mis recolecciones'),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  widget.setItem(2);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: ColorsApp.successColor, foregroundColor: Colors.white),
                child: const Text('Ir a mis repartos'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
