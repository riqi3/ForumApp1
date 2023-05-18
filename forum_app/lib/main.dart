import 'package:flutter/material.dart';
import 'package:forum_app/providers/TopicProvider.dart';
import 'package:forum_app/users/authentication/LoginScreen.dart';
import 'package:forum_app/widgets/NewSectionWidget.dart';
import 'package:forum_app/widgets/SectionWidget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'providers/SectionProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SectionProvider(),
          child: const ForumApp(),
        ),
        ChangeNotifierProvider(
          create: (_) => TopicProvider(),
          child: const ForumApp(),
        ),
      ],
      child: const ForumApp(),
    ),
  );
}

class ForumApp extends StatelessWidget {
  const ForumApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => SectionProvider()),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FORUM',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: HomeScreen(),
        home: FutureBuilder(
          builder: (context, dataSnapShot) {
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
