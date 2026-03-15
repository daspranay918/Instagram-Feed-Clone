import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int selectedIndex = 0;

  void onTapItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget buildIcon(int index, IconData filled, IconData outline) {
    bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onTapItem(index),
        child: SizedBox(
          height: 40,
          child: Transform.translate(
            offset: const Offset(0, -10),
            child: Center(
              child: SizedBox(
                width: isSelected ? 34 : 30, // width change
                child: Icon(
                  isSelected ? filled : outline,
                  color: Colors.white,
                  size: isSelected ? 30 : 26, // size change
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          /// HOME
          buildIcon(0, Icons.home, Icons.home_outlined),

          /// SEARCH
          buildIcon(1, Icons.search, Icons.search_outlined),

          /// CREATE
          buildIcon(2, Icons.add_box, Icons.add_box_outlined),

          /// REELS
          buildIcon(3, Icons.video_library, Icons.video_library_outlined),

          /// PROFILE
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => onTapItem(4),
              child: SizedBox(
                height: 40,
                child: Transform.translate(
                  offset: const Offset(0, -10),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedIndex == 4
                              ? Colors.white
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),

                      /// PROFILE IMAGE
                      child: Container(
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.6, // hairline border
                          ),
                          image: const DecorationImage(
                            image: NetworkImage(
                              "https://i.pravatar.cc/150?img=1",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
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
