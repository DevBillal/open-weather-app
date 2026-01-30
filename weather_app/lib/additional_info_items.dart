import 'package:flutter/material.dart';

class AdditionalInfoItems extends StatelessWidget {
  final IconData icon;
  final String lable;
  final String value;
  const AdditionalInfoItems({super.key,required this.icon,required this.lable,required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        SizedBox(height: 8.0),
        Text(lable, style: TextStyle(fontSize: 16)),
        SizedBox(height: 8.0),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
