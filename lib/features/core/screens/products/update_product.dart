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

class UpdateProductScreen extends StatelessWidget {
  UpdateProductScreen({required this.productData, super.key});

  final ProductModel productData;
  final productController = Get.put(ProductController());
  StorageService storage = StorageService();
  DatabaseService database = DatabaseService();
  final controller = Get.put(ProfileController());
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var _imageUrl;
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
          'Actualizar Anuncio',
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
                    _imageUrl = productData.imageUrl;
                    final name = TextEditingController(text: productData.name);
                    final price = TextEditingController(
                        text: productData.price.toString());
                    final description =
                        TextEditingController(text: productData.description);
                    var categoryChoose = productData.category;
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
                                      _imageUrl = await storage
                                          .getDownloadURL(_image.name);
                                      productController.updatedProduct.update(
                                          'imageUrl', (_) => _imageUrl,
                                          ifAbsent: () => _imageUrl);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Imagen seleccionada'),
                                      ));

                                      log(productController
                                          .updatedProduct['imageUrl']);
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
                        _buildTextFormField('Titulo del anuncio', 'name',
                            productController, name),
                        const SizedBox(
                          height: 10,
                        ),
                        //_buildTextFormField('Categoria', 'category', productController),
                        DropdownButtonFormField(
                            iconSize: 20,
                            value: productData.category,
                            decoration:
                                const InputDecoration(hintText: 'Categoria'),
                            items: categories.map((category) {
                              return DropdownMenuItem(
                                  value: category, child: Text(category));
                            }).toList(),
                            onChanged: (value) {
                              categoryChoose = value!;
                              productController.updatedProduct.update(
                                  'category', (_) => value,
                                  ifAbsent: () => value);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildTextFormField(
                            'Precio', 'price', productController, price),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildTextFormField('Descripcion', 'description',
                            productController, description),
                        const SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              log('userId: ${productData.id}');
                              log('userId: ${productData.userId}');
                              log('ProductId: ${productData.productId}');
                              log('name : ${name.text.trim()}');
                              log('imageUrl : $_imageUrl');
                              log('description : ${description.text.trim()}');
                              log('price : ${price.text.trim()}');
                              log('category : ${categoryChoose.trim()}');
                              final newProductData = ProductModel(
                                id: productData.id,
                                name: name.text.trim(),
                                category: categoryChoose.trim(),
                                imageUrl: _imageUrl,
                                description: description.text.trim(),
                                userId: productData.userId,
                                productId: productData.productId,
                                price: double.parse(price.text.trim()),
                                active: productData.active,
                              );
                              await productController
                                  .updateProductData(newProductData);
                            },
                            child: Text(
                              'Actualizar Anuncio',
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

  TextFormField _buildTextFormField(String label, String name,
      ProductController productController, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(label: Text(label)),
      onChanged: (value) {
        //log(controller.toString());
        productController.updatedProduct
            .update(name, (_) => controller.text, ifAbsent: () => value);
      },
    );
  }
}
