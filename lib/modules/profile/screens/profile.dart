import 'package:donaciones/kernel/themes/colors_app.dart';
//import 'package:donaciones/modules/profile/widgets/password-form.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
          backgroundColor: ColorsApp.secondaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: ColorsApp.secondaryColor,
                        foregroundColor: Colors.white,
                        child: Text(
                          'LC',
                          style: TextStyle(fontSize: 24),
                        ),
                        maxRadius: 35,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Liz Claudia Espinosa',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => {
                      Navigator.of(context).pushNamed('/settings/password-form')
                    },
                    child: const Text('Modificar contraseña'),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(300, 50),
                        backgroundColor: ColorsApp.successColor),
                  ),
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Telefóno: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text('777-123-456'),
                    ElevatedButton(
                      onPressed: () =>
                          {Navigator.of(context).pushNamed('/home')},
                      child: const Text('Modificar telefono'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 50),
                          backgroundColor: ColorsApp.successColor),
                    ),
                    IconButton(
                        onPressed: () => {
                              Navigator.of(context)
                                  .pushNamed('/settings/phone-form')
                            },
                        icon: Icon(Icons.edit))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
