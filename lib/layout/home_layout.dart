import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app_api_bloc/modules/cubit/states.dart';

import '../modules/cubit/cubit.dart';
import '../modules/search/search.dart';
import '../shared/widget_component.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({
    super.key,
  });

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, NewsStates state) {},
      builder: (BuildContext context, NewsStates state) {
        NewsCubit cubit = NewsCubit.get(context);

        return Scaffold(
          bottomNavigationBar: GNav(
            tabBackgroundColor: Colors.grey[300]!,
            activeColor: Colors.deepOrange,
            padding: const EdgeInsets.all(16.0),
            gap: .5,
            selectedIndex: cubit.selectedIndex,
            onTabChange: cubit.selectedScreenIndex,
            tabs: cubit.tabsBottomNavBar,
          ),
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    navigatorTo(context, const SearchScreen());
                  },
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    NewsCubit.get(context).changeAppMode();
                  },
                  icon: const Icon(Icons.brightness_4_outlined)),
            ],
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(cubit.titelScreen[cubit.selectedIndex]),
          ),
          body: cubit.screens[cubit.selectedIndex],
        );
      },
    );
  }
}
