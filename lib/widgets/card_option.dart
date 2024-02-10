import 'package:flutter/material.dart';

class CardOption extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const CardOption({super.key, required this.title, required this.description, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xffcccccc),
            width: 1,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xff80608B),
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(icon, color: Colors.white, size: 70),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Color(0xff5A4361), fontWeight: FontWeight.bold),
          ),
          Text(description,)
        ],
      ),
    );
  }
}
