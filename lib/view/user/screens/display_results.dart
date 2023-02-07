import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:graduation_project/view/user/widgets/getcolor.dart';

class DisplayResults extends StatefulWidget {
  const DisplayResults({super.key});

  @override
  State<DisplayResults> createState() => _DisplayResultsState();
}

class _DisplayResultsState extends State<DisplayResults> {
  File? _imageFile;

  final _picker = ImagePicker();

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go('/');
          },
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: kDarkColor,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                height: 300,
                width: 280,
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: Colors.white),
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      const BoxShadow(
                          color: Colors.black12,
                          offset: Offset(2, 2),
                          spreadRadius: 2,
                          blurRadius: 1)
                    ]),
                child: (_imageFile != null)
                    ? Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.photo_camera_back,
                        size: 50,
                      )),
            FloatingActionButton(
                onPressed: () {
                  _openImagePicker();
                },
                tooltip: 'Select Image',
                backgroundColor: Colors.white,
                child: const Icon(Icons.add_a_photo_outlined,
                    size: 25, color: kPrimaryColor)),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Name',
              style: TextStyle(
                  color: kDarkColor, fontFamily: 'Inter', fontSize: 30),
            ),
            const SizedBox(
              height: 80,
            ),
            SizedBox(
              height: 40,
              width: 100,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: getColor(kPrimaryColor, kTextColor)),
                child: const Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Inter', fontSize: 20),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
