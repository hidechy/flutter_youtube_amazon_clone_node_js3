// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  List list = [
    'http://toyohide.work/BrainLog/public/UPPHOTO/2023/2023-09-27/20230927_131236144.jpg',
    'http://toyohide.work/BrainLog/public/UPPHOTO/2023/2023-09-27/20230927_131522177.jpg',
    'http://toyohide.work/BrainLog/public/UPPHOTO/2023/2023-09-27/20230927_131529638.jpg',
    'http://toyohide.work/BrainLog/public/UPPHOTO/2023/2023-09-27/20230927_131551309.jpg',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            'Deal of the day',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Image.network('http://toyohide.work/BrainLog/public/UPPHOTO/2023/2023-09-27/20230927_131236144.jpg'),
        Container(
          padding: const EdgeInsets.only(left: 15),
          alignment: Alignment.topLeft,
          child: const Text(
            '\$100',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            'hidechy',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: list
                  .map(
                    (e) => Image.network(e, fit: BoxFit.fitWidth, width: 100, height: 100),
                  )
                  .toList()),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ).copyWith(left: 15),
          alignment: Alignment.topLeft,
          child: Text(
            'See all deals',
            style: TextStyle(
              color: Colors.cyan[800],
            ),
          ),
        ),
      ],
    );
  }
}
