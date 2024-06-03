import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ocean_talk/presentation/widget/user_card.dart';

import '../../bloc/search/search_bloc.dart';
import '../../data/models/app_user.dart';

class CustomUserSearchDelegate extends SearchDelegate<AppUser>{
  final SearchBloc searchBloc;

  @override
  String get searchFieldLabel => 'Search name of user';
  @override
  TextStyle get searchFieldStyle =>const  TextStyle(color: Colors.black, fontSize: 14.0);

  CustomUserSearchDelegate(this.searchBloc);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon:const Icon(Icons.clear),
        onPressed: () {
          query = '';
          searchBloc.add(SearchCleared());
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Ionicons.arrow_back_circle_outline),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchBloc.add(FetchSearch(query));
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: searchBloc,
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child:  CircularProgressIndicator());
        } else if (state is SearchSuccess) {
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w),
            child: ListView.builder(
              itemCount: state.listUser.length,
              itemBuilder: (context, index) {
                final user = state.listUser[index];
                return UserCard(user: user);
              },
            ),
          );
        } else {
          return  const Center(child: Text('No results found.'));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchBloc.add(FetchSearch(query));
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: searchBloc,
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child:  CircularProgressIndicator());
        } else if (state is SearchSuccess) {
          return ListView.builder(
            itemCount: state.listUser.length,
            itemBuilder: (context, index) {
              final user = state.listUser[index];
              return UserCard(user: user);
            },
          );
        } else {
          return const Text('No results found.');
        }
      },
    );
  }
}