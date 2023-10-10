import 'package:flutter/material.dart';

import '../../common/loader.dart';
import '../../common/single_product.dart';
import '../../models/product.dart';
import 'add_product_screen.dart';
import 'admin_service.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;

  final AdminService adminService = AdminService();

  ///
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  ///
  Future<void> fetchAllProducts() async {
    products = await adminService.fetchAllProducts(context);
    setState(() {});
  }

  ///
  void deleteProduct(Product product, int index) {
    adminService.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  ///
  void navigateToAddProduct() => Navigator.pushNamed(context, AddProductScreen.routeName);

  ///
  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = products![index];
                return Container(
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(border: Border.all(color: Colors.indigo, width: 3)),
                  child: Column(
                    children: [
                      SizedBox(height: 140, child: SingleProduct(image: productData.images[0])),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(productData.name, overflow: TextOverflow.ellipsis, maxLines: 2),
                          ),
                          IconButton(
                            onPressed: () => deleteProduct(productData, index),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: navigateToAddProduct,
              tooltip: 'Add a Product',
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
  }
}
