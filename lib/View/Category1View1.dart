import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task/Model/Db_Model.dart';
import 'package:task/Model/model.dart';
import 'package:task/Repositories/api_services.dart';
import 'package:intl/intl.dart';
import 'package:task/View/DetialScreen.dart';
import 'package:task/ViewModel/dbViewModel.dart';

import '../main.dart';

class  Category1View1 extends StatefulWidget {
  const  Category1View1({super.key});

  @override
  State< Category1View1> createState() => _Category1View1State();
}

class _Category1View1State extends State< Category1View1> {
  final db = DBHelper();
  final api = ApiServices(Dio(BaseOptions(contentType: 'application/json')));
  final format = DateFormat('MMMM dd,yyyy');
  Set<String> readTitles = {}; // Maintain a set of read article titles

  @override
  void initState() {
    super.initState();
      db.getTitlesList(TableName.table1).then((value) {
        setState(() {
          readTitles = Set.from(value);
        });
      });


  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
        future: api.getPosts('abc-news'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else {
            List<Articles> articles = snapshot.data!.articles!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final date = DateTime.parse(articles[index].publishedAt!);
                bool isRead = readTitles.contains(articles[index].title!);
                if (isRead) {
                  return const SizedBox.shrink();
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: InkWell(
                      onTap: () {
                        int id=DateTime.now().millisecondsSinceEpoch;
                        db.insert(
                          TableName.table1,
                          DB_Model(
                            id: id,
                            title: articles[index].title!,
                            tab: 1,
                          ),
                        ).then((value) {
                          // setState(() {
                          //   readTitles.add(value.title!);
                          // });
                        }).onError((error, stackTrace) {
                          print(error.toString());
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
                              newsUrl: articles[index].url!,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              placeholder: (context, url) =>
                              const CircularProgressIndicator(
                                color: Colors.black,
                              ),
                              errorWidget: (context, url, error) =>
                              const Icon(
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
              },
            );
          }
        },
      ),
    );
  }
}
