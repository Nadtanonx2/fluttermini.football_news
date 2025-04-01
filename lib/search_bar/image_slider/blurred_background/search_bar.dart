import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/search_bar/image_slider/blurred_background/search_bar_menu_button.dart';
import 'package:project1/search_bar/image_slider/blurred_background/search_results_page.dart';

class Search_Bar extends StatefulWidget {
  final List<Map<String, String>> newsList;

  Search_Bar({required this.newsList});

  @override
  _Search_BarState createState() => _Search_BarState();
}

class _Search_BarState extends State<Search_Bar> {
  TextEditingController _searchController = TextEditingController();

  void _onSearch(String query) {
    if (query.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsPage(
            query: query,
            newsList: widget.newsList,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      padding: const EdgeInsets.symmetric(horizontal: 10.5, vertical: 15.0), // ปรับ padding เพิ่ม vertical padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                controller: _searchController,
                style: GoogleFonts.kanit(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                  hintText: 'ค้นหา',
                  prefixIcon: Icon(Icons.search, color: Colors.white, size: 25),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),

                    borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.2), width: 2.0),
                  ),
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                  fillColor: Colors.white.withOpacity(0.2),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                ),
                onSubmitted: _onSearch,
              ),
            ),
          ),
          SearchBarMenuButton(onPressed: () {
            print("เปิดเมนูหมวดหมู่");
          }),
        ],
      ),
    );
  }
}