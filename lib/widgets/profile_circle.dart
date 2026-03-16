import 'package:flutter/material.dart';

class ProfileCircle extends StatelessWidget {
  final String imageUrl;
  final double size;

  const ProfileCircle({
    super.key,
    required this.imageUrl,
    this.size = 92,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
          width: 0.6, // hairline border
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}