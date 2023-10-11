// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';

import '../../common/loader.dart';
import '../../constants/global_variables.dart';
import '../../models/order.dart';
import '../order/order_detail_screen.dart';
import 'account_service.dart';
import 'single_product.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order> orders = [];

  final AccountService accountService = AccountService();

  ///
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  ///
  Future<void> fetchOrders() async {
    orders = await accountService.fetchMyOrders(context: context);
    setState(() {});
  }

  ///
  @override
  Widget build(BuildContext context) {
    return orders.isEmpty
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      'See all',
                      style: TextStyle(color: GlobalVariables.selectedNavBarColor),
                    ),
                  ),
                ],
              ),
              // display orders
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, OrderDetailScreen.routeName, arguments: orders[index]),
                      child: SingleProduct(image: orders[index].products[0].images[0]),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
