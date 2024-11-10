import 'package:flutter/material.dart';
import 'package:spotify/common/helpers/responsive.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;

  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          context.isPhoneScreen
              ? context.screenWidth
              : context.responsiveScreenWidth,
          height ?? 80,
        ),
      ),
      child: Text(title),
    );
  }
}
