import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_news/utils/colors.dart';


import 'package:url_launcher/url_launcher.dart';

import '../widgets/custom_richtext.dart';
import '../widgets/custom_textfields.dart';
import '../model/model.dart';

class NewsDetailedScreen extends StatefulWidget {
  final Article album;

  const NewsDetailedScreen({super.key, required this.album});

  @override
  State<NewsDetailedScreen> createState() => _NewsDetailedScreenState();
}

class _NewsDetailedScreenState extends State<NewsDetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: blue,
        title: const Text(
          "News Details",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: white, fontFamily: 'Poppins'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mediumSpacing(context, 0.02),
              Stack(children: [
                Image.network(
                  widget.album.urlToImage ??
                      'https://cdn.vectorstock.com/i/500p/82/99/no-image-available-like-missing-picture-vector-43938299.jpg',
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
              ]),
              mediumSpacing(context, 0.03),
              Text(
                widget.album.title.toUpperCase(),
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: blue),
              ),
              mediumSpacing(context, 0.03),
              CustomRichText(
                  boldText: 'Source: ',
                  italicText: widget.album.source.name,
                  italicTextColor: blue),
              mediumSpacing(context, 0.03),
              Text(
                widget.album.description,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.brown),
              ),
              mediumSpacing(context, 0.03),
              CustomRichText(
                  boldText: 'Author: ',
                  italicText: widget.album.author,
                  italicTextColor: blue),
              mediumSpacing(context, 0.03),
              GestureDetector(
                onTap: () async {
                  final url = widget.album.url;
                  if (!await launchUrl(Uri.parse(url))) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: CustomRichText(
                    boldText: 'Link to Original Article :\n\n',
                    italicText: widget.album.url,
                    italicTextColor: Colors.blue),
              ),
              mediumSpacing(context, 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Published At: ${DateFormat('dd/MM/yyyy').format((widget.album.publishedAt))}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey),
                  ),
                ],
              ),
              mediumSpacing(context, 0.01),
              const Divider(
                color: black,
                height: 20,
              ),
              mediumSpacing(context, 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
