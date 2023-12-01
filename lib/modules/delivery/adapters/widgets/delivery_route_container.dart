import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';

class DeliveruRouteContainer extends StatelessWidget {
  final String tittle;
  final String number;
  final String acronimous;
  final String adress;
  final String references;
  final String name;
  final String phone;
  const DeliveruRouteContainer(
      {super.key,
      required this.tittle,
      required this.acronimous,
      required this.adress,
      required this.references,
      required this.number,
      required this.name,
      required this.phone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Text(
                  number,
                  style: TextStyle(fontSize: 16, color: Colors.black45),
                ),
              ],
            ),
          ),
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
                  children: [
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Dirección: ',
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
                                    adress,
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Referencias: ',
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
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    phone,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black45),
                                  ),
                                ),
                              ],
                            ),
                          )
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
