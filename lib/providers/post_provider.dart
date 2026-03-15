import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/post_repository.dart';

class PostProvider extends ChangeNotifier {

  final PostRepository _repository = PostRepository();

  List<Post> posts = [];

  bool isLoading = false;

  int page = 0;

  Future<void> loadPosts() async {

    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    final newPosts = await _repository.fetchPosts(page);

    posts.addAll(newPosts);

    page++;

    isLoading = false;

    notifyListeners();
  }

  Future<void> refreshPosts() async {

    posts.clear();
    page = 0;

    notifyListeners();

    await loadPosts();
  }

  void toggleLike(Post post) {

    post.isLiked = !post.isLiked;

    notifyListeners();
  }

  void toggleSave(Post post) {

    post.isSaved = !post.isSaved;

    notifyListeners();
  }
}