import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/trending_news/click_news_page.dart';

class SearchPage extends StatefulWidget {
  final List<Map<String, String>> newsList;

  const SearchPage({Key? key, required this.newsList}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredNews = [];
  bool _hasSearched = false; // Flag ตรวจสอบว่าค้นหาหรือยัง

  void _onSearch(String query) {
    setState(() {
      _hasSearched = true;
    });
    if (query.isNotEmpty) {
      final results = widget.newsList.where((news) {
        final title = news['title'] ?? '';
        return title.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        _filteredNews = results;
      });
    } else {
      setState(() {
        _filteredNews = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar ที่มีปุ่มกลับและ TextField สำหรับค้นหา
     appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.pink),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          onSubmitted: _onSearch,
          style: GoogleFonts.kanit(color: Colors.pink, fontSize: 16.0),
          decoration: InputDecoration(
            hintText: 'ค้นหา',
            hintStyle: TextStyle(color: Colors.pink.withOpacity(0.8)),
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search, color: Colors.pink),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: _hasSearched
            ? _filteredNews.isNotEmpty
                ? ListView.builder(
                    itemCount: _filteredNews.length,
                    itemBuilder: (context, index) {
                      final news = _filteredNews[index];
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          leading: news['image'] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    news['image']!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey,
                                  child: Icon(Icons.image, color: Colors.black),
                                ),
                          title: Text(
                            news['title'] ?? 'ไม่มีหัวข้อข่าว',
                            style: GoogleFonts.kanit(color: Colors.black),
                          ),
                          subtitle: Text(
                            news['refer'] ?? '',
                            style: GoogleFonts.kanit(color: Colors.black),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ClickNewsPage(newsItem: news),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'ไม่มีผลลัพธ์',
                      style: GoogleFonts.kanit(
                          color: Colors.pink, fontSize: 18.0),
                    ),
                  )
            : Container(), // ไม่แสดงอะไรจนกว่าผู้ใช้จะค้นหา
      ),
    );
  }
}
