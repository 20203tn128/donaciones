import 'package:donaciones/kernel/themes/colors_app.dart';
import 'package:flutter/material.dart';

class ProductsDetail extends StatefulWidget {
  const ProductsDetail({super.key});

  @override
  State<ProductsDetail> createState() => _ProductsDetailState();
}

class _ProductsDetailState extends State<ProductsDetail> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  color: ColorsApp.prmaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'Detalles del producto',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: SizedBox(
                      width: 250,
                      child: const Text(
                        'Estos son los comentarios chal alchalsdas ashdjhsajkdhshjdhlahdfjlfadjasdjfbjasdweuhruqwefhsadjkhhefoqweyfhsdfkjhañdfyhqwoeyfoh',
                        style: TextStyle(fontSize: 12, color: Colors.black45),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Card(
                              elevation: 5,
                              child: Image.asset(
                                'assets/images/logo-gob-zapata.jpg',
                                width: 100,
                                height: 100,
                              ),
                            ),
                            Card(
                              elevation: 5,
                              child: Image.asset(
                                'assets/images/logo-gob-zapata.jpg',
                                width: 100,
                                height: 100,
                              ),
                            ),
                            Card(
                              elevation: 5,
                              child: Image.asset(
                                'assets/images/logo-gob-zapata.jpg',
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ],
                        ),
                      )),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () => {
                        Navigator.pushNamed(
                            context, '/home/recolections_detail')
                      },
                      child: const Text('Salir'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(150, 50),
                          backgroundColor: ColorsApp.dangerColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
