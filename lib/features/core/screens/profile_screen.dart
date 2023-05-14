import 'package:emplolance/constants/colors.dart';
import 'package:emplolance/constants/image_strings.dart';
import 'package:emplolance/constants/sizes.dart';
import 'package:emplolance/constants/text_strings.dart';
import 'package:emplolance/features/core/screens/products/add_products.dart';
import 'package:emplolance/features/core/screens/products/products_screen.dart';
import 'package:emplolance/features/core/screens/profile_update_screen.dart';
import 'package:emplolance/features/core/screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../authentication/controllers/profile_controller.dart';
import '../../authentication/models/user_model.dart';
import '../../authentication/repository/authentication_repository.dart';
import '../widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          tProfile,
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
                          /* Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: tPrimaryColor),
                              child: const Icon(
                                LineAwesomeIcons.alternate_pencil,
                                size: 20.0,
                                color: Colors.black,
                              ),
                            ),
                          )*/
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        userData.fullName,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        userData.email,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () => Get.to(() => UpdateProfileScreen()),
                          child: const Text(tEditProfile),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tPrimaryColor,
                            side: BorderSide.none,
                            shape: StadiumBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),

                      //Menu
                      ProfileMenuWidget(
                        title: 'Perfil',
                        icon: LineAwesomeIcons.user_circle,
                        onPress: () {
                          Get.to(() => UserScreen());
                        },
                      ),
                      ProfileMenuWidget(
                        title: 'Tus anuncios',
                        icon: LineAwesomeIcons.book,
                        onPress: () {
                          Get.to(() => ProductScreen());
                        },
                      ),
                      ProfileMenuWidget(
                        title: 'Agregar anuncios',
                        icon: LineAwesomeIcons.plus_circle,
                        onPress: () {
                          Get.to(() => AddProductScreen());
                        },
                      ),
                      ProfileMenuWidget(
                          title: 'Solicitudes',
                          icon: LineAwesomeIcons.bell,
                          onPress: () {}),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),

                      ProfileMenuWidget(
                          title: 'Logout',
                          icon: LineAwesomeIcons.alternate_sign_out,
                          textColor: Colors.red,
                          endIcon: false,
                          onPress: () {
                            AuthenticationRepository.instance.logout();
                          })
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
