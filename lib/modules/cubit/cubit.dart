// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app_api_bloc/modules/cubit/states.dart';

import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_helper.dart';
import '../business/business_screen.dart';
import '../science/science_screen.dart';
import '../sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context as BuildContext);
  List<GButton> tabsBottomNavBar = const [
    GButton(
      icon: Icons.business_center,
      text: 'Business ',
    ),
    GButton(
      icon: Icons.science,
      text: 'science ',
    ),
    GButton(
      icon: Icons.sports,
      text: 'Sports ',
    ),
    // GButton(
    //   icon: Icons.settings,
    //   text: 'settings ',
    // ),
  ];
  List screens = [
    const BusinessScreen(),
    const ScienceScreen(),
    const SportsScreen(),
    // const SettinScreen()
  ];
  List titelScreen = [
    'BusinessScreen',
    'ScienceScreen',
    'SportsScreen',
    // 'SettinScreen'
  ];
  var selectedIndex = 0;
  void selectedScreenIndex(int index) {
    selectedIndex = index;
    if (index == 1) {
      getScience();
    }
    if (index == 2) {
      getSports();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLodingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '84a60e11e57244cf8971ce5305fcb039',
      },
    ).then((value) {
      print(value.data['articles'][0]['titel']);
      business = value.data['articles'];
      print(business[0]['titel']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetBusinessErrorState(onError.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLodingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '84a60e11e57244cf8971ce5305fcb039',
        },
      ).then((value) {
        print(value.data['articles'][0]['titel']);
        sports = value.data['articles'];
        print(sports[0]['titel']);
        emit(NewsGetSportsSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetSportsErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLodingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '84a60e11e57244cf8971ce5305fcb039',
        },
      ).then((value) {
        print(value.data['articles'][0]['titel']);
        science = value.data['articles'];
        print(science[0]['titel']);
        emit(NewsGetScienceSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetScienceErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];
  void getsearch(String value) {
    emit(NewsGetSearchLodingState());
    search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': '84a60e11e57244cf8971ce5305fcb039',
      },
    ).then((value) {
      print(value.data['articles'][0]['titel']);
      search = value.data['articles'];
      print(search[0]['titel']);
      emit(NewsGetSearchSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetSearchErrorState(onError.toString()));
    });
    // emit(NewsGetSearchSuccessState());
  }

  bool isDark = false;
  void changeAppMode() {
    isDark = !isDark;
    CasheHelper.setData(key: 'isDark', value: isDark)
        .then((value) => emit(AppChangeModeState()));
  }
}
