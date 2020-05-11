import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  // String imgUrl, name;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 190,
      decoration: new BoxDecoration(
        color: Color(0xff33445e),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('assets/images/alfred.jpg'),
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
              child: Text('Pennyworth', style: TextStyle(color: Colors.white)),
            )
          ]),
    );
  }
}

class Characters extends StatefulWidget {
  const Characters({
    Key key,
  }) : super(key: key);

  @override
  _CharactersState createState() => _CharactersState();
}

class _CharactersState extends State<Characters> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xff201b1b),
      body: new ListView(
        children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(18.0),
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
                      contentPadding: const EdgeInsets.only(left: 20)),
                ),
              )
            ],
          ),
        ),
          Wrap(
            alignment: WrapAlignment.spaceAround,
//            crossAxisAlignment: Wr,
            runSpacing: 14.4, // gap between lines
            children: <Widget>[
              for(int _ = 0; _ < 20; _++)
                CharacterCard()
            ],
          )
      ]),
    );
  }
}
