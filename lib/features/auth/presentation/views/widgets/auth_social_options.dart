import 'dart:math' as math;

import 'package:e_learning/core/themes/app_color.dart';
import 'package:flutter/material.dart';

class AuthSocialOptions extends StatelessWidget {
  const AuthSocialOptions({super.key, this.isSignUp = false});

  final bool isSignUp;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              isSignUp ? 'or sign up with' : 'or continue with',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.textPrimary,
              ),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
      const SizedBox(height: 32),
      // These are visual placeholders; social authentication is not connected.
      const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ProviderIcon(
            label: 'Google',
            child: CustomPaint(size: Size.square(28), painter: _GoogleLogo()),
          ),
          SizedBox(width: 32),
          _ProviderIcon(
            label: 'Facebook',
            child: Icon(Icons.facebook, size: 48, color: Color(0xFF1877F2)),
          ),
          SizedBox(width: 32),
          _ProviderIcon(
            label: 'Apple',
            child: Icon(Icons.apple, size: 38, color: Colors.black),
          ),
        ],
      ),
    ],
  );
}

class _ProviderIcon extends StatelessWidget {
  const _ProviderIcon({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    button: true,
    enabled: false,
    child: ExcludeSemantics(
      child: Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Color(0x08000000), offset: Offset(0, 1), blurRadius: 2),
          ],
        ),
        child: child,
      ),
    ),
  );
}

class _GoogleLogo extends CustomPainter {
  const _GoogleLogo();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 24, size.height / 24);
    const bounds = Rect.fromLTWH(3, 3, 18, 18);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawArc(bounds, 0, math.pi * 0.25, false, paint..color = const Color(0xFF4285F4));
    canvas.drawArc(bounds, math.pi * 0.25, math.pi * 0.55, false, paint..color = const Color(0xFF34A853));
    canvas.drawArc(bounds, math.pi * 0.8, math.pi * 0.4, false, paint..color = const Color(0xFFFBBC05));
    canvas.drawArc(bounds, math.pi * 1.2, math.pi * 0.55, false, paint..color = const Color(0xFFEA4335));
    paint
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF4285F4);
    canvas.drawRect(const Rect.fromLTWH(12, 10, 11.5, 4.5), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _GoogleLogo oldDelegate) => false;
}
