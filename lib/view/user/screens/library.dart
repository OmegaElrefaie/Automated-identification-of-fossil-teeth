import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'detail_page.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final List<Map<String, dynamic>> images = [
    {
      'id': 'i1',
      'title': 'One',
      'url': 'https://www.kindacode.com/wp-content/uploads/2022/08/1.png'
    },
    {
      'id': 'i2',
      'title': 'Two',
      'url': 'https://www.kindacode.com/wp-content/uploads/2022/08/2.png'
    },
    {
      'id': 'i3',
      'title': 'Three',
      'url': 'https://www.kindacode.com/wp-content/uploads/2022/08/3.jpg'
    },
    {
      'id': 'i4',
      'title': 'Four',
      'url': 'https://www.kindacode.com/wp-content/uploads/2022/08/4.jpg'
    },
    {
      'id': 'i5',
      'title': 'Five',
      'url': 'https://www.kindacode.com/wp-content/uploads/2022/08/5.jpg'
    },
    {
      'id': 'i6',
      'title': 'Six',
      'url': 'https://www.kindacode.com/wp-content/uploads/2022/08/6.jpg'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned(
        top: 60,
        left: 0,
        right: 0,
        child: Container(
          alignment: Alignment.center,
          height: 54,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  width: 2, color: Color.fromARGB(255, 199, 198, 198))),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontFamily: "Inter",
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 120.0),
        child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15),
            itemCount: images.length,
            itemBuilder: (BuildContext ctx, index) {
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
                            key: ValueKey(images[index]['id']),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                        image: images[index],
                                      )));
                            },
                            child: Hero(
                              tag: images[index]['id'],
                              child: Image.network(
                                images[index]['url'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Center(
                        child: Text(
                          images[index]['title'],
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
            }),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Center(
              child: Text(
                'Library',
                style: TextStyle(
                    color: kTextColor, fontFamily: 'Inter', fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    ]));
  }
}
