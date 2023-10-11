//import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';

import '../../common/loader.dart';
import '../../models/sales.dart';
import 'admin_service.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminService adminService = AdminService();

  int? totalSales;

  List<Sales>? earnings;

  ///
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  ///
  Future<void> getEarnings() async {
    final earningData = await adminService.getEarnings(context);

    totalSales = earningData['totalEarnings'];

    earnings = earningData['sales'];

    setState(() {});
  }

  ///
  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$$totalSales',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(color: Colors.redAccent, thickness: 3),
              SizedBox(
                height: 250,
                child: Column(
                  children: earnings!.map((e) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.label),
                        Text(e.earning.toString()),
                      ],
                    );
                  }).toList(),
                ),
                // child: CategoryProductsChart(
                //   seriesList: [
                //     charts.Series(
                //       id: 'Sales',
                //       data: earnings!,
                //       domainFn: (Sales sales, _) => sales.label,
                //       measureFn: (Sales sales, _) => sales.earning,
                //     ),
                //   ],
                // ),
              )
            ],
          );
  }
}
