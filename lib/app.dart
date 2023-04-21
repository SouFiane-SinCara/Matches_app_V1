import 'package:flutter/material.dart';
import 'package:match_app_v1/UI/config/colors.dart';
import 'package:match_app_v1/UI/config/textstyle.dart';
import 'package:match_app_v1/back/card.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:match_app_v1/back/lists/todaylistmatch.dart';
import 'package:match_app_v1/back/lists/tomorrowlistmatch.dart';
import 'package:match_app_v1/back/lists/yesterdaylistmatch.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int chosedate = 2;
  Matchcard? i;
  int? j;
  List h = [];
  String? zero;

  Future getdataoftomorrow() async {
    final time = DateTime.now();
    if (time.month < 10) {
      zero = "0";
    } else {
      zero = "";
    }
    final base = Uri.parse(
        "https://onefootball.com/matches?date=${time.year}-$zero${time.month}-${time.day + 1}");
    final url = await http.get(base);
    dom.Document selector = dom.Document.html(url.body);
    final imgurl = selector.querySelectorAll(
        '#__next > main > div > div > div.xpaLayoutContainer.XpaLayout_xpaLayoutContainerFullWidth__kKj0G.xpaLayoutContainerFullWidth--matchCardsList > div > ul > li > a > article > div > div.SimpleMatchCard_simpleMatchCard__teamsContent__Bj2RX > div > div > div > div > picture > img');

    int jj = 1;

    for (int i = 0; imgurl.length > i;) {
      tomorrowmatch.add(Matchcard(
          imageurlone: "${imgurl[i].attributes['src']}",
          clubonescoor: 0,
          imageurltow: "${imgurl[jj].attributes['src']}",
          clubtowscoor: 0));

      jj += 2;

      i += 2;
    }
    setState(() {});
  }

  Future getdataofyesterday() async {
    final time = DateTime.now();
    final base = Uri.parse(
        "https://onefootball.com/matches?date=${time.year}-0${time.month}-${time.day - 1}");
    final url = await http.get(base);
    dom.Document selector = dom.Document.html(url.body);
    final imgurl = selector.querySelectorAll(
        '#__next > main > div > div > div > div > ul > li > a > article > div > div.SimpleMatchCard_simpleMatchCard__teamsContent__Bj2RX > div > div > div > div > picture > img');
    final score = selector.querySelectorAll(
        '#__next > main > div > div > div > div > ul > li > a > article > div > div.SimpleMatchCard_simpleMatchCard__teamsContent__Bj2RX > div > div > span.SimpleMatchCardTeam_simpleMatchCardTeam__score__qGYmc');

    int jj = 1;
    int scoreone;
    int scoretow;
    for (int i = 0; score.length > i;) {
      if (score[i].text == '') {
        scoreone = 0;
      } else {
        scoreone = int.parse(score[i].text);
      }
      if (score[i].text == '') {
        scoreone = 0;
      } else {
        scoreone = int.parse(score[i].text);
      }
      if (score[jj].text == '') {
        scoretow = 0;
      } else {
        scoretow = int.parse(score[jj].text);
      }

      yesterdaymatch.add(Matchcard(
          imageurlone: "${imgurl[i].attributes['src']}",
          clubonescoor: scoreone,
          imageurltow: "${imgurl[jj].attributes['src']}",
          clubtowscoor: scoretow));

      jj += 2;

      i += 2;
    }
    setState(() {});
  }

  Future getdataoftoday() async {
    final url = await http.get(Uri.parse('https://onefootball.com/en/matches'));
    dom.Document selector = dom.Document.html(url.body);
    final imgurl =
        selector.getElementsByClassName('ImageWithSets_of-image__img__o1FHK ');
    final score = selector.getElementsByClassName(
        'SimpleMatchCardTeam_simpleMatchCardTeam__score__qGYmc');

    int jj = 1;
    int scoreone;
    int scoretow;
    for (int i = 0; imgurl.length > i;) {
      if (score[i].text == '') {
        scoreone = 0;
      } else {
        scoreone = int.parse(score[i].text);
      }
      if (score[i].text == '') {
        scoreone = 0;
      } else {
        scoreone = int.parse(score[i].text);
      }
      if (score[jj].text == '') {
        scoretow = 0;
      } else {
        scoretow = int.parse(score[jj].text);
      }

      todaymatches.add(Matchcard(
          imageurlone: "${imgurl[i].attributes['src']}",
          clubonescoor: scoreone,
          imageurltow: "${imgurl[jj].attributes['src']}",
          clubtowscoor: scoretow));

      jj += 2;

      i += 2;
    }
    setState(() {});
    return todaymatches;
  }

  @override
  void initState() {
    getdataoftomorrow();
    getdataofyesterday();
    getdataoftoday();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          AppBar(
            elevation: 10,
            backgroundColor: prime,
            centerTitle: true,
            title: const Text(
              "matches",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
          ),
          SizedBox(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Material(
                      elevation: 19,
                      color: prime,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            chosedate = 1;
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: prime,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Yesterday",
                            style: txts,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Material(
                      elevation: 19,
                      color: prime,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            chosedate = 2;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 125,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: prime,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Today",
                            style: TextStyle(
                                color: second,
                                fontWeight: FontWeight.bold,
                                fontSize: 35),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Material(
                      elevation: 19,
                      color: prime,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            chosedate = 3;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 125,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: prime,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Tomorrow",
                            style: txts,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: todaymatches.length,
              itemBuilder: (context, index) {
                if (chosedate == 1) {
                  i = yesterdaymatch[index];
                } else if (chosedate == 2) {
                  i = todaymatches[index];
                } else {
                  i = tomorrowmatch[index];
                }
                return Matchcard(
                    imageurlone: i!.imageurlone,
                    clubonescoor: i!.clubonescoor,
                    imageurltow: i!.imageurltow,
                    clubtowscoor: i!.clubtowscoor);
              },
            ),
          ),
        ]),
      ),
    );
  }
}
