import 'package:flutter/material.dart';

class TaxCard extends StatelessWidget {
  const TaxCard({
    super.key,
    required this.description,
    required this.amount,
  });

  final String description;
  final double amount;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: const EdgeInsets.only(
        top: 30.0,
        left: 10,
        right: 10,
        bottom: 15,
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                description,
                style: textStyle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              "\$${amount.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
