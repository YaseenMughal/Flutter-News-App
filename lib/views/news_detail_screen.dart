import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  final String image, title, date, description, author, content, source;
  const NewsDetailScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.date,
      required this.description,
      required this.author,
      required this.content,
      required this.source});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    DateTime dateTime = DateTime.parse(widget.date);
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black)),
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              height: height * .45,
              width: width,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: CachedNetworkImage(
                    imageUrl: widget.image,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Center(
                          child: SpinKitFadingCircle(
                            color: Colors.teal,
                            size: 50.0,
                          ),
                        )),
              ),
            ),
            Container(
                height: height * .7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                margin: EdgeInsets.only(top: height * .4),
                padding:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                child: ListView(
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: height * .04),
                    Text("Channel:- ${widget.source}",
                        style: GoogleFonts.anton(
                            fontSize: 15.0, color: Colors.teal)),
                    SizedBox(height: height * .02),
                    Text("Date:-            ${format.format(dateTime)}",
                        style: GoogleFonts.akshar(
                          fontSize: 13.0,
                        )),
                    SizedBox(height: height * .05),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    // Text(widget.source,
                    //     style: GoogleFonts.anton(
                    //         fontSize: 15.0, color: Colors.teal)),
                    // Text(format.format(dateTime),
                    //     style: GoogleFonts.akshar(
                    //       fontSize: 13.0,
                    //     )),
                    //   ],
                    // ),
                    Text(
                      widget.description,
                      style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ))
          ],
        ));
  }
}
