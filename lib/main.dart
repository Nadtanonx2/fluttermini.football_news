import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/data/news_data.dart';
import 'package:project1/search_bar/image_slider/blurred_background/image_slider.dart';
import 'package:project1/search_bar/image_slider/blurred_background/search_bar.dart';
import 'package:project1/trending_news/trending_news.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KIKISPORT',
          style: GoogleFonts.kanit(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.pink,
          ),
        ),
      ),
      body: Stack(
        children: [
          BlurredBackground(
            imagePath: trendingNews[_currentIndex]['image'] != null
                ? trendingNews[_currentIndex]['image']!
                : 'assets/images/placeholder.png',
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Search_Bar(newsList: [...trendingNews,]), 
                // Search_Bar(newsList: [...trendingNews, ...premierleagueNews2]), // ✅ ส่งรายการข่าวไป
                ImageSlider(
                  imageList: trendingNews, // ส่ง trendingNews ทั้งหมดไปยัง ImageSlider
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                TrendingNews(
                  trendingNews: trendingNews,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}