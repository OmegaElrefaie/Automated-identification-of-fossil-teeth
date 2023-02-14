import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';

class DetailPage extends StatelessWidget {
  final Map? image;
  const DetailPage({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // implement the app bar
      appBar: AppBar(
        foregroundColor: kDarkColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Hero(
                tag: image!['id'],
                child: Image.network(image!['url']),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              image!['title'],
              style: const TextStyle(
                  color: kTextColor, fontFamily: 'Inter', fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 230,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 50),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    try {
                      // removePlant(widget.plant.id!);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Deleted')));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Error Occured')));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 187, 43, 32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                  ),
                  child: const Text('Remove'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
