import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:provider/provider.dart';
import 'package:superhero/models/character_model.dart';
import 'package:superhero/providers/theme_provider.dart';
import 'package:superhero/services/api_methods.dart';
import 'package:superhero/ui/details_page.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({Key key, this.character}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return Details();
              },
              settings: RouteSettings(
                arguments: this.character,
                name: 'details',
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.all(0),
          elevation: 10,
          color: themeProvider.isDarkTheme ? Color(0xff11111f) : Colors.grey,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Hero(
                  tag: this.character.id,
                  child: CachedNetworkImage(
                    imageUrl: this.character.image.url,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => CircularProgressIndicator(),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        themeProvider.isDarkTheme
                            ? Color(0xdd000000)
                            : Color(0xddffffff),
//                        Colors.transparent,
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    this.character.name,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Characters extends StatefulWidget {
  @override
  _CharactersState createState() => _CharactersState();
}

class _CharactersState extends State<Characters> {
  Future<List<Character>> data;
  String search = 'man';
  FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    data = getSearchResults(search);
  }

  performSearch() async {
    setState(() {
      data = getSearchResults(search);
      _searchFocusNode.unfocus();
    });
  }

  void setSearch(text) {
    setState(() {
      search = text;
    });
  }

  void reSearch(str) {
    setState(() {
      data = getSearchResults(str);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return new Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverAppBar(
            title: TextField(
              keyboardType: TextInputType.text,
              focusNode: _searchFocusNode,
              textInputAction: TextInputAction.search,
              onChanged: setSearch,
              onSubmitted: reSearch,
              onEditingComplete: performSearch,
              decoration: InputDecoration(
                hintText: 'start typing...',
                suffixIcon: GestureDetector(
                  onTap: performSearch,
                  child: Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            floating: true,
            snap: true,
            actions: <Widget>[
              Switch(
                  value: themeProvider.isDarkTheme,
                  onChanged: (val) {
                    themeProvider.themeDataSwitch(val);
                  })
            ],
          ),
        ],
        body: FutureBuilder(
          future: data,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    snapshot.error,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            var width = MediaQuery.of(context).size.width;
            return snapshot.hasData
                ? GridView.count(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    crossAxisCount: width < 480 ? 2 : (width * 3 / 800).round(),
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 20,
                    childAspectRatio: .75,
                    children: <Widget>[
                      for (int i = 0; i < snapshot.data.length; i++)
                        CharacterCard(
                          character: snapshot.data[i],
                        )
                    ],
                  )
                : Center(
                    child: Loading(
                    indicator: BallPulseIndicator(),
                    size: 80.0,
                    color:
                        themeProvider.isDarkTheme ? Colors.white : Colors.black,
                  ));
          },
        ),
      ),
    );
  }
}
