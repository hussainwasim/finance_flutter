import 'package:fin/res/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.onTap,
    required this.buttonTitle,
    this.margin,
    this.buttonColor,
  });

  final VoidCallback onTap;
  final String buttonTitle;
  final EdgeInsetsGeometry? margin;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        margin: margin ??
            const EdgeInsets.symmetric(
              horizontal: 25.0,
            ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: buttonColor ?? buttonColor ?? boxText,
        ),
        child: Row(
          children: [
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: buttonColor ?? boxText,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                size: 30,
                color: buttonColor ?? boxText,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              buttonTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            const SizedBox(
              width: 15,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.chevron_right_rounded,
                size: 35,
                color: buttonColor ?? boxText,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
