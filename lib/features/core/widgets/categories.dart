import 'package:emplolance/features/core/controllers/categories%20_controller.dart';
import 'package:emplolance/features/core/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';

class DashboardCategories extends StatelessWidget {
  const DashboardCategories({
    Key? key,
    required this.txtTheme,
  }) : super(key: key);

  final TextTheme txtTheme;

  @override
  Widget build(BuildContext context) {
    final listController = Get.put(CategoriesController());
    return SizedBox(
      height: 45,
      child: FutureBuilder<List<DashboardCategoriesModel>>(
        future: listController.getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {},
                  //list[index].onPress,
                  child: SizedBox(
                    width: 170,
                    height: 60,
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: tCardBgColor,
                          ),
                          child: Center(
                            child: Image(
                                image:
                                    NetworkImage(snapshot.data![index].image)),
                            /*Text(
                      list[index].image,
                      style: txtTheme.headline6?.apply(color: Colors.white),
                    ),*/
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data![index].name,
                                style: txtTheme.headline6,
                                overflow: TextOverflow.ellipsis,
                              ),
                              /*Text(
                        list[index].subHeading,
                        style: txtTheme.bodyText2,
                        overflow: TextOverflow.ellipsis,
                      ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                /* children: [
          SizedBox(
            width: 170,
            height: 50,
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: tDarkColor,
                  ),
                  child: Center(
                    child: Text(
                      'JS',
                      style: txtTheme.headline6?.apply(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'JavaScript dksjklds',
                        style: txtTheme.headline6,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '10 lessons',
                        style: txtTheme.bodyText2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],*/
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
      ),
    );
  }
}
