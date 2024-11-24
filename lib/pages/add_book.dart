import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 200,
                    width: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Text('No Image Selected'),
                    ),
                  ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImageFromGallery,
                  icon: const Icon(Icons.photo, color: Colors.white,),
                  label: const Text("Publish", style: TextStyle(
                color: Colors.white
              ),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _pickImageFromCamera,
                  icon: const Icon(Icons.camera_alt,color: Colors.white,),
                  label: const Text("Publish", style: TextStyle(
                color: Colors.white
              ),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Container(
              child: TextField(
                maxLength: 20,
                decoration: InputDecoration(
          hintText: "Title",          
          enabledBorder: OutlineInputBorder(
            
          ),
          focusedBorder: OutlineInputBorder(),
          ),
              ),
            ),
              const SizedBox(height: 10,),
            Container(
              child: TextField(
                maxLength: 20,
                decoration: InputDecoration(
          hintText: "Author",
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
          ),
              ),
            ),
              const SizedBox(height: 10,),
            Container(
              child: TextField(
                maxLength: 10,
                decoration: InputDecoration(
          hintText: "Price",
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
          ),
              ),
            ),
              const SizedBox(height: 10,),
            Container(
              child: TextField(
                maxLength: 100,
                decoration: InputDecoration(
          hintText: "Description",
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
          ),
              ),
            ),
              const SizedBox(height: 10,),
            
              const SizedBox(height: 10,),
            Container(
              width: 150,
              height: 90,
              color: Colors.purple,
              child: Center(child: Text("Publish", style: TextStyle(
                color: Colors.white
              ),)),
              ),

          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
  }
}
