import 'package:flutter/material.dart';
import 'social_button.dart';

class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final String loadingText;
  final IconData? icon;
  final VoidCallback onPressed;

  const LoadingButton({
    super.key,
    required this.isLoading,
    required this.text,
    required this.loadingText,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SocialButton(
      text: isLoading ? loadingText : text,
      icon: icon,
      onPressed: isLoading ? () {} : onPressed,
    );
  }
}
