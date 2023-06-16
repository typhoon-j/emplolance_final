import 'dart:developer';

import 'package:emplolance/constants/colors.dart';
import 'package:emplolance/constants/image_strings.dart';
import 'package:emplolance/constants/sizes.dart';
import 'package:emplolance/constants/text_strings.dart';
import 'package:emplolance/features/authentication/controllers/profile_controller.dart';
import 'package:emplolance/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../repository/image_repository.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    StorageService storage = StorageService();
    // ignore: no_leading_underscores_for_local_identifiers
    var _imageUrl;

    void _showImageDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Elija una opcion'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () async {
                      //Camera
                      ImagePicker _picker = ImagePicker();
                      final XFile? _image =
                          await _picker.pickImage(source: ImageSource.camera);
                      if (_image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Imagen no seleccionada'),
                          ),
                        );
                      }
                      if (_image != null) {
                        await storage.uploadImage(_image);
                        _imageUrl = await storage.getDownloadURL(_image.name);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Imagen seleccionada'),
                          ),
                        );
                        log(_imageUrl);
                      }
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.camera_alt_rounded,
                          ),
                        ),
                        Text(
                          'Camara',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      //Galery
                      ImagePicker _picker = ImagePicker();
                      final XFile? _image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (_image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Imagen no seleccionada'),
                          ),
                        );
                      }
                      if (_image != null) {
                        await storage.uploadImage(_image);
                        _imageUrl = await storage.getDownloadURL(_image.name);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Imagen seleccionada'),
                          ),
                        );
                        log(_imageUrl);
                      }
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.image_rounded,
                          ),
                        ),
                        Text(
                          'Galeria',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          tEditProfile,
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
                  _imageUrl = userData.photo;
                  final fullName =
                      TextEditingController(text: userData.fullName);
                  final email = TextEditingController(text: userData.email);
                  final password =
                      TextEditingController(text: userData.password);
                  final description =
                      TextEditingController(text: userData.description);
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
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: tPrimaryColor),
                              child: const Icon(
                                LineAwesomeIcons.camera,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: fullName,
                              decoration: const InputDecoration(
                                  label: Text(tFullName),
                                  prefixIcon:
                                      Icon(Icons.person_outline_rounded)),
                            ),
                            const SizedBox(
                              height: tDefaultSize - 20,
                            ),
                            TextFormField(
                              controller: email,
                              decoration: const InputDecoration(
                                  label: Text(tEmail),
                                  prefixIcon: Icon(Icons.email_rounded)),
                            ),
                            const SizedBox(
                              height: tDefaultSize - 20,
                            ),
                            SizedBox(
                              height: 100,
                              child: Card(
                                margin: EdgeInsets.zero,
                                color: tPrimaryColor,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        _showImageDialog();
                                      },
                                      icon:
                                          const Icon(Icons.add_circle_rounded),
                                      color: tSecondaryColor,
                                    ),
                                    Text(
                                      'Seleccionar imagen de Perfil',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          ?.apply(color: tSecondaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: tDefaultSize - 20,
                            ),
                            TextFormField(
                              controller: description,
                              decoration: const InputDecoration(
                                  label: Text(tDescription),
                                  prefixIcon:
                                      Icon(Icons.mode_edit_outline_rounded)),
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 5,
                            ),
                            const SizedBox(
                              height: tDefaultSize - 20,
                            ),
                            TextFormField(
                              controller: password,
                              decoration: const InputDecoration(
                                  label: Text(tPassword),
                                  prefixIcon: Icon(Icons.fingerprint_rounded)),
                            ),
                            const SizedBox(
                              height: tFormHeight,
                            ),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final userDataNew = UserModel(
                                    id: userData.id,
                                    fullName: fullName.text.trim(),
                                    email: email.text.trim(),
                                    photo: _imageUrl,
                                    password: password.text.trim(),
                                    description: description.text.trim(),
                                    userId: userData.userId,
                                    pushToken: userData.pushToken,
                                  );
                                  await controller.updateUserData(userDataNew);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: tPrimaryColor,
                                  side: BorderSide.none,
                                  shape: const StadiumBorder(),
                                ),
                                child: const Text(
                                  tEditProfile,
                                  style: TextStyle(color: tDarkColor),
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
        ),
      ),
    );
  }
}
