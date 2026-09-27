import 'package:e_learning/core/themes/app_color.dart';
import 'package:flutter/material.dart';

class AuthPageHeader extends StatelessWidget {
  const AuthPageHeader({super.key, this.isSignUp = false});

  final bool isSignUp;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(
      24,
      56 + MediaQuery.paddingOf(context).top,
      24,
      54,
    ),
    decoration: const BoxDecoration(
      color: AppColor.primary,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(80)),
      boxShadow: [
        BoxShadow(color: AppColor.shadow, blurRadius: 6, offset: Offset(0, 3)),
      ],
    ),
    child: Column(
      children: [
        const Text(
          'CS Academy',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 32,
            height: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          isSignUp ? 'Sign up' : 'Login',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            height: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
