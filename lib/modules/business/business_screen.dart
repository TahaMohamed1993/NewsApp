import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api_bloc/modules/cubit/cubit.dart';
import 'package:news_app_api_bloc/modules/cubit/states.dart';

import '../../shared/widget_component.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (BuildContext context, state) {
        List list = NewsCubit.get(context).business;

        return atriclBuilder(list);
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
