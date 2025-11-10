import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Picker Example"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: _selectedImage == null
                  ? const Icon(Icons.image, size: 100, color: Colors.grey)
                  : Image.file(_selectedImage!, fit: BoxFit.cover),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: _pickFromGallery,
                  icon: const Icon(Icons.photo),
                  label: const Text("Gallery"),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: _pickFromCamera,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Camera"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
