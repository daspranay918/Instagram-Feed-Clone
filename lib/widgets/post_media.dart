import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';

class PostMedia extends StatefulWidget {
  final List<String> images;
  final double aspectRatio;

  const PostMedia({
    super.key,
    required this.images,
    required this.aspectRatio,
  });

  @override
  State<PostMedia> createState() => _PostMediaState();
}

class _PostMediaState extends State<PostMedia>
    with AutomaticKeepAliveClientMixin {
  int currentPage = 0;
  bool showHeart = false;

  late PageController pageController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    pageController = PageController();

    /// PRELOAD IMAGES FOR SMOOTH SCROLL
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var url in widget.images) {
        precacheImage(
          CachedNetworkImageProvider(url),
          context,
        );
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void triggerHeart() {
    setState(() {
      showHeart = true;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          showHeart = false;
        });
      }
    });
  }

  Widget buildImage(String url) {
    return GestureDetector(
      onDoubleTap: triggerHeart,
      child: PinchZoomReleaseUnzoomWidget(
        minScale: 1,
        maxScale: 4,
        resetDuration: const Duration(milliseconds: 250),
        overlayColor: Colors.black,
        useOverlay: true,

        child: CachedNetworkImage(
          imageUrl: url,

          fit: BoxFit.cover,

          width: double.infinity,
          height: double.infinity,

          /// VERY IMPORTANT FOR PERFORMANCE
          fadeInDuration: const Duration(milliseconds: 150),
          memCacheWidth: 1200,

          placeholder: (context, url) => Container(
            color: Colors.black,
          ),

          errorWidget: (context, url, error) => const Center(
            child: Icon(
              Icons.broken_image,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RepaintBoundary(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: widget.aspectRatio,
                child: widget.images.length == 1
                    ? buildImage(widget.images.first)
                    : PageView.builder(
                        controller: pageController,
                        itemCount: widget.images.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return buildImage(widget.images[index]);
                        },
                      ),
              ),

              /// HEART ANIMATION
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: showHeart ? 1 : 0,
                child: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 90,
                ),
              ),

              /// IMAGE COUNTER
              if (widget.images.length > 1)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${currentPage + 1}/${widget.images.length}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          /// DOT INDICATOR
          if (widget.images.length > 1)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.images.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: currentPage == index ? 8 : 6,
                    height: currentPage == index ? 8 : 6,
                    decoration: BoxDecoration(
                      color:
                          currentPage == index ? Colors.blue : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}