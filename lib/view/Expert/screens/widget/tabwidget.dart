import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';

class Tab extends StatefulWidget {
  const Tab({super.key});

  @override
  State<Tab> createState() => _TabState();
}

class _TabState extends State<Tab> {
  late TabController tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              // give the tab bar a height [can change hheight to preferred height]
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: TabBar(
                  controller: tabController,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: kWhiteColor,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  // isScrollable: false,
                  tabs: const [
                    Tab(
                        // child: Text('Library'),
                        ),
                    Tab(
                        //  child: Text('Favorites'),
                        ),
                  ],
                ),
              )
            ])));
  }
}
