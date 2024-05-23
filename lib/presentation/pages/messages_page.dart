import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ocean_talk/presentation/widget/message_tile.dart';

import '../widget/custom_appbar.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(tabController: _tabController),
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return const MessageTile();
              },
            ),
            Center(child: Text('Friends tab')),
            Center(child: Text('Group tab')),
          ],
        ),
      ),
    );
  }
}
