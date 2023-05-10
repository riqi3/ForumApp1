import 'package:flutter/material.dart';
import 'package:forum_app/widgets/NewSectionWidget.dart';
import 'package:forum_app/widgets/SectionWidget.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'providers/SectionProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SectionProvider(),
          child: ForumApp(),
        ),
      ],
      child: ForumApp(),
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FORUM',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
        },
      ),
    );
  }
}
