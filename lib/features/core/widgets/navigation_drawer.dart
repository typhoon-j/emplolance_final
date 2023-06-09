import 'package:emplolance/features/core/screens/dashboard.dart';
import 'package:emplolance/features/core/screens/history/history_screen.dart';
import 'package:emplolance/features/core/screens/search/search_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../messaging/screens/chat_list_screen.dart';
import '../screens/search/search_product_screen.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home_rounded),
              title: Text('Inicio'),
              onTap: () {
                Get.to(() => const Dashboard());
              },
            ),
            ListTile(
              leading: Icon(Icons.forum_rounded),
              title: Text('Mensajes'),
              onTap: () {
                Get.to(() => ChatListScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.person_search_rounded),
              title: Text('Busqueda de usuarios'),
              onTap: () {
                Get.to(() => const SearchUserScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.travel_explore_rounded),
              title: Text('Busqueda por categorias'),
              onTap: () {
                Get.to(() => const SearchProductScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.hourglass_bottom_rounded),
              title: Text('Historial y Solicitudes'),
              onTap: () {
                Get.to(() => const HistoryScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
