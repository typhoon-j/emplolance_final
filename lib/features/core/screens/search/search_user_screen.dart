import 'package:emplolance/constants/sizes.dart';
import 'package:emplolance/features/core/controllers/search_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../widgets/appbar.dart';
import '../ratings/user_rating_dashboard_widget.dart';
import '../user_selected_screen.dart';

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
              const SizedBox(
                height: 10,
              ),
              Text(
                'Busqueda de usuarios',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) => controller.searchUser(value),
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  contentPadding: EdgeInsets.all(12.0),
                  fillColor: Colors.transparent,
                ),
              ),
              const Divider(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Tus Resultados',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.users.length,
                          itemBuilder: (context, index) => GestureDetector(
                            //  onTap: listController.products[index].onPress,
                            child: SizedBox(
                              width: 320,
                              height: 200,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: tCardBgColor),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              controller.users[index].fullName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                                  ?.apply(color: Colors.black),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Flexible(
                                            child: ClipOval(
                                              //borderRadius: BorderRadius.circular(100),
                                              child: Image(
                                                image: NetworkImage(controller
                                                    .users[index].photo),
                                                height: 110,
                                                width: 110,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: const CircleBorder()),
                                              onPressed: () {
                                                Get.to(() => UserSelectedScreen(
                                                      userId: (controller
                                                              .users[index]
                                                              .userId)
                                                          .toString(),
                                                    ));
                                              },
                                              child: const Icon(Icons.info)),
                                          const SizedBox(
                                            width: tDashboardCardPadding,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Claificacion: ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4
                                                        ?.apply(
                                                            color:
                                                                Colors.black),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  UserRatingDashboardWidget(
                                                    userId: controller
                                                        .users[index].userId
                                                        .toString(),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
