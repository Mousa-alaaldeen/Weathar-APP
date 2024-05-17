// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'forecast next 5 days '.toUpperCase(),
          style: Theme.of(context).textTheme.caption!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
        ),
        Icon(
          Icons.next_plan_outlined,
          color: Colors.black87,
        ),
      ],
    );
  }
}
