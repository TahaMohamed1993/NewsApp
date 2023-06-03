import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api_bloc/network/remote/dio_helper.dart';
import 'package:news_app_api_bloc/shared/bloc_observer/bloc_observer.dart';
import 'layout/home_layout.dart';
import 'modules/cubit/cubit.dart';
import 'modules/cubit/states.dart';
import 'network/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CasheHelper.inti();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NewsCubit()
              ..getBusiness()
              ..getSports()
              ..getScience()),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) => MaterialApp(
          title: 'NewsApp',
          debugShowCheckedModeBanner: false,
          themeMode:
              NewsCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
          darkTheme: ThemeData(
            navigationBarTheme: const NavigationBarThemeData(
                backgroundColor: Colors.deepOrange),
            textTheme: Typography.whiteCupertino,
            iconTheme: const IconThemeData(color: Colors.deepOrange),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white),
            scaffoldBackgroundColor: Colors.blueGrey,
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                backgroundColor: Colors.grey,
                iconTheme: IconThemeData(color: Colors.deepOrange)),
          ),
          theme: ThemeData(
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.grey),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              centerTitle: true,
            ),
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
            useMaterial3: true,
          ),
          home: const HomeLayout(),
        ),
        listener: (context, state) {},
      ),
    );
  }
}
