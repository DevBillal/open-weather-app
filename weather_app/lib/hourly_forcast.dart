import 'package:flutter/material.dart';

class HourlyForcastItems extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temp;
  const HourlyForcastItems({
    super.key,
    required this.time,
    required this.icon,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.0),

            Icon(icon),

            SizedBox(height: 8.0),

            Text(temp, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
