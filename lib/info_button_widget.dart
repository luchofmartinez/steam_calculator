import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 5,
      top: 80,
      child: IconButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              elevation: 2,
              title: const Center(child: Text('Calculadora IVA Steam')),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Los precios calculados son aproximados. \r\nCualquier error puede ser enviado a luchofmartinez@gmail.com\r\n',
                      style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    DataTable(
                      columnSpacing: 10,
                      columns: const [
                        DataColumn(label: Text('Impuesto')),
                        DataColumn(label: Text('Valor')),
                      ],
                      rows: const [
                        DataRow(
                          cells: [
                            DataCell(Text(
                                'Percepción de Ganancias RG AFIP Nº 5232/2022')),
                            DataCell(Text('100%')),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(
                                Text('Ley Impuesto PAIS RG AFIP N° 4659/2020')),
                            DataCell(Text('30%')),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text(
                                'Percepción de Bienes Personales RG AFIP Nº 5430/2023')),
                            DataCell(Text('25%')),
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
        icon: const Icon(Icons.info_outline, color: Colors.white),
      ),
    );
  }
}
