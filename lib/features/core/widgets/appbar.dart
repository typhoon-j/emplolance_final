import 'package:emplolance/features/authentication/repository/authentication_repository.dart';
import 'package:emplolance/features/core/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/text_strings.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //leading: const Icon(Icons.menu, color: Colors.white),
      title: Text(
        tAppName,
        style: Theme.of(context).textTheme.headline4,
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20, top: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: tCardBgColor,
          ),
          child: IconButton(
            onPressed: () => Get.to(() => const ProfileScreen()),
            //{AuthenticationRepository.instance.logout();},
            icon: ClipOval(
                //borderRadius: BorderRadius.circular(100),
                child: Image(
              image: AssetImage(tProfileImge),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            )),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}
