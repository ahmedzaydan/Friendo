import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendo/layout/cubit/friendo_cubit.dart';
import 'package:friendo/layout/home_layout.dart';
import 'package:friendo/modules/authentication/login.dart';
import 'package:friendo/modules/authentication/register.dart';
import 'package:friendo/shared/bloc_observer.dart';
import 'package:friendo/shared/components/constants.dart';
import 'package:friendo/shared/network/local/cache_controller.dart';
import 'package:friendo/shared/styles/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheController.init();

  Widget startWidget;
  uid = await CacheController.getData(key: 'uid');
  uid == null
      ? startWidget = LoginScreen()
      : startWidget = const HomeLayoutScreen();

  runApp(FriendoApp(startWidget));
}

class FriendoApp extends StatelessWidget {
  // const FriendoApp({super.key});
  final Widget startWidget;
  const FriendoApp(this.startWidget, {super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FriendoCubit()..getUserData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        home: startWidget,
        theme: lightTheme(),
      ),
    );
  }
}