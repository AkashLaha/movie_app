import 'package:flutter/material.dart';
import 'package:movie_app/utils/text.dart';
import 'package:movie_app/widgets/toprated.dart';
import 'package:movie_app/widgets/trending.dart';
import 'package:movie_app/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  final String apikey = '7014900fb14291e364f501fb62b2496a';
  final readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MDE0OTAwZmIxNDI5MWUzNjRmNTAxZmI2MmIyNDk2YSIsInN1YiI6IjY0OTI5NjRjNzA2ZTU2MDEwMDhjNTY4YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sRE7xh0aIOPCqv0SZnh9euobP439bNa_JlntRNvQMAQ';

  @override
  void initState() {
    loadmovies();
    super.initState();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readaccesstoken),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));
    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPopular();
    // print(trendingresult);
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
    print(trendingmovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: modified_text(text: 'Flutter Movie APP',color: Colors.white,size: 22,),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          TV(tv: tv),
          TrendingMovies(trending: trendingmovies),
          TopRatedMovies(
            toprated: topratedmovies,
          ),
        ],
      ),
    );
  }
}
