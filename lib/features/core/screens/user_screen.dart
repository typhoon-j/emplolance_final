import 'package:emplolance/constants/colors.dart';
import 'package:emplolance/constants/image_strings.dart';
import 'package:emplolance/constants/sizes.dart';
import 'package:emplolance/constants/text_strings.dart';
import 'package:emplolance/features/core/controllers/rating_controller.dart';
import 'package:emplolance/features/core/screens/products/add_products.dart';
import 'package:emplolance/features/core/screens/products/products_screen.dart';
import 'package:emplolance/features/core/screens/profile_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../authentication/controllers/profile_controller.dart';
import '../../authentication/models/user_model.dart';
import '../../authentication/repository/authentication_repository.dart';
import '../controllers/product_controller.dart';
import '../widgets/profile_menu.dart';
import '../widgets/ratings/rater_image_widget.dart';
import '../widgets/ratings/rater_name_widget.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final listController = Get.put(ProductController());
    final listRatingController = Get.put(RatingController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          'Tu perfil',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipOval(
                                //borderRadius: BorderRadius.circular(100),
                                child: Image(
                              image: NetworkImage(userData.photo),
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        userData.fullName,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('5 ',
                              style: Theme.of(context).textTheme.bodyText2),
                          const Icon(
                            Icons.star_outlined,
                            size: 25,
                          ),
                        ],
                      ),
                      //Text('5 ', //userData.email, style: Theme.of(context).textTheme.bodyText2, ),
                      const SizedBox(
                        height: 20,
                      ),
                      DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color(0xFF2C2D32),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent malesuada laoreet urna, a ornare neque pellentesque ut. Integer vehicula aliquam justo elementum mollis.',
                              //userData.description,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          )),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Tus productos',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                                  itemCount: listController.products.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    //  onTap: listController.products[index].onPress,
                                    child: SizedBox(
                                      width: 320,
                                      height: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, top: 5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: tCardBgColor),
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      listController
                                                          .products[index].name,
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
                                                  ),
                                                  Flexible(
                                                    child: ClipOval(
                                                      //borderRadius:                                                          BorderRadius.circular(                                                              100),
                                                      child: Image(
                                                        image: NetworkImage(
                                                            listController
                                                                .products[index]
                                                                .imageUrl),
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
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              shape:
                                                                  const CircleBorder()),
                                                      onPressed: () {},
                                                      child: const Icon(
                                                          Icons.info)),
                                                  const SizedBox(
                                                    width:
                                                        tDashboardCardPadding,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Claificacion: ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline4
                                                            ?.apply(
                                                                color: Colors
                                                                    .black),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Text(
                                                        'Precio: ${listController.products[index].price}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2
                                                            ?.apply(
                                                                color: Colors
                                                                    .black),
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Comentarios de otros usuarios',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                                  itemCount:
                                      listRatingController.ratings.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    //  onTap: listController.products[index].onPress,
                                    child: SizedBox(
                                      width: 320,
                                      height: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, top: 5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: tCardBgColor),
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      '"${listRatingController.ratings[index].comment}"',
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
                                                  ),
                                                  RaterImageWidget(
                                                    userId: listRatingController
                                                        .ratings[index].raterId,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              shape:
                                                                  const CircleBorder()),
                                                      onPressed: () {},
                                                      child: const Icon(
                                                          Icons.info)),
                                                  const SizedBox(
                                                    width:
                                                        tDashboardCardPadding,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Claificacion: ${listRatingController.ratings[index].rating}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline4
                                                            ?.apply(
                                                                color: Colors
                                                                    .black),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      RaterNameWidget(
                                                          userId:
                                                              listRatingController
                                                                  .ratings[
                                                                      index]
                                                                  .raterId),
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
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Text('Something went worng');
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
