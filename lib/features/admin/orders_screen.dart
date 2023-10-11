import 'package:flutter/material.dart';

import '../../common/loader.dart';
import '../../common/single_product.dart';
import '../../models/order.dart';
import '../order/order_detail_screen.dart';
import 'admin_service.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;

  final AdminService adminService = AdminService();

  ///
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  ///
  Future<void> fetchOrders() async {
    orders = await adminService.fetchAllOrders(context);

    setState(() {});
  }

  ///
  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, OrderDetailScreen.routeName, arguments: orderData),
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(image: orderData.products[0].images[0]),
                ),
              );
            },
          );
  }
}
