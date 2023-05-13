import 'dart:developer';
import 'dart:io';

import 'package:emplolance/constants/colors.dart';
import 'package:emplolance/features/authentication/controllers/image_picker_controller.dart';
import 'package:emplolance/features/authentication/controllers/signup_controller.dart';
import 'package:emplolance/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    //var imagePickerController = ImagePickerController.instanceImg;
    final imagePickerController = Get.put(ImagePickerController());
    // ignore: no_leading_underscores_for_local_identifiers
    final _formKey = GlobalKey<FormState>();

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
                    onTap: () {
                      //Camera
                      controller.captureImageWithCamera();
                      //imagePickerController.captureImageWithCamera();
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
                    onTap: () {
                      //Galery
                      //imagePickerController.chooseImageFromGalery();
                      controller.chooseImageFromGalery();
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

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.fullname,
              decoration: const InputDecoration(
                  label: Text(tFullName),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
              validator: (value) => value!.isEmpty ? 'Completa el campo' : null,
            ),
            const SizedBox(
              height: tDefaultSize - 20,
            ),
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                  label: Text(tEmail), prefixIcon: Icon(Icons.email_rounded)),
              validator: (value) => value!.isEmpty ? 'Completa el campo' : null,
            ),
            const SizedBox(
              height: tDefaultSize - 20,
            ),
            /*    TextFormField(
              controller: controller.photo,
              decoration: const InputDecoration(
                  label: Text(tPhoto), prefixIcon: Icon(Icons.numbers_rounded)),
            ),
            const SizedBox(
              height: tDefaultSize - 20,
            ),*/
            TextFormField(
              controller: controller.password,
              decoration: const InputDecoration(
                  label: Text(tPassword),
                  prefixIcon: Icon(Icons.fingerprint_rounded)),
              validator: (value) => value!.isEmpty ? 'Completa el campo' : null,
            ),
            const SizedBox(
              height: tDefaultSize - 20,
            ),
            /* Center(
              child: GestureDetector(
                onTap: () {
                  _showImageDialog();
                },
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage: imageFile == null
                      ? const AssetImage(
                          'assets/images/profile/blank_profile.png')
                      : Image.file(imageFile!).image,
                ),
              ),
            ),
            const SizedBox(
              height: tDefaultSize - 20,
            ),*/
            Center(
              child: GestureDetector(
                onTap: () {
                  //imagePickerController.chooseImageFromGalery();
                  _showImageDialog();
                },
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: controller.profileImage == null
                      ? const AssetImage(
                          'assets/images/profile/blank_profile.png')
                      : Image.file(controller.profileImage!).image,
                  backgroundColor: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: tDefaultSize - 20,
            ),
            TextFormField(
              controller: controller.description,
              decoration: const InputDecoration(
                  label: Text(tDescription),
                  prefixIcon: Icon(Icons.mode_edit_outline_rounded)),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
            ),
            const SizedBox(
              height: tDefaultSize - 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    SignUpController.instance.registerUser(
                        controller.email.text.trim(),
                        controller.password.text.trim());

                    //Idea: pasar todo el model a createUser()
                    final user = UserModel(
                      fullName: controller.fullname.text.trim(),
                      email: controller.email.text.trim(),
                      photo: controller.imageDownloadURL!,
                      password: controller.password.text.trim(),
                      description: controller.description.text.trim(),
                    );
                    SignUpController.instance
                        .createUser(user, controller.profileImage!);
                  }
                },
                child: Text(tSignup.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
