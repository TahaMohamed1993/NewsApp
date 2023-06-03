import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api_bloc/modules/cubit/cubit.dart';
import 'package:news_app_api_bloc/modules/cubit/states.dart';

import '../../shared/widget_component.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (BuildContext context, state) {
        List list = NewsCubit.get(context).sports;

        return atriclBuilder(list);
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
