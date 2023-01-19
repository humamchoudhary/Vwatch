import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vwatch/Components/color.dart';
import 'package:vwatch/main.dart';

class CheckBox extends StatefulWidget {
  final int index;
  List list; 
  CheckBox({super.key, required this.index,required this.list});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool check = false;
  List genres = ['Action', 'Sci-Fi', 'Animation', 'Comedy', 'Crime', 'Fantasy', 'Drama', 'Mystery', 'Adventure'];
  // List widget.list = [];
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // checkboxShape:
      // RoundedRectangleBorder(side: BorderSide(color: WhiteColor)),
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
      leading: Checkbox(
        fillColor:  MaterialStateProperty.all(WhiteColor),
        checkColor: CTAColor,
        onChanged: (bool? value) {
          print(value);
          setState(() {
            check = value!;
          });
          if(check){
            widget.list.add(genres[widget.index]);
          }else{
            widget.list.remove(genres[widget.index]);
          }
          print(widget.list);
        },
        value: check,
      ),
    );
  }
}
