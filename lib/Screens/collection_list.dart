import 'dart:ui';

import 'package:fin/Components/Colors.dart';
import 'package:fin/Widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class CollectionList extends StatefulWidget {
  const CollectionList({super.key});

  @override
  State<CollectionList> createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: textPrimary,
        ),
        title: Text(
          "Collection List",
          style: TextStyle(color: textPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 52,
                  width: 171,
                  child: Center(
                    child: Text("Completed",
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: textPrimary,
                        ))),
                  ),
                  decoration: BoxDecoration(
                      color: box02, borderRadius: BorderRadius.circular(5)),
                ),
                Container(
                  height: 52,
                  width: 171,
                  child: Center(
                    child: Text("Pending",
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: textPrimary,
                        ))),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xFFFFC2C2),
                      borderRadius: BorderRadius.circular(5)),
                )
              ],
            ),
            Container(
              height: 630,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 17,
                  itemBuilder: ((context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 10, right: 10),
                        child: CustomerList());
                  })),
            )
          ],
        ),
      ),
    );
  }
}
