import 'package:book_swap_ai/pages/chatting.dart';
import 'package:flutter/material.dart';

List<String> genres = <String>[
  'Fiction', 'Mystery/Crime', 'Fantasy', 'Science Fiction (Sci-Fi)', 
  'Romance', 'Thriller/Suspense', 'Historical Fiction', 'Horror', 
  'Dystopian', 'Classics', 'Biography/Autobiography', 
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
            // Search Bar
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

            // Filter Row (Sorting, Location, Genre, AI Chat)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Sorting Dropdown
                _buildDropdown(
                  value: dropdownValue2,
                  icon: Icons.sort,
                  items: sorts,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue2 = value!;
                    });
                  },
                ),
                
                // Location Dropdown
                _buildDropdown(
                  value: dropdownValue3,
                  icon: Icons.location_on,
                  items: cities,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue3 = value!;
                    });
                  },
                ),

                // Genre Dropdown
                _buildDropdown(
                  value: dropdownValue,
                  icon: Icons.arrow_downward,
                  items: genres,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                ),

                // AI Chat Image InkWell
                _buildAiChatButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Custom Dropdown Widget
  Widget _buildDropdown({
    required String value,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: 100,  // Consistent width for dropdowns
      child: DropdownButton<String>(
        value: value,
        icon: Icon(icon),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  // AI Chat Button (Image InkWell)
  Widget _buildAiChatButton(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => GeminiChat())
        ),
        child: Image.asset('assets/img/ai.jpg', width: 30),
      ),
    );
  }
}
