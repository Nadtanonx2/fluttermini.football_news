import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NewsDetailPage extends StatefulWidget {
  final Map<String, String> newsItem;

  NewsDetailPage({required this.newsItem});

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(Duration(seconds: 3)); // จำลองการโหลดข้อมูล
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.newsItem['image'];
    final title = widget.newsItem['title'];
    final refer = widget.newsItem['refer'];
    final content1 = widget.newsItem['content1'];
    final content2 = widget.newsItem['content2'];
    final content3 = widget.newsItem['content3'];
    final content4 = widget.newsItem['content4'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title ?? 'News Details',
          style: GoogleFonts.kanit(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body:
          _isLoading
              ? Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: Colors.pinkAccent,
                  size: 50,
                ),
              )
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (imageUrl != null)
                        Image.asset(
                          imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 210,
                              color: Colors.grey[300],
                              child: Center(child: Text('Image Error')),
                            );
                          },
                        ),
                      SizedBox(height: 8),
                      if (content1 != null)
                        Text(content1, style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      if (content2 != null)
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            '     \t$content2',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                      SizedBox(height: 8),
                      if (content3 != null)
                        Text(content3, style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      if (content4 != null)
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            '     \t$content4',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                      SizedBox(height: 8),
                      if (refer != null)
                        Text(refer, style: GoogleFonts.kanit(fontSize: 16)),
                    ],
                  ),
                ),
              ),
    );
  }
}
