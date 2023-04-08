// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class ImageController extends GetxController {
//   static ImageController get to => Get.find<ImageController>();

//   File? image;
//   var imagePath = ''.obs;
//   final _picker = ImagePicker();

//   Future<void> getImage(ImageSource source) async {
//     final pickedFile = await _picker.pickImage(source: source);

//     if (pickedFile != null) {
//       image = File(pickedFile.path);
//       imagePath.value = pickedFile.path;
//       update();
//     }
//   }
// }
