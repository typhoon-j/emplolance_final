import 'package:flutter/material.dart';

import '../widgets/appbar.dart';

class SearchUserScreen extends StatelessWidget {
  const SearchUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DashboardAppBar(),
      body: SingleChildScrollView(
        child: Text('Search User'),
      ),
    );
  }
}
