import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/trending_news/all_trending_news.dart';
import 'package:project1/trending_news/click_news_page.dart';

class PremiumLeagueNews extends StatelessWidget {
  final List<Map<String, String>> trendingNews;

  const PremiumLeagueNews({super.key, required this.trendingNews});

  @override
  Widget build(BuildContext context) {
    // กรองข่าวที่มี section เป็น "Premium League England"
    final premiumLeagueNews =
        trendingNews.where((news) {
          final section = news['section']?.toLowerCase() ?? '';
          return section == 'premium league england'.toLowerCase();
        }).toList();

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 0,
        bottom: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 25, 252, 131), // สีพื้นหลังที่ต้องการ
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                // แสดงรูปที่ได้จาก trendingNews หากมี key 'image2'
                Image.asset(
                  trendingNews.isNotEmpty && trendingNews[0]['image3'] != null
                      ? trendingNews[0]['image3']!
                      : 'assets/default_logo.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 8),
                Text(
                  'Premium League England',
                  style: GoogleFonts.kanit(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 56, 0, 78),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  AllNewsPage(allNews: premiumLeagueNews),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'ดูทั้งหมด',
                    style: GoogleFonts.kanit(color: const Color.fromARGB(255, 56, 0, 78), fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          // // หัวข้อส่วนข่าวและปุ่ม "ดูทั้งหมด"
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       'Premium League England',
          //       style: GoogleFonts.kanit(
          //         fontSize: 18.0,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     TextButton(
          //       onPressed: () {
          //         if (context.mounted) {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => AllNewsPage(allNews: premiumLeagueNews),
          //             ),
          //           );
          //         }
          //       },
          //       child: Text(
          //         'ดูทั้งหมด',
          //         style: GoogleFonts.kanit(
          //           color: Colors.orange,
          //           fontSize: 16,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 8.0),
          // แสดงรายการข่าวแบบแนวนอน
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: premiumLeagueNews.length,
              itemBuilder: (context, index) {
                final newsItem = premiumLeagueNews[index];
                return GestureDetector(
                  onTap: () {
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ClickNewsPage(newsItem: newsItem),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // รูปภาพข่าว
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
                        // หัวข้อข่าว
                        Text(
                          newsItem['title'] ?? 'ไม่มีหัวข้อข่าว',
                          style: GoogleFonts.kanit(fontSize: 14.0),
                        ),
                        const SizedBox(height: 4),
                        // แหล่งที่มา
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
