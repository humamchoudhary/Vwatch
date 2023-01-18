import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/Components/color.dart';
import 'package:vwatch/main.dart';

class CheckBox extends StatefulWidget {
  final int index;
  CheckBox({super.key, required this.index});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool check = false;
  List genres = ["hello"];
  List selectedgen = [];
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: WhiteColor,
      checkColor: CTAColor,
      // checkboxShape: Outlined,
      title: Text(
        genres[widget.index],
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
              color: HexColor("#AAB1C2"),
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
      ),
      tileColor: CTAColor,
      onChanged: (bool? value) {
        print(value);
        setState(() {
          check = value!;
        });
      },
      value: check,
    );
  }
}