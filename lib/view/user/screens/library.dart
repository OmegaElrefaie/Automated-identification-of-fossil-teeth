import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/domain/fossil_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/data/repositories/teethfossil_repo.dart';
import '../../../data/repositories/user_repo.dart';

FosssilRepository fossilRepo = FosssilRepository.instance;

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  Set<String> fossilIdsSearchResult = {};
  bool isLoading = false;
  String fossilId = UserRepository.instance.getFirebaseUid();

  void onSearch() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    final userId = UserRepository.instance.getFirebaseUid();
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Fossils')
        .where("name", isEqualTo: searchController.text)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No Teethfossil Found")));
        setState(() {
          isLoading = false;
        });
        return;
      }
      for (var fossilDoc in value.docs) {
        if (fossilDoc.id != fossilId) {
          fossilIdsSearchResult.add(fossilDoc.id);
          searchResult.add(fossilDoc.data());
        }
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  final List<Map<String, dynamic>> images = [
    {
      'id': 'i1',
      'title': 'Shark',
      'url':
          'https://www.fossils-uk.com/images/3-5-inch-miocene-megalodon-fossil-shark-tooth-from-south-carolina-usa-sku-v2865-otodus-carcharocles-megalodon-p5349-15096_zoom.jpg'
    },
    {
      'id': 'i2',
      'title': 'Shark',
      'url':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiLHojdSIUwnmrneOVpTxs3AgTf0-4YgS8ELxfWw5NWEi5yny-MRGeX8tsv_9PKKiU0ok&usqp=CAU'
    },
    {
      'id': 'i3',
      'title': 'Crocodile',
      'url':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRN98ngDvflsdyXn2hI1wHR9w5rPSqLyggqdQ&usqp=CAU'
    },
    {
      'id': 'i4',
      'title': 'Crocodile',
      'url':
          'https://i.pinimg.com/originals/d3/7c/f0/d37cf044ed9aa78dba995aeba9d5030e.jpg'
    },
    {
      'id': 'i5',
      'title': 'Elephant',
      'url':
          'https://paleoenterprises.com/wp-content/uploads/2021/8855/2021-09-04-23.33.32.jpg'
    },
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageurlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userId = UserRepository.instance.getFirebaseUid();
    return Scaffold(
        body: Stack(children: [
      Padding(
        padding: const EdgeInsets.only(top: 170.0),
        child: FutureBuilder(
            future:
                //  fossilRepo.fetchAllFosssil(),
                FirebaseFirestore.instance
                    .collection('Users')
                    .doc(userId)
                    .collection('Fossils')
                    .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 15),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext ctx, index) {
                      QueryDocumentSnapshot<Map<String, dynamic>> document =
                          snapshot.data!.docs[index];
                      Fossil myFossil = Fossil(
                          id: document.id,
                          name: document['name'],
                          imageUrl: document['imageUrl']);

                      return Card(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: AspectRatio(
                                  aspectRatio: 16 / 16,
                                  child: InkWell(
                                    key: ValueKey(myFossil.id),
                                    onTap: () {
                                      GoRouter.of(context).push("/detail_page",
                                          extra: myFossil);
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(
                                      //         builder: (context) => DetailPage(
                                      //               image: getdoc['id'],
                                      //             )));
                                    },
                                    // child: Hero(
                                    //   tag: myFossil.id,
                                    child: Image.network(
                                      myFossil.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Center(
                                child: Text(
                                  myFossil.name!,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Inter',
                                      fontSize: 14),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 200, left: 160),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    CircularProgressIndicator(color: kPrimaryColor),
                  ],
                ),
              );
            }),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Library',
                style: TextStyle(
                    color: kTextColor, fontFamily: 'Inter', fontSize: 30),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: "Search for Teethfossil ...",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      onSearch();
                    },
                    icon: const Icon(Icons.search_outlined))
              ],
            ),
            const SizedBox(height: 0),
            if (searchResult.isNotEmpty)
              Expanded(
                  child: ListView.builder(
                      itemCount: searchResult.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(0),
                          child: ListTile(
                            title: Text(searchResult[index]['name']),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  searchController.text = "";
                                });
                              },
                              icon: IconButton(
                                color: kPrimaryColor,
                                icon: const Icon(
                                    Icons.arrow_forward_ios_outlined),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        );
                      }))
            else if (isLoading == true)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    ]));
  }
}
