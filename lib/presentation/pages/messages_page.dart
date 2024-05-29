import 'package:flutter/material.dart';
import 'package:ocean_talk/presentation/widget/message_tile.dart';
import '../model/message_data.dart';

import '../widget/custom_appbar.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage>
    with SingleTickerProviderStateMixin {
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
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CustomAppBar(tabController: _tabController),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                itemCount: listMessages.length,
                itemBuilder: (context, index) {
                  return MessageTile(messageData: listMessages[index]);
                },
              ),
              const Center(child: Text('Friends tab')),
              const Center(child: Text('Group tab')),
            ],
          )),
    );
  }
}
