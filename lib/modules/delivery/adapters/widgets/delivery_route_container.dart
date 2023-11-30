import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';

class DeliveruRouteContainer extends StatelessWidget {
  final String tittle;
  final String number;
  final String acronimous;
  final String adress;
  final String references;
  const DeliveruRouteContainer(
      {super.key,
      required this.tittle,
      required this.acronimous,
      required this.adress,
      required this.references,
      required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            number,
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
          Spacer(),
          SizedBox(
            width: 330,
            child: Card(
              elevation: 5,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: ColorsApp.prmaryColor,
                              foregroundColor: Colors.white,
                              child: Text(acronimous),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                tittle,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsApp.secondaryColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                adress,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black45),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                references,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black45),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
