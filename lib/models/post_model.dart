class Post {

  final String username;
  final String userAvatar;
  final List<String> images;
  final String caption;
  final double aspectRatio;

  bool isLiked;
  bool isSaved;

  Post({
    required this.username,
    required this.userAvatar,
    required this.images,
    required this.caption,
    required this.aspectRatio,
    this.isLiked = false,
    this.isSaved = false,
  });
}