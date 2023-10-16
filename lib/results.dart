import 'package:flutter/material.dart';
import 'package:steam_calculator/game.dart';

class ResultsWidget extends StatelessWidget {
  final List<Tax> taxes;

  const ResultsWidget({
    super.key,
    required this.taxes,
  });

  final textStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.teal[100],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(2),
          itemCount: taxes.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final tax = taxes[index];
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              title: Text(tax.description, style: textStyle),
              trailing:
                  Text('\$${tax.value.toStringAsFixed(2)}', style: textStyle),
            );
          },
        ),
      ),
    );
  }
}
