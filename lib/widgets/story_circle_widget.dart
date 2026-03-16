import 'package:flutter/material.dart';
import 'profile_circle.dart';

class StoryCircleWidget extends StatelessWidget {
  final String imageUrl;
  final String username;

  const StoryCircleWidget({
    super.key,
    required this.imageUrl,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          /// GRADIENT RING
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFFF58529), // orange
                  Color.fromARGB(255, 246, 254, 23), // yellow
                  Color(0xFFDD2A7B), // pink
                  Color.fromARGB(255, 147, 73, 137), // purple
                  Color(0xFF515BD4), // blue
                ],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: ProfileCircle(imageUrl: imageUrl),
            ),
          ),

          const SizedBox(height: 4),

          SizedBox(
            height: 16, // SAME TEXT HEIGHT
            child: Text(
              username,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
