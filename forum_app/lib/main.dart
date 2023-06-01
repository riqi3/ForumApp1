import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forum_app/providers/TopicProvider.dart';
import 'package:forum_app/screens/LoginScreen.dart';
import 'package:forum_app/widgets/NewSectionWidget.dart';
import 'package:forum_app/widgets/SectionWidget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'home.dart';
import 'models/UserCubitModel.dart';
import 'models/UserModel.dart';
import 'providers/SectionProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

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
    return BlocProvider(create: (context){
      return UserCubit(User());
    },
    child: ChangeNotifierProvider(
      create: ((context) => SectionProvider()),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FORUM',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(),
        // home: HomeScreen(),
        // home: FutureBuilder(
        //   builder: (context, dataSnapShot) {
        //     return LoginScreen();
        //   },
        // ),
      ),
    ),
    );
  }
}
