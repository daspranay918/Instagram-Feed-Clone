import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/post_provider.dart';
import 'screens/home_feed_screen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(

      create: (_) => PostProvider(),

      child: MaterialApp(

        debugShowCheckedModeBanner: false,

        title: 'Instagram Feed Clone',

        theme: ThemeData.dark(),

        home: const HomeFeedScreen(),
      ),
    );
  }
}