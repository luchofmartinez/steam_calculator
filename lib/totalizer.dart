import 'package:flutter/material.dart';

class Totalizer extends StatelessWidget {
  const Totalizer({super.key, required this.totalAmount});
  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'Total: \$${totalAmount.toStringAsFixed(2)}',
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
