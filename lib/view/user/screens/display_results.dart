import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/data/repositories/user_repo.dart';
import 'package:graduation_project/view/identify_as_guest.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/view/user/widgets/getcolor.dart';
import '../../../data/repositories/teethfossil_repo.dart';

Future<String>? imageUrl;
UserRepository userRepo = UserRepository.instance;
FosssilRepository fossilRepo = FosssilRepository.instance;

class DisplayResults extends StatefulWidget {
  const DisplayResults({super.key});

  @override
  State<DisplayResults> createState() => _DisplayResultsState();
}

class _DisplayResultsState extends State<DisplayResults> {
  File? imageFile;
  Future<String>? imageurl;

  final picker = ImagePicker();
  List resolutions = [];
  bool isLoading = false;



  @override
  void initState() {
    super.initState();
  }
Future<String> uploadImage() async {
  try {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("images" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    print(url);
    return url;
  } catch (e) {
    print(e);
    return '';
  }
}
  Future<void> openImagePicker({required ImageSource imageSource}) async {
  try {
    final XFile? pickedImage = await picker.pickImage(source: imageSource);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
        isLoading = true;
        _predict();
        resolutions = [];
      });
      String url = await uploadImage();
      setState(() {
        imageUrl = Future.value(url);
        isLoading = false;
      });
    }
  } on PlatformException catch (e) {
    throw Exception(e.message);
  }
}
  //final TextEditingController nameController = TextEditingController();
  final TextEditingController imageurlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () async {
            if (await userRepo.getUserType() == 'User') {
              context.go('/startpage');
            } else {
              context.go('/startpage_expert');
            }
          },
          color: Colors.white,
        ),
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              context.pushNamed('instructions');
            },
            child: const Icon(
              Icons.question_mark_rounded,
              color: Colors.white,
            ),
          ),
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
              child: (imageFile != null)
                  ? Image.file(
                      File(imageFile!.path),
                      fit: BoxFit.cover,
                    )
                  : Container(),
            ),
            FloatingActionButton(
                onPressed: () async {
                  await showDialog(
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
                                    onPressed: () async { 
                                     await openImagePicker(
                                        imageSource: ImageSource.gallery);
                                         Future<String>? url =  uploadImage();
                                       setState(() {
                                      imageUrl = url;
                                      });
                                         print(imageUrl);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Gallery')),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      openImagePicker(
                                          imageSource: ImageSource.camera);
                                             Future<String>? url =  uploadImage();
                                           setState(() {
                                              imageUrl = url;
                                           });    
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Camera')),
                           ]),
                        ),
                      ],
                    ),
                  );
                  setState(() {
                    isLoading = true;
                  });
                },
                tooltip: 'Select Image',
                backgroundColor: Colors.white,
                child: const Icon(Icons.add_a_photo_outlined,
                    size: 25, color: kPrimaryColor)),
            const SizedBox(
              height: 30,
            ),
            ////
            ///   Testing Widget
            ///

            // const Text(
            //   'Name',
            //   style: TextStyle(
            //       color: kDarkColor, fontFamily: 'Inter', fontSize: 30),
            // ),
            const Center(
              child: Text(
                'Output',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (isLoading)
              LoadingAnimationWidget.staggeredDotsWave(
                  color: kPrimaryColor, size: 30),
            (resolutions.isEmpty)
                ? const SizedBox(
                    height: 50,
                  )
                : Column(
                    children: [
                      Text(
                        resolutions.first['label'],
                        style: const TextStyle(
                          fontSize: 20,
                          color: kDarkColor,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
            SizedBox(
              height: 40,
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Inter', fontSize: 20),
                ),
              onPressed: () async {                 
              final userId = UserRepository.instance.getFirebaseUid();
              final imageUrl = await uploadImage();   
              await FirebaseFirestore.instance
              .collection('Users')
              .doc(userId)
              .collection('Fossils')
              .add({
              'name': resolutions.first['label'],
              'imageUrl': imageUrl.toString(),  
              });
                // context.go('/library');
              },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future recognizeImage(File image) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 5,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
        resolutions = recognitions ?? [];
      });
    });

    int endTime = DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }

  _predict() async {
    final res = await Tflite.loadModel(
      model: "assets/tensorflow/model_unquant.tflite",
      labels: "assets/tensorflow/labels.txt",
      // useGpuDelegate: true,
    );
    recognizeImage(imageFile!);
  }
}