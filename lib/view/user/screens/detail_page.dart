import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/domain/fossil_model.dart';
import 'package:graduation_project/data/repositories/teethfossil_repo.dart';

FosssilRepository fossilRepo = FosssilRepository.instance;

class DetailPage extends StatefulWidget {
  // final Map? image;
  final Fossil fossil;
  const DetailPage({required this.fossil, super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
              child: Image.network(widget.fossil.imageUrl!),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              widget.fossil.name!,
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
                      fossilRepo.removeFossil(widget.fossil.id!);
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
