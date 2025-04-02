import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:project1/trending_news/click_news_page.dart';

class OverlappingSliderHeader extends StatefulWidget {
  final List<Map<String, String>> imageList;
  final Function(int, CarouselPageChangedReason) onPageChanged;
  final Widget searchBar; // รับ widget สำหรับ Search_Bar

  const OverlappingSliderHeader({
    Key? key,
    required this.imageList,
    required this.onPageChanged,
    required this.searchBar,
  }) : super(key: key);

  @override
  _OverlappingSliderHeaderState createState() => _OverlappingSliderHeaderState();
}

class _OverlappingSliderHeaderState extends State<OverlappingSliderHeader> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // พื้นหลังเบลอ
        Container(
          width: double.infinity,
          height: 220,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Image.asset(
              widget.imageList[_currentIndex]['image'] ?? 'assets/images/placeholder.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Carousel Slider
        CarouselSlider(
          options: CarouselOptions(
            height: 220,
            autoPlay: true,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
                widget.onPageChanged(index, reason);
              });
            },
          ),
          items: widget.imageList.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClickNewsPage(newsItem: item),
                      ),
                    );
                  },
                  child: Image.asset(
                    item['image']!,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                );
              },
            );
          }).toList(),
        ),
        // Dots indicator อยู่ด้านล่าง
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: DotsIndicator(
            dotsCount: widget.imageList.length,
            position: _currentIndex.toDouble(),
            decorator: DotsDecorator(
              size: const Size.square(7.0),
              activeSize: const Size(18.0, 5.0),
              activeColor: Colors.white,
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
        // วาง Search_Bar ไว้ด้านบนของสไลด์
        Positioned(
          top: 30,
          left: 16,
          right: 16,
          child: widget.searchBar,
        ),
      ],
    );
  }
}
