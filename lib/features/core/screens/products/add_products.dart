import 'dart:developer';

import 'package:emplolance/constants/colors.dart';
import 'package:emplolance/features/authentication/controllers/profile_controller.dart';
import 'package:emplolance/features/core/controllers/product_controller.dart';
import 'package:emplolance/features/core/models/product_model.dart';
import 'package:emplolance/features/core/repository/image_repository.dart';
import 'package:emplolance/features/core/repository/product_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../authentication/models/user_model.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final productController = Get.put(ProductController());
  StorageService storage = StorageService();
  DatabaseService database = DatabaseService();
  final controller = Get.put(ProfileController());
  final User? user = FirebaseAuth.instance.currentUser;

  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Arquitectura',
      'Arte',
      'Diseño',
      'Escritura',
      'Fotografía',
      'Ingeniería',
      'Música',
      'Programación',
      'Video'
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          'Nuevo Anuncio',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: (controller.getUserData()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel userData = snapshot.data as UserModel;
                    if (userData.id != null) {
                      var userId = user?.uid;
                      productController.newProduct.update(
                          'userId', (_) => userId,
                          ifAbsent: () => userId);
                      log(productController.newProduct['userId']);

                      productController.newProduct.update(
                          'productId', (_) => uuid.v1(),
                          ifAbsent: () => uuid.v1());
                      log(productController.newProduct['productId']);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informacion del anuncio',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 100,
                          child: Card(
                            margin: EdgeInsets.zero,
                            color: tPrimaryColor,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    ImagePicker _picker = ImagePicker();
                                    final XFile? _image = await _picker
                                        .pickImage(source: ImageSource.gallery);
                                    if (_image == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Imagen no seleccionada'),
                                        ),
                                      );
                                    }
                                    if (_image != null) {
                                      await storage.uploadImage(_image);
                                      var imageUrl = await storage
                                          .getDownloadURL(_image.name);
                                      productController.newProduct.update(
                                          'imageUrl', (_) => imageUrl,
                                          ifAbsent: () => imageUrl);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Imagen seleccionada'),
                                      ));

                                      log(productController
                                          .newProduct['imageUrl']);
                                    }
                                  },
                                  icon: const Icon(Icons.add_circle_rounded),
                                  color: tSecondaryColor,
                                ),
                                Text(
                                  'Seleccionar imagenes',
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
                          height: 20,
                        ),
                        _buildTextFormField(
                            'Titulo del anuncio', 'name', productController),
                        const SizedBox(
                          height: 10,
                        ),
                        //_buildTextFormField('Categoria', 'category', productController),
                        DropdownButtonFormField(
                            iconSize: 20,
                            decoration:
                                const InputDecoration(hintText: 'Categoria'),
                            items: categories.map((category) {
                              return DropdownMenuItem(
                                  value: category, child: Text(category));
                            }).toList(),
                            onChanged: (value) {
                              productController.newProduct.update(
                                  'category', (_) => value,
                                  ifAbsent: () => value);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildTextFormField(
                            'Precio', 'price', productController),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildTextFormField(
                            'Descripcion', 'description', productController),
                        const SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              log('userId: ${productController.newProduct['userId']}');
                              log('ProductId: ${productController.newProduct['productId']}');
                              database.addProduct(
                                ProductModel(
                                  name: productController.newProduct['name'],
                                  category:
                                      productController.newProduct['category'],
                                  imageUrl:
                                      productController.newProduct['imageUrl'],
                                  description: productController
                                      .newProduct['description'],
                                  userId:
                                      productController.newProduct['userId'],
                                  productId:
                                      productController.newProduct['productId'],
                                  price: double.parse(
                                      productController.newProduct['price']),
                                  active: true,
                                ),
                              );
                              Get.back();
                            },
                            child: Text(
                              'Crear Anuncio',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.apply(color: tSecondaryColor),
                            ),
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
              }),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(
      String label, String name, ProductController productController) {
    return TextFormField(
      decoration: InputDecoration(label: Text(label)),
      onChanged: (value) {
        productController.newProduct
            .update(name, (_) => value, ifAbsent: () => value);
      },
    );
  }
}
