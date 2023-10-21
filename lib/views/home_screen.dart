import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_tutorial/models/news_channel_headlines_model.dart';
import 'package:news_tutorial/view_models/news_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_tutorial/views/category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, washington, reuters, cnn, alJazeera }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');
  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  FilterList? selectedMenu;
  String name = "bbc-news";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("News",
              style: GoogleFonts.poppins(fontSize: 20, color: Colors.black)),
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategoriesScreen()));
            },
            icon: Image.asset(
              'assets/images/category_icon.png',
              scale: 25,
            ),
          ),
          actions: [
            PopupMenuButton<FilterList>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }
                if (FilterList.washington.name == item.name) {
                  name = 'the-washington-post';
                }

                if (FilterList.cnn.name == item.name) {
                  name = 'cnn';
                }
                if (FilterList.reuters.name == item.name) {
                  name = 'reuters';
                }
                if (FilterList.alJazeera.name == item.name) {
                  name = 'al-jazeera-english';
                }

                setState(() {
                  selectedMenu = item;
                });
              },
              initialValue: selectedMenu,
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<FilterList>>[
                PopupMenuItem<FilterList>(
                  value: FilterList.bbcNews,
                  child: Text("BBC News"),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.washington,
                  child: Text("Washington"),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.reuters,
                  child: Text("Reuters"),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.cnn,
                  child: Text("CNN"),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.alJazeera,
                  child: Text("Al-Jazeera"),
                ),
              ],
            )
          ],
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView(
            children: [
              Container(
                height: height * .4,
                width: width,
                // color: Colors.grey,
                child: FutureBuilder<NewsChannelHeadlinesModel>(
                  future: newsViewModel.fetchNewsChannelHeadlinesApi(name),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitFadingCircle(
                          color: Colors.teal,
                          size: 50.0,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 12, right: 7),
                              child: Stack(children: [
                                Container(
                                  height: height * .8,
                                  width: width * .8,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.fill,
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error_outline,
                                              color: Colors.red),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: height * .02,
                                    right: width * .01,
                                    left: width * .01,
                                    child: Card(
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins()),
                                            SizedBox(height: height * .03),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    style: GoogleFonts.anton(
                                                        fontSize: 15.0,
                                                        color: Colors.teal)),
                                                Text(format.format(dateTime),
                                                    style: GoogleFonts.akshar(
                                                      fontSize: 12.0,
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                              ]),
                            );
                          });
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
