import 'package:flutter/material.dart';
import 'package:superhero/models/character_model.dart';
import 'package:superhero/services/api_methods.dart';
// import 'package:google_fonts/google_fonts.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({Key key, this.character}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: character.id,
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/details', arguments: character);
          },
          child: Container(
            height: 250,
            width: 190,
            decoration: new BoxDecoration(
              color: Color(0xff33445e),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(character.image.url),
                fit: BoxFit.cover,
              ),
            ),
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(character.name,
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  )
                ]),
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

  @override
  void initState() {
    super.initState();
    data = getSearchResults('man');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverAppBar(
            title: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(18.0),
                  ),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                hintText: 'start typing...',
                hintStyle: TextStyle(color: Colors.white60),
                fillColor: Color(0xff4f4c4c),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                contentPadding: const EdgeInsets.only(left: 20),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            floating: true,
            snap: true,
          ),
        ],
        body: ListView(
          children: <Widget>[
            FutureBuilder(
              future: data,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return snapshot.hasData
                    ? Wrap(
                        children: <Widget>[
                          for (int i = 0; i < snapshot.data.length; i++)
                            CharacterCard(
                              character: snapshot.data[i],
                            )
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
