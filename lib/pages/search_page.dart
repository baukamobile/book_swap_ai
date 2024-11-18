import 'package:book_swap_ai/pages/chatting.dart';
import 'package:flutter/material.dart';

List<String> genres = <String>['fantasy', 'Fiction', 'Detective', 'Drama'];
List<String> sorts = <String>['Price low to high','Price high to low', 'New In'];
List<String> cities = <String>['Astana','Almaty','Shymkent','Aktobe','Karagandy'];

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String dropdownValue = genres.first;
  String dropdownValue2 = sorts.first;
  String dropdownValue3 = cities.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 45), // Padding for the whole ListView
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Space between TextField and Icon
                  IconButton(
                    icon: const Icon(Icons.search, size: 50,),
                    onPressed: () {
                      // Add your search functionality here
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20), // Space between the rows
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                  //Genres
                  DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: genres.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList()),
          //Sorting
          DropdownButton<String>(
          value: dropdownValue2,
          icon: const Icon(Icons.sort),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue2 = value!;
            });
          },
          items: sorts.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList()),
          DropdownButton<String>(
          value: dropdownValue3,
          icon: const Icon(Icons.location_on),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue3 = value!;
            });
          },
          items: cities.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList()),
          //Geo Position
          // DropdownButton<String>(
          // value: dropdownValue3,
          // icon: const Icon(Icons.location_on),
          // elevation: 16,
          // style: const TextStyle(color: Colors.deepPurple),
          // underline: Container(
          //   height: 2,
          //   color: Colors.deepPurpleAccent,
          // ),
          // onChanged: (String? value) {
          //   // This is called when the user selects an item.
          //   setState(() {
          //     dropdownValue3 = value!;
          //   });
          // },
          // items: cities.map<DropdownMenuItem<String>>((String value) {
          //   return DropdownMenuItem<String>(
          //     value: value,
          //     child: Text(value),
          //   );
          // }).toList()),
          // //Sorting
          
                  // const Text(
                  //   "Genres",
                  //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  // ),
                  Container(
                    // height: 200,
                    // width: 200,
                    // padding: const EdgeInsets.all(8.0),
                    // decoration: BoxDecoration(
                    //   color: Colors.deepPurple.shade100, // Example background color
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    child: InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>GeminiChat())),
                      child: Image.asset('assets/img/ai.jpg',width: 30,)),
                )
                
                ],
              ),
            ],
          ),
        ),

    );
  }
}