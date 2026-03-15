import 'package:flutter/material.dart';
import 'profile_circle.dart';

class YourStoryWidget extends StatelessWidget {
  final String imageUrl;

  const YourStoryWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [

          /// TOP SPACE (to match gradient ring height)
          const SizedBox(height: 6),

          Stack(
            clipBehavior: Clip.none,
            children: [

              /// PROFILE IMAGE
              ProfileCircle(imageUrl: imageUrl),

              /// PLUS ICON
              Positioned(
                bottom: -6,
                right: -6,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 3),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const SizedBox(
            height: 16, // FIXED TEXT HEIGHT
            child: Text(
              "Your story",
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}