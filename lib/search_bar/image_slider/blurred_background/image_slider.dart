import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:project1/trending_news/news_detail_page.dart';

class ImageSlider extends StatefulWidget {
  final List<Map<String, String>> imageList; // เปลี่ยนเป็น List<Map<String, String>>
  final Function(int, CarouselPageChangedReason) onPageChanged;

  ImageSlider({
    required this.imageList,
    required this.onPageChanged,
  });

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 210.0,
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
          items: widget.imageList.map((item) { // เปลี่ยนจาก imagePath เป็น item
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector( // เพิ่ม GestureDetector
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailPage(newsItem: item), // ส่ง item ไปยัง NewsDetailPage
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: Image.asset(item['image']!, fit: BoxFit.cover), // ใช้ item['image']!
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 1,
          child: DotsIndicator(
            dotsCount: widget.imageList.length,
            position: _currentIndex.toDouble(),
            decorator: DotsDecorator(
              size: const Size.square(7.0),
              activeSize: const Size(18.0, 5.0),
              activeColor: Colors.black,
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BlurredBackground extends StatelessWidget {
  final String imagePath;
  BlurredBackground({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220.0,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}