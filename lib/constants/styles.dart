import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_clone/constants/colors.dart';

TextStyle labelStyle = GoogleFonts.poppins(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

TextStyle labelStyle2 = GoogleFonts.poppins(
  fontSize: 24,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

TextStyle labelStyle3 = GoogleFonts.poppins(
  color: appPurple,
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

TextStyle buttonStyle = GoogleFonts.poppins(
  fontSize: 18,
  color: Colors.white,
);

BoxDecoration inputBoxDecoration = BoxDecoration(
  color: Colors.grey[200],
  border: Border.all(color: Colors.grey[350]),
  borderRadius: BorderRadius.circular(10),
);
