import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
                              '3',
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
                              '1',
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
                  Navigator.of(context).pushNamed('/home/recolections');
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
                  Navigator.of(context).pushNamed('/menu');
                },
                child: const Text('Ir a mis recolecciones'),
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
