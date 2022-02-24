import 'package:flutter/material.dart';
import 'package:near_learning_app/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 70, left: 20),
            child: Row(
              children: [
                Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.black54,
                ),
                Expanded(child: Container()),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.5)),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Text(
              "Hola \$\{user.firstName\}, tienes \$\{user.actualPoints\}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                labelPadding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black.withOpacity(0.5),
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicator:
                    CircleTabIndicator(color: Colors.blue.shade500, radius: 4),
                tabs: const [
                  Tab(
                    text: "Hoy",
                  ),
                  Tab(
                    text: "Inspiraciones",
                  ),
                  Tab(
                    text: "Avances",
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            height: 300,
            width: double.maxFinite,
            child: TabBarView(
                controller: _tabController,
                physics: BouncingScrollPhysics(),
                children: [
                  ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (() {}),
                          child: Container(
                            margin: const EdgeInsets.only(right: 15, top: 10),
                            width: 200,
                            height: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFF69D2E7).withOpacity(0.4)),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text(""),
                            ),
                          ),
                        );
                      }),
                  Text("ListView 2"),
                  Text("ListView 3"),
                ]),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text(
                  "Explorar más en NEAR",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(child: Container()),
                Text(
                  "Ver todo",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            width: double.maxFinite,
            height: 125,
            color: Colors.red,
            child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container();
                }),
          ),
        ],
      ),
    );
  }
}
