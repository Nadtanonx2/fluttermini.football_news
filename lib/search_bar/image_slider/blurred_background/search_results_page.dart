import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/trending_news/news_detail_page.dart';

class SearchResultsPage extends StatelessWidget {
  final String query;
  final List<Map<String, String>> newsList;

  SearchResultsPage({required this.query, required this.newsList});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> filteredNews = newsList.where((news) {
      return news['title']!.toLowerCase().contains(query.toLowerCase()) ||
          news['seond']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('ผลลัพธ์การค้นหา: "$query"',
            style: GoogleFonts.kanit(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: filteredNews.isEmpty
          ? Center(
              child: Text('ไม่พบข่าวที่ตรงกับ "$query"',
                  style: GoogleFonts.kanit(fontSize: 18)))
          : ListView.builder(
              itemCount: filteredNews.length,
              itemBuilder: (context, index) {
                final news = filteredNews[index];
                return GestureDetector( // เพิ่ม GestureDetector
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(newsItem: news), // ใช้ NewsDetailPage
                      ),
                    );
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: SizedBox(
                        width: 110,
                        height: 70,
                        child: news['image'] != null
                            ? Image.asset(news['image']!, fit: BoxFit.cover)
                            : Container(
                                width: 110,
                                height: 70,
                                color: Colors.grey[300], // แสดงสีเทาเมื่อไม่มีรูปภาพ
                                child: Center(child: Icon(Icons.image, color: Colors.grey)),
                              ),
                      ),
                    ),
                    title: Text(news['title']!),
                    subtitle: Text(
                      news['refer'] ?? '',
                      style: GoogleFonts.kanit(fontSize: 14.0),
                    ),
                  ),
                );
              },
            ),
    );
  }
}