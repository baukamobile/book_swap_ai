import 'package:book_swap_ai/pages/chatting.dart';
import 'package:flutter/material.dart';

List<String> genres = <String>[
  'Fiction', 'Mystery/Crime', 'Fantasy', 'Science Fiction (Sci-Fi)', 
  'Romance', 'Thriller/Suspense', 'Historical Fiction', 'Horror', 
  'Young Adult (YA)', 'Dystopian', 'Classics', 'Biography/Autobiography', 
  'Memoirs', 'Self-Help', 'Non-Fiction (General)', 'Adventure', 
  'Magical Realism', 'Poetry', 'True Crime', 'Children’s Literature',
];

List<String> sorts = <String>['Price low to high', 'Price high to low', 'New In'];
List<String> cities = <String>['Astana', 'Almaty', 'Shymkent', 'Aktobe', 'Karagandy'];

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 45),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.search, size: 50),
                  onPressed: () {
                    // Add your search functionality here
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Sorting Dropdown
                Container(
                  width: 100,  // Simplified width for consistent size
                  child: DropdownButton<String>(
                    value: dropdownValue2,
                    icon: const Icon(Icons.sort),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue2 = value!;
                      });
                    },
                    items: sorts.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                
                // Location Dropdown
                Container(
                  width: 100,
                  child: DropdownButton<String>(
                    value: dropdownValue3,
                    icon: const Icon(Icons.location_on),
                    elevation: 1,
                    style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue3 = value!;
                      });
                    },
                    items: cities.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

                // Genre Dropdown
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: 100,
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: genres.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // Image InkWell
                Container(
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => GeminiChat())
                    ),
                    child: Image.asset('assets/img/ai.jpg', width: 30),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
