import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc_observer.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/cubites/social_cubit/social_cubit.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/layouts/home_layout.dart';
import 'package:social_app/service/cache_helper.dart';
import 'package:social_app/views/social_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  uId = CacheHelper.getData(key: 'uId');
  Widget startWidget;
  if (uId.isNotEmpty) {
    startWidget = const HomeLayout();
  } else {
    startWidget = SocialLoginScreen();
  }
  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});
  final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SocialCubit()..getUserData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorSchemeSeed: Colors.blue, fontFamily: 'NotoSans'),
        home: startWidget,
      ),
    );
  }
}
