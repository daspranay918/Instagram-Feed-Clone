import 'dart:ui';
import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  final String username;
  final String profileImage;
  final String audioName;

  const PostHeader({
    super.key,
    required this.username,
    required this.profileImage,
    required this.audioName,
  });

  void showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Coming soon"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [

          /// PROFILE IMAGE
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(profileImage),
          ),

          const SizedBox(width: 10),

          /// USERNAME + AUDIO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                Row(
                  children: [
                    const Icon(Icons.music_note, size: 14),
                    const SizedBox(width: 3),

                    Expanded(
                      child: Text(
                        audioName,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// FOLLOW BUTTON
          GestureDetector(
            onTap: () => showComingSoon(context),
            child: Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: const Text(
                "Follow",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          /// THREE DOT MENU
          GestureDetector(
            onTap: () => showComingSoon(context),
            child: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}