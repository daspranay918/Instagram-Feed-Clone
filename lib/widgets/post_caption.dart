import 'package:flutter/material.dart';

class PostCaption extends StatelessWidget {
  final String username;
  final String caption;
  final int likes;
  final String timeAgo;

  const PostCaption({
    super.key,
    required this.username,
    required this.caption,
    required this.likes,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// LIKES TEXT
          Text(
            "Liked by $likes people",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 4),

          /// USERNAME + CAPTION
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
              children: [
                TextSpan(
                  text: "$username ",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: caption),
              ],
            ),
          ),

          const SizedBox(height: 4),

          /// TIME AGO
          Text(
            timeAgo,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}