import 'package:flutter/material.dart';

class ImageBackGround extends StatelessWidget {
  const ImageBackGround({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225.0,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        image: DecorationImage(
          image: AssetImage('assets/img.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}