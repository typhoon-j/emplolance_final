import 'package:emplolance/features/authentication/controllers/profile_controller.dart';
import 'package:emplolance/features/authentication/models/user_model.dart';
import 'package:emplolance/features/core/models/courses_model.dart';
import 'package:emplolance/features/core/screens/products/product_selected_screen.dart';
import 'package:emplolance/features/core/screens/user_selected_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/sizes.dart';
import '../controllers/product_controller.dart';

class DashboardTopUsers extends StatelessWidget {
  const DashboardTopUsers({
    Key? key,
    required this.txtTheme,
  }) : super(key: key);

  final TextTheme txtTheme;

  @override
  Widget build(BuildContext context) {
    final listController = Get.put(ProfileController());
    return SizedBox(
        height: 200,
        child: FutureBuilder<List<UserModel>>(
          future: listController.getAllUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: 320,
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, top: 5),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: tCardBgColor),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      snapshot.data![index].fullName,
                                      style: txtTheme.headline4
                                          ?.apply(color: Colors.black),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Flexible(
                                    child: ClipOval(
                                      //borderRadius: BorderRadius.circular(100),
                                      child: Image(
                                        image: NetworkImage(
                                            snapshot.data![index].photo),
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
                                              userId:
                                                  (snapshot.data![index].userId)
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
                                      Text(
                                        'Claificacion: ',
                                        style: txtTheme.headline4
                                            ?.apply(color: Colors.black),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Precio: ${snapshot.data![index].description}',
                                        style: txtTheme.bodyText2
                                            ?.apply(color: Colors.black),
                                        overflow: TextOverflow.ellipsis,
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
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
