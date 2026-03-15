import 'package:flutter/material.dart';
import 'package:instagram_feed_clone/widgets/post_actions.dart';
import 'package:instagram_feed_clone/widgets/post_header.dart';
import 'package:instagram_feed_clone/widgets/post_media.dart';
import 'post_caption.dart';

class PostWidget extends StatelessWidget {
  final String username;
  final String profileImage;
  final String audioName;
  final List<String> images;
  final double aspectRatio;
  final String caption;
  final int likes;
  final String timeAgo;

  const PostWidget({
    super.key,
    required this.username,
    required this.profileImage,
    required this.audioName,
    required this.images,
    required this.aspectRatio,
    required this.caption,
    required this.likes,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// HEADER
          PostHeader(
            username: username,
            profileImage: profileImage,
            audioName: audioName,
          ),

          /// MEDIA
          PostMedia(
            images: images,
            aspectRatio: aspectRatio,
          ),

          /// ACTIONS
          const PostActions(),

          /// CAPTION
          PostCaption(
            username: username,
            caption: caption,
            likes: likes,
            timeAgo: timeAgo,
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}