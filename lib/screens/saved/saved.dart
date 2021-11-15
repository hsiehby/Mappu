import 'package:flutter/material.dart';
import 'package:mappu/db/database_helper.dart';
import 'package:mappu/models/saved_article.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'country_to_continent.dart' as c_to_c;

class SavedWidget extends StatelessWidget {
  const SavedWidget({Key? key}) : super(key: key);
  static const List<String> continents = ['Asia','Europe','North America','Australia','Africa','Antarctica', 'South America'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: continents.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
              tabs: List<Widget>.generate(continents.length, (int index) {
                return Tab(text: continents[index]);
              }),
              isScrollable: true,
          ),
          title: const Text('Your Saved Articles'),
        ),
        body: TabBarView(
          children: List<Widget>.generate(continents.length, (int index) {
            return SavedList(continent: continents[index]);
          })
        ),
      ),
    );
  }
}

class SavedList extends StatefulWidget {
  final String continent;
  const SavedList({Key? key, required this.continent}) : super(key: key);

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  final dbHelper = DatabaseHelper.instance;
  List<SavedArticle> articles = <SavedArticle>[];

  @override
  void initState() {
    super.initState();

    dbHelper.getSavedArticles()
        .then((data) {
          setState(() {
            articles = data.where((i) => c_to_c.countryToContinent[i.countryId] == widget.continent).toList();
          });
    });
  }

  ListTile _tile(SavedArticle article) {
    return ListTile(
        title: Text(article.title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(timeago.format(article.pubDate),
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.grey[500],
            )),
        leading: const Icon(Icons.emoji_flags)
    );
  }

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: List<Widget>.generate(articles.length, (int index) {
        return _tile(articles[index]);
      })
    );
  }

}

const countryToContinent = {
"AD": "Europe",
"AE": "Asia",
"AF": "Asia",
"AG": "North America",
"AI": "North America",
"AL": "Europe",
"AM": "Asia",
"AN": "North America",
"AO": "Africa",
"AQ": "Antarctica",
"AR": "South America",
"AS": "Australia",
"AT": "Europe",
"AU": "Australia",
"AW": "North America",
"AZ": "Asia",
"BA": "Europe",
"BB": "North America",
"BD": "Asia",
"BE": "Europe",
"BF": "Africa",
"BG": "Europe",
"BH": "Asia",
"BI": "Africa",
"BJ": "Africa",
"BM": "North America",
"BN": "Asia",
"BO": "South America",
"BR": "South America",
"BS": "North America",
"BT": "Asia",
"BW": "Africa",
"BY": "Europe",
"BZ": "North America",
"CA": "North America",
"CC": "Asia",
"CD": "Africa",
"CF": "Africa",
"CG": "Africa",
"CH": "Europe",
"CI": "Africa",
"CK": "Australia",
"CL": "South America",
"CM": "Africa",
"CN": "Asia",
"CO": "South America",
"CR": "North America",
"CU": "North America",
"CV": "Africa",
"CX": "Asia",
"CY": "Asia",
"CZ": "Europe",
"DE": "Europe",
"DJ": "Africa",
"DK": "Europe",
"DM": "North America",
"DO": "North America",
"DZ": "Africa",
"EC": "South America",
"EE": "Europe",
"EG": "Africa",
"EH": "Africa",
"ER": "Africa",
"ES": "Europe",
"ET": "Africa",
"FI": "Europe",
"FJ": "Australia",
"FK": "South America",
"FM": "Australia",
"FO": "Europe",
"FR": "Europe",
"GA": "Africa",
"GB": "Europe",
"GD": "North America",
"GE": "Asia",
"GF": "South America",
"GG": "Europe",
"GH": "Africa",
"GI": "Europe",
"GL": "North America",
"GM": "Africa",
"GN": "Africa",
"GP": "North America",
"GQ": "Africa",
"GR": "Europe",
"GS": "Antarctica",
"GT": "North America",
"GU": "Australia",
"GW": "Africa",
"GY": "South America",
"HK": "Asia",
"HN": "North America",
"HR": "Europe",
"HT": "North America",
"HU": "Europe",
"ID": "Asia",
"IE": "Europe",
"IL": "Asia",
"IM": "Europe",
"IN": "Asia",
"IO": "Asia",
"IQ": "Asia",
"IR": "Asia",
"IS": "Europe",
"IT": "Europe",
"JE": "Europe",
"JM": "North America",
"JO": "Asia",
"JP": "Asia",
"KE": "Africa",
"KG": "Asia",
"KH": "Asia",
"KI": "Australia",
"KM": "Africa",
"KN": "North America",
"KP": "Asia",
"KR": "Asia",
"KW": "Asia",
"KY": "North America",
"KZ": "Asia",
"LA": "Asia",
"LB": "Asia",
"LC": "North America",
"LI": "Europe",
"LK": "Asia",
"LR": "Africa",
"LS": "Africa",
"LT": "Europe",
"LU": "Europe",
"LV": "Europe",
"LY": "Africa",
"MA": "Africa",
"MC": "Europe",
"MD": "Europe",
"ME": "Europe",
"MG": "Africa",
"MH": "Australia",
"MK": "Europe",
"ML": "Africa",
"MM": "Asia",
"MN": "Asia",
"MO": "Asia",
"MP": "Australia",
"MQ": "North America",
"MR": "Africa",
"MS": "North America",
"MT": "Europe",
"MU": "Africa",
"MV": "Asia",
"MW": "Africa",
"MX": "North America",
"MY": "Asia",
"MZ": "Africa",
"NA": "Africa",
"NC": "Australia",
"NE": "Africa",
"NF": "Australia",
"NG": "Africa",
"NI": "North America",
"NL": "Europe",
"NO": "Europe",
"NP": "Asia",
"NR": "Australia",
"NU": "Australia",
"NZ": "Australia",
"OM": "Asia",
"PA": "North America",
"PE": "South America",
"PF": "Australia",
"PG": "Australia",
"PH": "Asia",
"PK": "Asia",
"PL": "Europe",
"PM": "North America",
"PN": "Australia",
"PR": "North America",
"PS": "Asia",
"PT": "Europe",
"PW": "Australia",
"PY": "South America",
"QA": "Asia",
"RE": "Africa",
"RO": "Europe",
"RS": "Europe",
"RU": "Europe",
"RW": "Africa",
"SA": "Asia",
"SB": "Australia",
"SC": "Africa",
"SD": "Africa",
"SE": "Europe",
"SG": "Asia",
"SH": "Africa",
"SI": "Europe",
"SJ": "Europe",
"SK": "Europe",
"SL": "Africa",
"SM": "Europe",
"SN": "Africa",
"SO": "Africa",
"SR": "South America",
"ST": "Africa",
"SV": "North America",
"SY": "Asia",
"SZ": "Africa",
"TC": "North America",
"TD": "Africa",
"TF": "Antarctica",
"TG": "Africa",
"TH": "Asia",
"TJ": "Asia",
"TK": "Australia",
"TM": "Asia",
"TN": "Africa",
"TO": "Australia",
"TR": "Asia",
"TT": "North America",
"TV": "Australia",
"TW": "Asia",
"TZ": "Africa",
"UA": "Europe",
"UG": "Africa",
"US": "North America",
"UY": "South America",
"UZ": "Asia",
"VC": "North America",
"VE": "South America",
"VG": "North America",
"VI": "North America",
"VN": "Asia",
"VU": "Australia",
"WF": "Australia",
"WS": "Australia",
"YE": "Asia",
"YT": "Africa",
"ZA": "Africa",
"ZM": "Africa",
"ZW": "Africa"
};