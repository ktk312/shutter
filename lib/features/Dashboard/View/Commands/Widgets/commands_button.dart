import 'package:flutter/material.dart';

class CommandButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onTap;

  CommandButton({
    required this.icon,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.9),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: Colors.white.withOpacity(0.9),
              ),
              SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.white.withOpacity(0.8),
          ),
        ],
      ),
    );
  }
}
