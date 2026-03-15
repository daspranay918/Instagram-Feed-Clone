import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostShimmer extends StatelessWidget {
  const PostShimmer({super.key});

  Widget shimmerBox({double height = 12, double width = double.infinity}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const CircleAvatar(radius: 16, backgroundColor: Colors.grey),
                const SizedBox(width: 10),
                shimmerBox(width: 120, height: 12),
              ],
            ),
          ),

          /// IMAGE
          Container(
            height: 350,
            color: Colors.grey.shade800,
          ),

          const SizedBox(height: 12),

          /// CAPTION LINES
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                shimmerBox(width: 200),
                const SizedBox(height: 8),
                shimmerBox(width: 150),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}