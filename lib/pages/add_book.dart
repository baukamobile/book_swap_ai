import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        alignment: Alignment.bottomLeft,
        child: Row(
          // alignment: Alignment.bottomLeft,
          children: [
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                
                color: Colors.purple,
                width: 150,
                height: 150,
              
                child: Center(child: InkWell
                (
                  child:
                   Text("Select from Galary", style: TextStyle(
                    color: Colors.white
                   ),))
                   ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                
                color: Colors.purple,
                width: 150,
                height: 150,
              
                child: Center(child: 
                InkWell
                (
                  child:
                   Text("Take a photo", style: TextStyle(
                    color: Colors.white
                   ),))
                   ),
              ),
            ),
          ],
        ),
      ),
    );
  }
//image picker future func
  Future _pickImageFromGallery() async{
    await ImagePicker();
  }

}