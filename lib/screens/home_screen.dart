import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_news/screens/login_screen.dart';
import 'package:my_news/utils/colors.dart';
import 'package:provider/provider.dart';
import 'newsDetail_screen.dart';
import '../widgets/custom_textfields.dart';
import 'news_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NewsProvider _newsProvider;
  String selectedCountry = 'IN';

  final List<String> countryCodes = [
    'IN',
    'AU',
    'BE',
    'BG',
    'BR',
    'CA',
    'CH',
    'CN',
    'CO',
    'CU',
    'CZ',
    'DE',
    'EG',
    'NG',
    'NL',
    'NO',
    'NZ',
    'PH',
    'PL',
    'PT',
    'RO',
    'RS',
    'RU',
    'SA',
    'SE',
    'SG',
    'SI',
    'SK',
    'TH',
    'TR',
    'TW',
    'UA',
    'US',
    'VE',
    'ZA',
    'FR',
    'GB',
    'GR',
    'HK',
    'HU',
  ];

  @override
  void initState() {
    super.initState();
    _newsProvider = NewsProvider();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _newsProvider.fetchBusiness(selectedCountry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _newsProvider,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 245, 250, 0.97),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor:  blue,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "MyNews",
                    style: TextStyle(
                      fontSize: 17,
                      color: blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text(
                    'Are You Sure Want to LogOut',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Popins',
                      color: black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: const Text(
                        "OK",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: white,
                        ),
                      ),
                    ),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          label: const Row(
            children: [
              Icon(Icons.logout,color: white,size: 20,),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: blue,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "MyNews",
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: white,
              ),
            ),
          ),
          actions: [
            const Icon(
              CupertinoIcons.location_fill,
              color: white,
              size: 20,
            ),
            const SizedBox(
              width: 5,
            ),
            DropdownButton<String>(
              value: selectedCountry,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.transparent,
              ),
              dropdownColor: blue,
              underline: Container(),
              items: countryCodes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: white),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCountry = newValue!;
                  _newsProvider.fetchBusiness(selectedCountry);
                });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              const Row(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Top Headlines",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: black,
                        fontFamily: 'Poppins'),
                  ),
                ],
              ),
              mediumSpacing(context, 0.009),
              Consumer<NewsProvider>(
                  builder: (BuildContext context, newsProvider, _) {
                return Expanded(
                  child: newsProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : newsProvider.errorMessage != null
                          ? Center(
                              child: Text(
                              newsProvider.errorMessage!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: blue,
                                  fontSize: 22),
                            ))
                          : ListView.builder(

                              itemCount:
                                  newsProvider.albumBusiness?.articles.length ??
                                      0,
                              itemBuilder: (context, index) {
                                final article =
                                    newsProvider.albumBusiness?.articles[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NewsDetailedScreen(
                                          album: article,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    elevation: 0,
                                    surfaceTintColor: white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  article?.source.id ??
                                                      'News Source',
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        'assets/fonts/Poppins/Poppins-Bold.ttf',
                                                    color: black,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  '${article?.title}',
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: black,
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                Text(
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(
                                                          article!.publishedAt),
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    color: grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 8),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              article.urlToImage ??
                                                  'https://thumbs.dreamstime.com/b/breaking-news-background-breaking-news-background-world-global-tv-news-banner-design-vector-illustration-101370713.jpg',
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
