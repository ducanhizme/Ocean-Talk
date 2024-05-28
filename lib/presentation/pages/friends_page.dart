import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_talk/bloc/friend/friend_bloc.dart';

import '../widget/friend_card.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  void initState() {
    BlocProvider.of<FriendBloc>(context).add(FetchFriend('userId', []));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FriendBloc, FriendState>(
        builder: (BuildContext context, FriendState state) {
          if (state is FriendLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FriendFetched) {
            return  Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              child: ListView.builder(
                  itemCount: state.listFriend.length,
                  itemBuilder: (context, index) => FriendCard(friend: state.listFriend[index])),
            );
          }
          return const Center(child: Text('No Friends'));
        },
      ),
    );
  }
}


