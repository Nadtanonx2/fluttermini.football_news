import 'package:flutter/material.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/trending_news/all_trending_news.dart';
import 'package:project1/trending_news/click_news_page.dart';


class TrendingNews extends StatelessWidget {
  final List<Map<String, String>> trendingNews;

  const TrendingNews({super.key, required this.trendingNews});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // ตั้ง padding ด้านล่างเป็น 0 เพื่อไม่ให้มีช่องว่างเพิ่มเติม
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ข่าวที่กำลังมาแรง',
                  style: GoogleFonts.kanit(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllNewsPage(allNews: trendingNews),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'ดูทั้งหมด',
                    style: GoogleFonts.kanit(color: Colors.orange, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          // ลบ SizedBox ที่มีความสูงออกหรือปรับเป็น 0
          const SizedBox(height: 0),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trendingNews.length,
              itemBuilder: (context, index) {
                final newsItem = trendingNews[index];
                return GestureDetector(
                  onTap: () {
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClickNewsPage(newsItem: newsItem),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            newsItem['image'] ?? 'assets/default_image.png',
                            width: 210,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          newsItem['title'] ?? 'ไม่มีหัวข้อข่าว',
                          style: GoogleFonts.kanit(fontSize: 14.0),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          newsItem['refer'] ?? 'ไม่ระบุแหล่งที่มา',
                          style: GoogleFonts.kanit(fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
