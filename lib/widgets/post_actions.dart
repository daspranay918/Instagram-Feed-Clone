import 'package:flutter/material.dart';

class PostActions extends StatefulWidget {
  const PostActions({super.key});

  @override
  State<PostActions> createState() => _PostActionsState();
}

class _PostActionsState extends State<PostActions>
    with SingleTickerProviderStateMixin {
  bool isLiked = false;
  bool isSaved = false;
  bool isReposted = false;

  late AnimationController likeController;
  late Animation<double> likeAnimation;

  @override
  void initState() {
    super.initState();

    likeController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    likeAnimation = Tween<double>(
      begin: 1,
      end: 1.3,
    ).animate(
      CurvedAnimation(
        parent: likeController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    likeController.dispose();
    super.dispose();
  }

  void showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Feature coming soon"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    likeController.forward().then((_) {
      likeController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [

          /// LIKE BUTTON
          GestureDetector(
            onTap: toggleLike,
            child: AnimatedBuilder(
              animation: likeController,
              builder: (context, child) {
                return Transform.scale(
                  scale: likeAnimation.value,
                  child: child,
                );
              },
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.white,
                size: 26,
              ),
            ),
          ),

          const SizedBox(width: 16),

          /// COMMENT
          GestureDetector(
            onTap: () => showComingSoon(context),
            child: const Icon(
              Icons.mode_comment_outlined,
              size: 26,
            ),
          ),

          const SizedBox(width: 16),

          /// REPOST
          GestureDetector(
            onTap: () {
              setState(() {
                isReposted = !isReposted;
              });
            },
            child: Icon(
              Icons.repeat,
              color: isReposted ? Colors.green : Colors.white,
              size: 26,
            ),
          ),

          const SizedBox(width: 16),

          /// SHARE
          GestureDetector(
            onTap: () => showComingSoon(context),
            child: const Icon(
              Icons.send_outlined,
              size: 26,
            ),
          ),

          const Spacer(),

          /// SAVE
          GestureDetector(
            onTap: () {
              setState(() {
                isSaved = !isSaved;
              });
            },
            child: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}