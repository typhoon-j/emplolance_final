import 'package:flutter/material.dart';

import '../widgets/appbar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DashboardAppBar(),
      body: SingleChildScrollView(
        child: Text('Chat Screen'),
      ),
    );
  }
}
