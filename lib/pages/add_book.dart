import 'dart:io';
import 'package:book_swap_ai/themes/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
List<String> genres = ['Fiction', 'Mystery', 'Fantasy', 'Sci-Fi', 'Romance', 'Horror', 'Thriller', 'Biography', 'History', 'Self-Help'];
List<String> cities = ['Astana', 'Almaty', 'Shymkent', 'Aktobe', 'Karagandy'];


class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {


   String dropdownValue = genres.first;
  String dropdownValue3 = cities.first;
  File? _selectedImage;
  bool _isNew = true; // Book condition state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
        centerTitle: true,
        backgroundColor: darkMode.colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView( // Wrap everything in ListView
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
                  icon: const Icon(Icons.photo, color: Colors.white),
                  label: const Text(
                    "Select from Gallery",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _pickImageFromCamera,
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  label: const Text(
                    "Take a Photo",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              maxLength: 20,
              decoration: const InputDecoration(
                hintText: "Title",
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              maxLength: 20,
              decoration: const InputDecoration(
                hintText: "Author",
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                
                hintText: "Price",
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            _buildDropdown(
                    value: dropdownValue3,
                    icon: Icons.location_on,
                    items: cities,
                    onChanged: (value) => setState(() {
                      dropdownValue3 = value!;

                    }),
                  ),
                  _buildDropdown(
                    value: dropdownValue,
                    icon: Icons.arrow_downward,
                    items: genres,
                    onChanged: (value) => setState(() {
                      dropdownValue = value!;

                    }),
                  ),
            const SizedBox(height: 10),
            TextField(
              maxLines: 5,

              maxLength: 100,
              decoration: const InputDecoration(
                hintText: "Description",
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Book is new? "),
                Checkbox(
                  value: _isNew,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isNew = newValue ?? true;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: 150,
              height: 90,
              color: Colors.purple,
              child: const Center(
                child: Text(
                  "Publish",
                  style: TextStyle(color: Colors.white),
                ),
              ),
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


  Widget _buildDropdown({
    required String value,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButton<String>(
      value: value,
      icon: Icon(icon),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
