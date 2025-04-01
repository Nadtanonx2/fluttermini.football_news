import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarMenuButton extends StatelessWidget {
  final VoidCallback onPressed;

  SearchBarMenuButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0, // กำหนดความสูงให้เท่ากับ TextField
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // กำหนดพื้นหลังโปร่งแสงให้เท่ากัน
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.0),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(Boxicons.bx_category, color: Colors.white, size: 25),
        label: Text(
          'หมวดหมู่',
          style: GoogleFonts.kanit(
            color: Colors.white.withOpacity(0.9),
            fontSize: 16.0,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // ทำให้พื้นหลังปุ่มโปร่งใส
          elevation: 0,
        ),
      ),
    );
  }
}
