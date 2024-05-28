
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ocean_talk/common/delegate/search_delegate.dart';
import 'package:ocean_talk/presentation/pages/chat_pages.dart';
import 'package:ocean_talk/presentation/pages/friends_page.dart';

import '../../bloc/search/search_bloc.dart';
import '../../common/common_widget.dart';
import '../pages/groups_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: ScreenUtil().screenWidth * 0.6,
                child:  TabBar(
                  tabAlignment: TabAlignment.start,
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.only(left:10.w,right: 10.w),
                  indicatorPadding: EdgeInsets.only(left: 5.w,right: 5.w),
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  tabs:  [
                    Text('Chat',style: Theme.of(context).textTheme.titleMedium,),
                    Text('Friends',style: Theme.of(context).textTheme.titleMedium,),
                    Text('Groups',style: Theme.of(context).textTheme.titleMedium,),
                  ],
                ),
              ),
              Row(
                children: [
                  buildIconButton((){
                    showSearch(context: context, delegate: CustomUserSearchDelegate(BlocProvider.of<SearchBloc>(context)));
                  }, Ionicons.search_outline),
                  Gap(10.w),
                  buildIconButton((){}, Ionicons.person_circle_outline),
                ],
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ChatPages(),
            FriendsPage(),
            GroupScreen(),
          ],
        )
      ),
    );
  }
}
