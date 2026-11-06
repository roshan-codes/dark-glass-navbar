import 'package:flutter/material.dart';

enum AppUser {
  roshan(
    name: 'Roshan',
    imageUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
    fallbackBg: Color(0xFF8B263E),
    initials: 'R',
  ),
  priya(
    name: 'Priya',
    imageUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=300&q=80',
    fallbackBg: Color(0xFF2E5077),
    initials: 'P',
  ),
  aarav(
    name: 'Aarav',
    imageUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80',
    fallbackBg: Color(0xFF386641),
    initials: 'A',
  ),
  neha(
    name: 'Neha',
    imageUrl:
        'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=300&q=80',
    fallbackBg: Color(0xFF7B2D26),
    initials: 'N',
  ),
  james(
    name: 'James',
    imageUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80',
    fallbackBg: Color(0xFF264653),
    initials: 'J',
  );

  final String name;
  final String imageUrl;
  final Color fallbackBg;
  final String initials;

  const AppUser({
    required this.name,
    required this.imageUrl,
    required this.fallbackBg,
    required this.initials,
  });
}

class AppAvatar extends StatelessWidget {
  final AppUser user;
  final double size;
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;

  const AppAvatar({
    super.key,
    required this.user,
    this.size = 40,
    this.showBorder = false,
    this.borderColor = Colors.white,
    this.borderWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: showBorder
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
      ),
      child: ClipOval(
        child: Image.network(
          user.imageUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: user.fallbackBg,
              alignment: Alignment.center,
              child: Text(
                user.initials,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size * 0.42,
                ),
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: user.fallbackBg.withOpacity(0.6),
              alignment: Alignment.center,
              child: Text(
                user.initials,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size * 0.42,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
