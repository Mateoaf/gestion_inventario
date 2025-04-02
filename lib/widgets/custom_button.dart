import 'package:flutter/material.dart';

enum CustomButtonVariant {
  primary,
  secondary,
}

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final CustomButtonVariant variant;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.variant = CustomButtonVariant.primary,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Configuración de estilo según la variante
    Color bgColor;
    Color fgColor;

    switch (variant) {
      case CustomButtonVariant.primary:
        bgColor = backgroundColor ?? Colors.blue;
        fgColor = textColor ?? Colors.white;
        break;
      case CustomButtonVariant.secondary:
        bgColor = backgroundColor ?? Colors.grey;
        fgColor = textColor ?? Colors.black;
        break;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}