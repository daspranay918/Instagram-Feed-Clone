import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final String imageUrl;
  final String username;
  final bool isYourStory;

  const StoryItem({
    super.key,
    required this.imageUrl,
    required this.username,
    this.isYourStory = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Stack(
            children: [
              // Story circle
              Container(
                padding: const EdgeInsets.all(3),
                decoration: isYourStory
                    ? null
                    : const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple,
                            Colors.red,
                            Colors.orange,
                            Colors.yellow,
                          ],
                        ),
                      ),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
              ),

              // "+" button for your story
              if (isYourStory)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 15,
                      color: Colors.black,
                    ),
                  ),
                )
            ],
          ),

          const SizedBox(height: 4),

          Text(
            username,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}