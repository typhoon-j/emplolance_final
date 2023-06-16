import 'dart:developer';
import 'dart:io';

import 'package:emplolance/constants/colors.dart';
import 'package:emplolance/features/authentication/controllers/image_picker_controller.dart';
import 'package:emplolance/features/authentication/controllers/signup_controller.dart';
import 'package:emplolance/features/authentication/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';
import '../../core/repository/image_repository.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    StorageService storage = StorageService();
    // ignore: no_leading_underscores_for_local_identifiers
    var _imageUrl;

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
                      icon: const Icon(Icons.add_circle_rounded),
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
                    final user = UserModel(
                      fullName: controller.fullname.text.trim(),
                      email: controller.email.text.trim(),
                      photo: _imageUrl.trim(),
                      password: controller.password.text.trim(),
                      description: controller.description.text.trim(),
                      userId: 'temp',
                      pushToken: 'temp',
                    );
                    log(_imageUrl);

                    SignUpController.instance.registerUser(
                        controller.email.text.trim(),
                        controller.password.text.trim(),
                        user);

                    // SignUpController.instance.createUser(user);
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
