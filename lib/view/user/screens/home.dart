import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:graduation_project/data/repositories/user_repo.dart';
import 'package:graduation_project/domain/map_model.dart';
import 'package:graduation_project/view/user/widgets/drawer.dart';
import '../../../data/repositories/map_repo.dart';
import 'package:graduation_project/view/user/screens/instructions.dart';

UserRepository userRepo = UserRepository.instance;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imageUrl = '';
  bool isloaded = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    imageUrl = await userRepo.getUserPhoto();
    if (imageUrl.isNotEmpty) {
      setState(() {
        isloaded = true;
      });
    }
  }

  final List<String> listImages = [
    'assets/images/desc 2.jpg',
    'assets/images/desc 3.jpg',
    'assets/images/desc 4.jpg',
    'assets/images/desc 5.jpg',
    'assets/images/disc 1.jpeg',
    'assets/images/desc 6.png',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        elevation: 0,
        backgroundColor: kDarkColor,
      ),
      drawer: SideDrawer(),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.4,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(47),
                    bottomRight: Radius.circular(47)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [kDarkColor, kLightColor])),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 270),
            child: FloatingActionButton(
                onPressed: () {
                  context.pushNamed('userprofile');
                },
                backgroundColor: kPrimaryColor,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(imageUrl),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 21.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Fact of the day',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        'The first dinosaur fossil was found around 1815',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (isChecked == true) {
                      context.pushNamed('displayresults');
                    } else {
                      context.pushNamed('instructions');
                    }
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(29, 0, 0, 0),
                              blurRadius: 4.0,
                              spreadRadius: 0,
                              offset: Offset(
                                5,
                                5,
                              ))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Image.asset(
                              'assets/images/searchicon.png',
                              scale: 2.5,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Tap to Identify',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 21),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Discoveries',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                StreamBuilder<List<MapModel>>(
                    stream: MapRepository().getMaps(),
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: CarouselSlider(
                          options: CarouselOptions(
                              autoPlay: true,
                              aspectRatio: 2.0,
                              enlargeCenterPage: true),
                          items: listImages
                              .map((item) => Container(
                                    child: Container(
                                      margin: const EdgeInsets.all(5.0),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          child: Stack(
                                            children: [
                                              GestureDetector(
                                                child: Image.asset(item,
                                                    fit: BoxFit.cover,
                                                    width: 1000.0),
                                                onTap: () {
                                                  context.goNamed('fossil_map');
                                                },
                                              ),
                                              Positioned(
                                                bottom: 0.0,
                                                left: 0.0,
                                                right: 0.0,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color.fromARGB(
                                                            200, 0, 0, 0),
                                                        Color.fromARGB(
                                                            0, 0, 0, 0)
                                                      ],
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end: Alignment.topCenter,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ))
                              .toList(),
                        ),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
      // drawer: const SideDrawer(),
    );
  }
}
