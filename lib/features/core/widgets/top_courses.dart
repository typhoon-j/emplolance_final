import 'package:emplolance/features/core/models/courses_model.dart';
import 'package:emplolance/features/core/screens/products/product_selected_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/sizes.dart';
import '../controllers/product_controller.dart';

class DashboardTopCourses extends StatelessWidget {
  const DashboardTopCourses({
    Key? key,
    required this.txtTheme,
  }) : super(key: key);

  final TextTheme txtTheme;

  @override
  Widget build(BuildContext context) {
    final list = DashboardTopCoursesModel.list;
    final listController = Get.put(ProductController());
    return SizedBox(
      height: 200,
      child: Obx(
        () => ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listController.allProducts.length,
          itemBuilder: (context, index) => GestureDetector(
            //onTap: list[index].onPress,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              listController.allProducts[index].name,
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
                                    listController.allProducts[index].imageUrl),
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
                                Get.to(() => ProductSelectedScreen(
                                      productId: (listController
                                              .allProducts[index].productId)
                                          .toString(),
                                    ));
                              },
                              child: const Icon(Icons.info)),
                          const SizedBox(
                            width: tDashboardCardPadding,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Claificacion: ',
                                style: txtTheme.headline4
                                    ?.apply(color: Colors.black),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Precio: ${listController.allProducts[index].price}',
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
          /*child: SizedBox(
            width: 320,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, top: 5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: tCardBgColor),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            'Flutter Crash Course',
                            style: txtTheme.headline4?.apply(color: Colors.black),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: const Image(
                            image: AssetImage(tTopCourseIamge1),
                            height: 110,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(shape: const CircleBorder()),
                            onPressed: () {},
                            child: const Icon(Icons.play_arrow)),
                        SizedBox(
                          width: tDashboardCardPadding,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '3 sections',
                              style: txtTheme.headline4?.apply(color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Programming Languages',
                              style: txtTheme.bodyText2?.apply(color: Colors.black),
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
          ),*/
        ),
      ),
    );
  }
}
