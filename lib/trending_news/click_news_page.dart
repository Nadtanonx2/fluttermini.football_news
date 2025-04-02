import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/trending_news/news_detail_page.dart';

class ClickNewsPage extends StatelessWidget {
  final Map<String, String> newsItem;

  const ClickNewsPage({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ปุ่มย้อนกลับแยกไว้บนรูปภาพ
            Stack(
              children: [
                if (newsItem['image'] != null)
                  Image.asset(
                    newsItem['image']!,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),

            // เนื้อหา
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsItem['section'] ?? 'ไม่มีรายละเอียดข่าว',
                    style: GoogleFonts.kanit(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    newsItem['title'] ?? '',
                    style: GoogleFonts.kanit(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    newsItem['seond'] ?? '',
                    style: GoogleFonts.kanit(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    newsItem['refer'] ?? '',
                    style: GoogleFonts.kanit(
                      fontSize: 14.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ปุ่มด้านล่าง
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: const Border(top: BorderSide(color: Colors.grey)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.thumb_up),
                    label: Text('ถูกใจ', style: GoogleFonts.kanit()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.rate_review),
                    label: Text('รีวิว', style: GoogleFonts.kanit()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => NewsDetailPage(newsItem: newsItem),
                        ),
                      );
                    },
                    icon: const Icon(Icons.chrome_reader_mode),
                    label: Text('อ่านเลย', style: GoogleFonts.kanit()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
