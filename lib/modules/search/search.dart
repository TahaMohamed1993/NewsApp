import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api_bloc/modules/cubit/cubit.dart';

import '../../shared/widget_component.dart';
import '../cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController? searchController;
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (BuildContext context, state) {
        var list = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: dufaltFormField(
                  onChanged: (onSearch) {
                    NewsCubit.get(context).getsearch(onSearch);
                  },
                  hintText: 'search',
                  icon: const Icon(Icons.search),
                  keyboardType: TextInputType.text,
                  validat: (String? value) {
                    if (value!.isEmpty) {
                      return 'the Search could not empty';
                    } else {
                      return null;
                    }
                  },
                  controller: searchController,
                ),
              ),
              Expanded(child: atriclBuilder(list)),
            ],
          ),
        );
      },
    );
  }
}
