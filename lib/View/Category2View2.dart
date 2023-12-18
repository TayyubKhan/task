import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task/Repositories/categoryrepo.dart';

import '../Model/Db_Model.dart';
import '../Model/categoryMode.dart';
import '../Repositories/api_services.dart';
import '../ViewModel/dbViewModel.dart';
import '../main.dart';
import 'DetialScreen.dart';

class Category2View2 extends StatefulWidget {
  const Category2View2({super.key});

  @override
  State<Category2View2> createState() => _Category2View2State();
}

class _Category2View2State extends State<Category2View2> {
  @override
  void initState() {
    super.initState();
    db.getTitlesList(TableName.table1).then((value) {
      setState(() {
        readTitles = Set.from(value);
        app = false;
      });
    });
  }

  final db = DBHelper();
  final cat = CategoryRepo(Dio(BaseOptions(contentType: 'application/json')));
  final format = DateFormat('MMMM dd,yyyy');
  Set<String> readTitles = {}; // Maintain a set of read article titles
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: FutureBuilder(
          future: cat.getPosts('pakistan'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
            } else {
              List<Articles> articles = snapshot.data!.articles!;
              return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final date = DateTime.parse(
                        articles[index].publishedAt!);
                    bool isRead = readTitles.contains(articles[index].title!);
                    if (isRead) {
                      return const SizedBox.shrink();
                    } else {
                      if (articles[index].urlToImage != null) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: InkWell(
                          onTap: () {
                            int id = DateTime.now().millisecondsSinceEpoch;
                            db
                                .insert(
                              TableName.table1,
                              DB_Model(
                                id: id,
                                title: articles[index].title!,
                                tab: 2,
                              ),
                            )
                                .then((value) {})
                                .onError((error, stackTrace) {
                              if (kDebugMode) {
                                print(error.toString());
                              }
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      title: articles[index].title!,
                                      body: articles[index].content!,
                                      imageUrl: articles[index].urlToImage!,
                                      sourceName: articles[index].source!.name!,
                                      time: format.format(date),
                                      newsUrl:articles[index].url!,
                                    )));
                          },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                  CachedNetworkImage(
                                    placeholder: (context, url) => const CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                    errorWidget: (context, url, error) => const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                    imageUrl: articles[index].urlToImage!,
                                  ),
                                Text(
                                  articles[index].title!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Published At: ${format.format(date)}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                      }
                    }
                  });
            }
          }),
    );
  }
}
