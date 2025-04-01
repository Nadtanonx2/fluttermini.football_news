import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/trending_news/news_detail_page.dart';

class AllNewsPage extends StatelessWidget {
  final List<Map<String, String>> allNews;

  AllNewsPage({required this.allNews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ดูทั้งหมด',
          style: GoogleFonts.kanit(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: allNews.length,
        itemBuilder: (context, index) {
          return GestureDetector( // เพิ่ม GestureDetector
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(newsItem: allNews[index]), // ใช้ NewsDetailPage
                ),
              );
            },
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: SizedBox(
                  width: 110,
                  height: 80,
                  child: Image.asset(allNews[index]['image']!, fit: BoxFit.cover),
                ),
              ),
              title: Text(allNews[index]['title']!),
              subtitle: Text(
                allNews[index]['refer'] ?? '',
                style: GoogleFonts.kanit(fontSize: 14.0),
              ),
            ),
          );
        },
      ),
    );
  }
}