import 'dart:async';
import '../models/post_model.dart';

class PostRepository {

  final List<String> images = [
    "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
    "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
    "https://images.unsplash.com/photo-1519125323398-675f0ddb6308",
    "https://images.unsplash.com/photo-1492724441997-5dc865305da7",
    "https://images.unsplash.com/photo-1501785888041-af3ef285b470",
  ];

  Future<List<Post>> fetchPosts(int page) async {

    /// simulate network latency
    await Future.delayed(const Duration(milliseconds: 1500));

    return List.generate(10, (index) {

      int imageCount = index % 3 == 0 ? 3 : 1;

      List<String> postImages = List.generate(
        imageCount,
        (i) => images[(page * 10 + index + i) % images.length],
      );

      List<double> ratios = [
        1,
        4 / 5,
        16 / 9,
      ];

      return Post(
        username: "user_${page * 10 + index}",
        userAvatar: images[(page * 10 + index) % images.length],
        images: postImages,
        caption: "Amazing place to visit 😍🔥",
        aspectRatio: ratios[index % ratios.length],
      );
    });
  }
}