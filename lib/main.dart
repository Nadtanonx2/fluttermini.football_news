import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/chang_suek_news/chang_suek_news.dart';
import 'package:project1/data/news_data.dart';
import 'package:project1/la_liga_news/la_liga_news.dart';
import 'package:project1/premium_league_news/premium_league_news.dart';
import 'package:project1/search_bar/image_slider/blurred_background/search_bar_menu_button.dart';
import 'package:project1/search_bar/image_slider/blurred_background/search_page.dart';
import 'package:project1/trending_news/trending_news.dart';
import 'package:project1/search_bar/image_slider/blurred_background/image_slider.dart'; // นำเข้า OverlappingSliderHeader และ MyHeaderDelegate

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

// Delegate สำหรับ SliverPersistentHeader
class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  MyHeaderDelegate({required this.child, required this.height});

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // เมื่อกดไอคอนค้นหา
  void _onSearchPressed() {
    print("Search icon pressed");
    // เพิ่มการนำทางไปยังหน้าค้นหาหรือดำเนินการอื่น ๆ ตามที่ต้องการ
  }

  // เมื่อกดปุ่ม SearchBarMenuButton
  void _onMenuPressed() {
    print("Search menu button pressed");
    // ดำเนินการเปิดเมนูหมวดหมู่หรืออื่น ๆ
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar ที่มีชื่อแอปทางด้านซ้ายและไอคอนค้นหา + ปุ่มเมนูด้านขวาสุด
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'KIKISPORT',
          style: GoogleFonts.kanit(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.pink,
          ),
        ),
        actions: [
          IconButton(
    icon: Icon(Icons.search, color: Colors.pink),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchPage(newsList: trendingNews),
        ),
      );
    },
  ),
          SearchBarMenuButton(
            onPressed: _onMenuPressed,
          ),
        ],
      ),
      // ส่วนเนื้อหาใช้ CustomScrollView
      body: CustomScrollView(
        slivers: [
          // SliverPersistentHeader ที่มี OverlappingSliderHeader
          SliverPersistentHeader(
            pinned: false,
            delegate: MyHeaderDelegate(
              height: 220,
              child: OverlappingSliderHeader(
                imageList: trendingNews,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                // ไม่ส่ง Search_Bar เข้าไปใน header เนื่องจากค้นหาอยู่ใน AppBar แล้ว
                searchBar: Container(),
              ),
            ),
          ),
          // เนื้อหาส่วนอื่นๆ
          SliverToBoxAdapter(
            child: Column(
              children: [
                // ข่าวที่กำลังมาแรง
                TrendingNews(trendingNews: trendingNews),
                // ข่าว section "ช้างศึก"
                ChangSuekNews(trendingNews: trendingNews),
                // ข่าว section "Premium League England"
                PremiumLeagueNews(trendingNews: trendingNews),
                // ข่าว section "La Liga Spain"
                LaLigaSpainNews(trendingNews: trendingNews),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
