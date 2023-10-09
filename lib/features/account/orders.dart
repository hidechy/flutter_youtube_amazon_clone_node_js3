// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';
import 'single_product.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List list = [
    'http://toyohide.work/BrainLog/public/UPPHOTO/2023/2023-09-27/20230927_131236144.jpg',
    'http://toyohide.work/BrainLog/public/UPPHOTO/2023/2023-09-27/20230927_131522177.jpg',
    'http://toyohide.work/BrainLog/public/UPPHOTO/2023/2023-09-27/20230927_131529638.jpg',
    'http://toyohide.work/BrainLog/public/UPPHOTO/2023/2023-09-27/20230927_131551309.jpg',
  ];

  // List<Order>? orders;
  // final AccountServices accountServices = AccountServices();
  //
  //

  //
  // ///
  // @override
  // void initState() {
  //   super.initState();
  //   fetchOrders();
  // }
  //
  //
  //

  //
  // ///
  // void fetchOrders() async {
  //   orders = await accountServices.fetchMyOrders(context: context);
  //   setState(() {});
  // }
  //
  //
  //

  ///
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: const Text(
                'Your Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child: Text(
                'See all',
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(
            left: 10,
            top: 20,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return SingleProduct(image: list[index]);

              // return GestureDetector(
              //   onTap: () {
              //     Navigator.pushNamed(
              //       context,
              //       OrderDetailScreen.routeName,
              //       arguments: orders![index],
              //     );
              //   },
              //   child: SingleProduct(
              //     image: orders![index].products[0].images[0],
              //   ),
              // );
            },
          ),
        ),
      ],
    );

    /*
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                  ),
                ],
              ),
              // display orders
              Container(
                height: 170,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 0,
                ),
                // child: ListView.builder(
                //   scrollDirection: Axis.horizontal,
                //   itemCount: orders!.length,
                //   itemBuilder: (context, index) {
                //     return GestureDetector(
                //       onTap: () {
                //         Navigator.pushNamed(
                //           context,
                //           OrderDetailScreen.routeName,
                //           arguments: orders![index],
                //         );
                //       },
                //       child: SingleProduct(
                //         image: orders![index].products[0].images[0],
                //       ),
                //     );
                //   },
                // ),
              ),
            ],
          );
    */
  }
}
