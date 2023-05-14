import 'package:emplolance/constants/sizes.dart';
import 'package:emplolance/features/core/controllers/search_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/appbar.dart';

class SearchUserScreen extends StatelessWidget {
  const SearchUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchUserController());

    return Scaffold(
      appBar: DashboardAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              TextField(
                onChanged: (value) => controller.filterUser(value),
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  contentPadding: EdgeInsets.all(12.0),
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                ),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.foundUsers.value.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        controller.foundUsers.value[index]['fulname'],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        controller.foundUsers.value[index]['email'],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
