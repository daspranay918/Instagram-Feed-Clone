import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';
import '../widgets/bottom_navigation_widget.dart';
import '../widgets/post_widget.dart';
import '../widgets/story_circle_widget.dart';
import '../widgets/your_story_widget.dart';
import '../widgets/post_shimmer.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  final ScrollController _scrollController = ScrollController();

  bool showMenu = false;
  bool showArrow = false;

  double pullDistance = 0;
  bool isRefreshing = false;
  bool showIndicator = false;

  static const double refreshTrigger = 90;
  static const double maxPull = 130;

  void showComingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Coming soon"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().loadPosts();
    });

    /// Load next posts when user reaches 2 posts before the end
    _scrollController.addListener(() {
      final provider = context.read<PostProvider>();

      if (!provider.isLoading &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 400) {
        provider.loadPosts();
      }
    });
  }

  Future<void> refreshFeed() async {
    if (isRefreshing) return;

    setState(() {
      isRefreshing = true;
      pullDistance = refreshTrigger;
      showMenu = false;
      showArrow = false;
    });

    await context.read<PostProvider>().refreshPosts();

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      pullDistance = 0;
      showIndicator = false;
      isRefreshing = false;
    });
  }

  bool handleScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_scrollController.position.pixels <= 0 &&
          notification.dragDetails != null) {
        double delta = notification.dragDetails!.delta.dy;

        if (delta > 0) {
          setState(() {
            pullDistance += delta;

            if (pullDistance > maxPull) {
              pullDistance = maxPull;
            }

            showIndicator = pullDistance > refreshTrigger;
          });
        }
      }
    }

    if (notification is ScrollEndNotification) {
      if (showIndicator) {
        refreshFeed();
      } else {
        setState(() {
          pullDistance = 0;
        });
      }
    }

    return false;
  }

  Widget buildAppBarTitle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showMenu = !showMenu;
          showArrow = true;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Instagram",
            style: TextStyle(
              fontFamily: "Billabong",
              fontSize: 36,
              color: Colors.white,
            ),
          ),
          if (showArrow)
            const Icon(Icons.keyboard_arrow_down, color: Colors.white),
        ],
      ),
    );
  }

  Widget buildDropdown() {
    if (!showMenu) return const SizedBox();

    return Positioned(
      /// MOVED UP (was 80)
      top: 105,

      left: MediaQuery.of(context).size.width / 2 - 90,

      child: Container(
        /// REDUCED SIZE
        width: 160,

        padding: const EdgeInsets.symmetric(vertical: 6),

        decoration: BoxDecoration(
          /// INSTAGRAM STYLE GLASS GREY
          color: const Color(0xFF262626).withOpacity(0.95),

          borderRadius: BorderRadius.circular(18),

          boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 12)],
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: showComingSoon,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.people_outline, color: Colors.white, size: 28),
                    SizedBox(width: 20),
                    Text("Following", style: TextStyle(fontSize: 17)),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: showComingSoon,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.star_border, color: Colors.white, size: 28),
                    SizedBox(width: 20),
                    Text("Favorites", style: TextStyle(fontSize: 17)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: handleScroll,
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                /// APP BAR (HIDES ON SCROLL)
                SliverAppBar(
                  floating: true,
                  snap: true,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.add, size: 32),
                    onPressed: showComingSoon,
                  ),

                  centerTitle: true,
                  title: buildAppBarTitle(),

                  actions: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border, size: 28),
                      onPressed: showComingSoon,
                    ),
                  ],
                ),

                /// POSTS LIST
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final provider = context.watch<PostProvider>();

                      if (index == 0) {
                        return SizedBox(
                          height: pullDistance,
                          child: Center(
                            child: pullDistance > 20
                                ? Transform.rotate(
                                    angle: (pullDistance / maxPull) * 3.14 * 2,
                                    child: Opacity(
                                      opacity: (pullDistance / refreshTrigger)
                                          .clamp(0.0, 1.0),
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        );
                      }

                      if (index == 1) {
                        return SizedBox(
                          height: 140,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              SizedBox(width: 10),
                              YourStoryWidget(
                                imageUrl: "https://i.pravatar.cc/150?img=1",
                              ),
                              StoryCircleWidget(
                                imageUrl: "https://i.pravatar.cc/150?img=2",
                                username: "somuchamp",
                              ),
                              StoryCircleWidget(
                                imageUrl: "https://i.pravatar.cc/150?img=3",
                                username: "triggered",
                              ),
                              StoryCircleWidget(
                                imageUrl: "https://i.pravatar.cc/150?img=5",
                                username: "bra1nooo",
                              ),
                              StoryCircleWidget(
                                imageUrl: "https://i.pravatar.cc/150?img=6",
                                username: "alex",
                              ),
                            ],
                          ),
                        );
                      }

                      if (provider.isLoading &&
                          index == provider.posts.length + 2) {
                        return const PostShimmer();
                      }

                      final post = provider.posts[index - 2];

                      return PostWidget(
                        username: post.username,
                        profileImage: post.userAvatar,
                        audioName: "Original Audio",
                        images: post.images,
                        aspectRatio: post.aspectRatio,
                        caption: post.caption,
                        likes: 120,
                        timeAgo: "12 hours ago",
                      );
                    },
                    childCount:
                        context.watch<PostProvider>().posts.length +
                        2 +
                        (context.watch<PostProvider>().isLoading ? 1 : 0),
                  ),
                ),
              ],
            ),
          ),

          buildDropdown(),
        ],
      ),

      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
