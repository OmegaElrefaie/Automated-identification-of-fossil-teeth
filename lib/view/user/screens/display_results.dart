import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
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
  List resolutions = [];

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _openImagePicker({required ImageSource imageSource}) async {
    final XFile? pickedImage = await _picker.pickImage(source: imageSource);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
        _predict();
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
              // child: Obx(() => imageController.imagePath.value == ''
              //     ? const Icon(
              //         Icons.photo_camera_back,
              //         size: 50,
              //       )
              //     : Image.file(
              //         File(imageController.imagePath.value),
              //         fit: BoxFit.cover,
              //       ))),
              child: (_imageFile != null)
                  ? Image.file(
                      File(_imageFile!.path),
                      fit: BoxFit.cover,
                    )
                  : Container(),
            ),
            FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      actions: [
                        Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      _openImagePicker(
                                          imageSource: ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Gallery')),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      _openImagePicker(
                                          imageSource: ImageSource.camera);

                                      Navigator.pop(context);
                                    },
                                    child: const Text('Camera')),
                              ]),
                        ),
                      ],
                    ),
                  );
                },
                tooltip: 'Select Image',
                backgroundColor: Colors.white,
                child: const Icon(Icons.add_a_photo_outlined,
                    size: 25, color: kPrimaryColor)),
            const SizedBox(
              height: 50,
            ),
            ////
            ///   Testing Widget
            ///

            const Text(
              'Name',
              style: TextStyle(
                  color: kDarkColor, fontFamily: 'Inter', fontSize: 30),
            ),
            if (resolutions.isNotEmpty)
              Text(
                resolutions.first['label'],
                style: TextStyle(fontSize: 16),
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

  Future recognizeImage(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 5,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      resolutions = recognitions ?? [];
      print(recognitions);
    });
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }

  _predict() async {
    final res = await Tflite.loadModel(
      model: "assets/tensorflow/model_unquant.tflite",
      labels: "assets/tensorflow/labels.txt",
      // useGpuDelegate: true,
    );
    recognizeImage(_imageFile!);
  }
}
