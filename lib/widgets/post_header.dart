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

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

      child: Row(
        children: [

          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(profileImage),
          ),

          const SizedBox(width: 10),

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

                Text(
                  audioName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const Icon(Icons.more_vert),
        ],
      ),
    );
  }
}