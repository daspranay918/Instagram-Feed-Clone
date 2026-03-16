import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/post_repository.dart';

class PostProvider extends ChangeNotifier {

  final PostRepository _repository = PostRepository();

  List<Post> posts = [];

  bool isLoading = false;
  bool isInitialLoading = true;

  int page = 0;

  /// FIRST LOAD
  Future<void> loadPosts() async {

    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    final newPosts = await _repository.fetchPosts(page);

    posts.addAll(newPosts);

    page++;

    isLoading = false;
    isInitialLoading = false;

    notifyListeners();
  }

  /// REFRESH
  Future<void> refreshPosts() async {

    posts.clear();
    page = 0;

    isInitialLoading = true;

    notifyListeners();

    await loadPosts();
  }
}