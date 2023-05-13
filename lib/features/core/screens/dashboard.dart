import 'package:emplolance/constants/sizes.dart';
import 'package:emplolance/constants/text_strings.dart';
import 'package:emplolance/features/authentication/models/user_model.dart';
import 'package:emplolance/features/core/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../authentication/controllers/profile_controller.dart';
import '../widgets/appbar.dart';
import '../widgets/banners.dart';
import '../widgets/categories.dart';
import '../widgets/search.dart';
import '../widgets/top_courses.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final txtTheme = Theme.of(context).textTheme;

    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: const DashboardAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDashboardPadding),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Heading
                      Text(
                        tDashboardTitle + userData.fullName,
                        style: txtTheme.bodyText2,
                      ),
                      Text(
                        tDashboardHeading,
                        style: txtTheme.headline2,
                      ),
                      const SizedBox(
                        height: tDashboardPadding,
                      ),

                      //---------SEARCH BOX---------
                      // DashboardSearchBox(txtTheme: txtTheme),
                      //const SizedBox(height: tDashboardPadding,),

                      //---------CATEGORIES---------
                      Text(
                        tDashboardCategories,
                        style: txtTheme.headline4?.apply(fontSizeFactor: 1.2),
                      ),
                      DashboardCategories(txtTheme: txtTheme),
                      const SizedBox(
                        height: tDashboardCardPadding,
                      ),

                      //---------TOP COURSES---------
                      Text(
                        tDashboardTopCourses,
                        style: txtTheme.headline4?.apply(fontSizeFactor: 1.2),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            DashboardTopCourses(txtTheme: txtTheme),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: tDashboardPadding,
                      ),

                      Text(
                        'Usuarios Mejor Calificados',
                        style: txtTheme.headline4?.apply(fontSizeFactor: 1.2),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            DashboardTopCourses(txtTheme: txtTheme),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: tDashboardPadding,
                      ),

                      // const NavBar(),

                      //---------BANNERS---------
                      /*   DashboardBanners(txtTheme: txtTheme),
                      const SizedBox(
                        height: tDashboardCardPadding,
                      ),*/
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
