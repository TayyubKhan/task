import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DetailScreen extends StatefulWidget {
  final String imageUrl, title, body, sourceName, time, newsUrl;
  const DetailScreen(
      {super.key,
      required this.title,
      required this.body,
      required this.imageUrl,
      required this.sourceName,
      required this.time,
      required this.newsUrl});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'News Detailed',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              CachedNetworkImage(
                  width: width,
                  height: height * .3,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(
                        color: Colors.black,
                      ),
                  errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                  fit: BoxFit.cover,
                  imageUrl: widget.imageUrl),
            ],
          ),
          Container(
            height: height * 0.6,
            width: width,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.03),
              child: ListView(
                children: [
                  Text(
                    widget.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  Gap(height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.sourceName,
                      ),
                      Text(
                        widget.time,
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Gap(height * 0.03),
                  Text(
                    widget.body,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
