import 'package:flutter/material.dart';
import 'package:steam_calculator/currency.dart';
import 'package:steam_calculator/data/db/database_service.dart';
import 'package:steam_calculator/formadepago.dart';
import 'package:steam_calculator/game.dart';
import 'package:steam_calculator/provincias.dart';

class HomePageBody extends StatefulWidget {
  final void Function(Game) showGameData;

  const HomePageBody({
    required this.showGameData,
  });

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  final gameAmmountController = TextEditingController();
  final locationController = TextEditingController();
  final paymentMethod = TextEditingController();

  FocusNode focusNode = FocusNode();

  double montoTotal = 0.00;
  double taxCreditCardAmmount = 0.0;
  double taxGananciasAmmount = 0.0;
  double taxLocationAmmount = 0.0;
  double taxLawAmmount = 0.0;
  double taxAmmount = 0.0;
  bool showTotals = false;
  bool hasStampTax = false;
  bool _loading = false;
  double taxPercentage = 0.0;

  late String selectedLocation;
  late String selectedPaymentMethod;
  late Currency selectedCurrency;

  @override
  void initState() {
    selectedLocation = provincias.first;
    selectedPaymentMethod = formasDePago.first;
    selectedCurrency = currencyList.first;
    super.initState();
  }

  void calcularIVA(List<double> list) {
    montoTotal = double.tryParse(gameAmmountController.text) ?? 0.0;
    if (montoTotal > 0) {
      double montoSubTotal = montoTotal;

      Tax tax5 = Tax(
        description: 'Percepción de Bienes Personales RG Nº 5430/2023',
        percentage: list[2],
        value: taxAmmount,
      );

      taxAmmount = montoTotal * (tax5.percentage / 100);
      montoSubTotal += taxAmmount;

      Tax tax4 = Tax(
        description: 'IVA',
        percentage: list[1],
        value: taxAmmount,
      );

      taxAmmount = montoTotal * (tax4.percentage / 100);
      montoSubTotal += taxAmmount;

      Tax tax1 = Tax(
        description: 'Percepción Ganancias RG 4815/2020',
        percentage: list[3],
        value: taxGananciasAmmount,
      );

      taxGananciasAmmount = montoTotal * (tax1.percentage / 100);
      montoSubTotal += taxGananciasAmmount;

      Tax tax2 = Tax(
        description: 'Impuesto PAIS Ley 27.541',
        percentage: list[0],
        value: taxLawAmmount,
      );

      taxLawAmmount = montoTotal * (tax2.percentage / 100);
      montoSubTotal += taxLawAmmount;

      switch (selectedLocation) {
        case 'CABA':
          taxPercentage = 0.02;
          taxLocationAmmount = montoTotal * taxPercentage;
          break;
        case 'Buenos Aires':
          taxPercentage = 0.02;
          taxLocationAmmount = montoTotal * taxPercentage;
          break;
        case 'Córdoba':
          taxPercentage = 0.03;
          taxLocationAmmount = montoTotal * taxPercentage;
          break;
        case 'Chaco':
          taxPercentage = 0.055;
          taxLocationAmmount = montoTotal * taxPercentage;
          break;
        case 'La Pampa':
          taxPercentage = 0.01;
          taxLocationAmmount = montoTotal * taxPercentage;
          break;
        case 'Neuquén':
          taxPercentage = 0.04;
          taxLocationAmmount = montoTotal * taxPercentage;
          break;
        case 'Río Negro':
          taxPercentage = 0.05;
          taxLocationAmmount = montoTotal * taxPercentage;
          break;
        case 'Salta':
          taxPercentage = 0.036;
          taxLocationAmmount = montoTotal * taxPercentage;
          break;
        case 'Tierra del Fuego':
          taxPercentage = 0.03;
          taxLocationAmmount = montoTotal * taxPercentage;
          break;
        default:
          taxPercentage = 0;
          taxLocationAmmount = montoTotal * taxPercentage;
      }
      montoSubTotal += taxLocationAmmount;

      Tax tax3 = Tax(
        description: 'Percepción Ingresos Brutos',
        percentage: taxPercentage * 100,
        value: taxLocationAmmount,
      );

      taxCreditCardAmmount = 0.0;
      switch (selectedPaymentMethod) {
        case 'Tarjeta de Crédito':
          taxCreditCardAmmount = montoTotal * 0.012;
          break;
      }
      montoSubTotal += taxCreditCardAmmount;

      montoTotal = montoSubTotal;

      List<Tax> imp = [];
      imp.add(tax1);
      imp.add(tax2);
      imp.add(tax3);
      imp.add(tax4);
      imp.add(tax5);

      Game juego = Game(
        value: montoTotal,
        taxes: imp,
      );

      widget.showGameData(juego);

      
      showTotals = true;
    }
  }

  final textStyle = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LocationQuestion(),
        const SizedBox(height: 20),
        PaymentQuestion(),
        const SizedBox(height: 20),
        CurrencyQuestion(),
        const SizedBox(height: 20),
        GameValueQuestion(),
        const SizedBox(height: 20),
        ButtonCalculate()
      ],
    );
  }

  FloatingActionButton ButtonCalculate() => FloatingActionButton.extended(
        onPressed: () async {
          final taxes = await DatabaseService().getTaxValues();
          calcularIVA(taxes);
          focusNode.unfocus();
        },
        label: const Text('Calcular'),
      );

  Widget GameValueQuestion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Valor del juego',
            style: textStyle,
          ),
        ),
        SizedBox(
          width: 100,
          child: TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            controller: gameAmmountController,
            keyboardType: TextInputType.number,
            focusNode: focusNode,
          ),
        )
      ],
    );
  }

  Widget CurrencyQuestion() {
    List<DropdownMenuItem<Currency>> items = [];

    for (var curr in currencyList) {
      if (curr.enable) {
        items.add(
          DropdownMenuItem<Currency>(
            value: curr,
            child: Text(curr.description),
          ),
        );
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '¿Moneda?',
            style: textStyle,
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<Currency>(
              underline: Container(),
              value: selectedCurrency,
              borderRadius: BorderRadius.circular(15),
              items: items,
              onChanged: (newValue) {
                setState(() {
                  selectedCurrency = newValue!;
                });
              },
            ),
          ),
        )
      ],
    );
  }

  Widget PaymentQuestion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '¿Forma de pago?',
          style: textStyle,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButton<String>(
                underline: Container(),
                isExpanded: true,
                borderRadius: BorderRadius.circular(15),
                value: selectedPaymentMethod,
                items: formasDePago
                    .map((String e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedPaymentMethod = newValue!;
                  });
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget LocationQuestion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '¿De donde sos?',
          style: textStyle,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButton<String>(
                underline: Container(),
                isExpanded: true,
                value: selectedLocation,
                borderRadius: BorderRadius.circular(15),
                items: provincias
                    .map((String e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedLocation = newValue!;
                  });
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
