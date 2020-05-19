import 'package:flutter/material.dart';
import 'package:onboarding_concept/constants.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool obscureText;

  const CustomTextField({
    @required this.label,
    @required this.icon,
    this.obscureText = false,
  })  : assert(label != null),
        assert(icon != null);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(kPaddingM),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.12),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.12),
          ),
        ),
        hintText: label,
        hintStyle: TextStyle(
          color: kBlack.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          icon,
          color: kBlack.withOpacity(0.5),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
