import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:near_learning_app/models/models.dart';
import 'package:near_learning_app/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static List<LogosExploreMore> imagesLogos = [
    LogosExploreMore(
        image: "mintbase.jpeg",
        title: "Mintbase",
        url: "https://www.mintbase.io/"),
    LogosExploreMore(
        image: "near-docs.jpeg",
        title: "NEAR docs",
        url: "https://docs.near.org/docs/develop/basics/getting-started"),
    LogosExploreMore(
        image: "paras.jpeg", title: "Paras", url: "https://paras.id/"),
    LogosExploreMore(
        image: "aurora-dev.jpeg",
        title: "Aurora Dev",
        url: "https://aurora.dev/"),
    LogosExploreMore(
        title: "astrodao",
        image: "astrodao.jpeg",
        url: "https://astrodao.com/"),
    LogosExploreMore(
        image: "trisolaris.jpeg",
        title: "Trisolaris",
        url: "https://www.trisolaris.io/"),
    LogosExploreMore(
        title: "Ref Finance", image: "ref.png", url: "https://ref.finance/"),
    LogosExploreMore(
        image: "onet.jpeg", title: "Octopus", url: "https://oct.network/"),
  ];

  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                Expanded(child: Container()),
                Neumorphic(
                  margin: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.person, size: 50),
                  style: const NeumorphicStyle(
                      border: NeumorphicBorder(
                    isEnabled: true,
                    color: Color(0x33000000),
                    width: 0.8,
                  )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Text(
              "Hola \$\{user.firstName\}, tienes \$\{user.actualPoints\}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
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
                indicator: CircleTabIndicator(
                    color: Colors.blue.withOpacity(0.5), radius: 4),
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
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
            height: 275,
            width: double.infinity,
            child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: InkWell(
                                onTap: () {
                                  print("InkWell 1");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Ejemplo"),
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Neumorphic(
                                    //margin: const EdgeInsets.only(right: 20),
                                    child: Container(
                                      color: Color(0xFFF1E0AC),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Center(
                                            child: Text(
                                          "Quis pariatur dolor ut nostrud ipsum. Proident irure eu sit est nulla aliqua velit. Incididunt mollit commodo proident deserunt cupidatat fugiat non fugiat minim magna magna nisi culpa dolore.",
                                          textAlign: TextAlign.justify,
                                        )),
                                      ),
                                    ),
                                    style: const NeumorphicStyle(
                                        border: NeumorphicBorder(
                                      isEnabled: true,
                                      color: Color(0x33000000),
                                      width: 0.8,
                                    )),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () {
                                  print("InkWell 2");
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Neumorphic(
                                    //margin: const EdgeInsets.only(right: 20),
                                    child: Container(
                                      color: Color(0xFFF1E0AC),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Center(
                                            child: Text(
                                          "Quis pariatur dolor ut nostrud ipsum. Proident irure eu sit est nulla aliqua velit. Incididunt mollit commodo proident deserunt cupidatat fugiat non fugiat minim magna magna nisi culpa dolore.",
                                          textAlign: TextAlign.justify,
                                        )),
                                      ),
                                    ),
                                    style: const NeumorphicStyle(
                                        border: NeumorphicBorder(
                                      isEnabled: true,
                                      color: Color(0x33000000),
                                      width: 0.8,
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          onTap: () {
                            print("InkWell 3");
                          },
                          onDoubleTap: () {
                            print("InkWell double tap 3");
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Neumorphic(
                              style: const NeumorphicStyle(
                                  border: NeumorphicBorder(
                                isEnabled: true,
                                color: Color(0x33000000),
                                width: 0.8,
                              )),
                              child: Container(
                                color: Color(0xFFF1E0AC),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Center(
                                      child: Text(
                                    "Quis pariatur dolor ut nostrud ipsum. Proident irure eu sit est nulla aliqua velit. Incididunt mollit commodo proident deserunt cupidatat fugiat non fugiat minim magna magna nisi culpa dolore.",
                                    textAlign: TextAlign.justify,
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // ListView.separated(
                  //     itemCount: 3,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       return GestureDetector(
                  //         onTap: (() {}),
                  //         child: Neumorphic(
                  //           //margin: EdgeInsets.all(50),
                  //           child: Container(
                  //             //margin: const EdgeInsets.only(right: 15, top: 10),
                  //             width: 175,
                  //             height: 250,
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(20),
                  //                 color: const Color(0xFF69D2E7).withOpacity(0.4)),
                  //             child: const Padding(
                  //               padding: EdgeInsets.all(14.0),
                  //               child: Text(""),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     }, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 10,),),
                  Text("ListView 2"),
                  Text("ListView 3"),
                ]),
          ),
          ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.all(0),
            elevation: 24,
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                isExpanded: _isOpen,
                backgroundColor: Colors.transparent,
                headerBuilder: (context, isOpen) {
                  return ListTile(
                    title: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Explorar más en NEAR",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container()),
                          const Text(
                            "Ver más",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                body: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: double.maxFinite,
                  height: 125,
                  color: Colors.transparent,
                  child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _launchURL(imagesLogos[index].url);
                                },
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images_logos/" +
                                                imagesLogos[index + 4].image),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  imagesLogos[index].title,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
            expansionCallback: (i, isOpen) {
              setState(() {
                _isOpen = !_isOpen;
              });
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            width: double.maxFinite,
            height: 125,
            color: Colors.transparent,
            child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchURL(imagesLogos[index].url);
                          },
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                              image: DecorationImage(
                                  image: AssetImage("assets/images_logos/" +
                                      imagesLogos[index].image),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            imagesLogos[index].title,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
          Container(height: 100, color: Colors.transparent),
        ],
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
