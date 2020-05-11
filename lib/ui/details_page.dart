import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superhero/models/character_model.dart' as char;

class TopDisplay extends StatelessWidget {
  final String imageUrl, characterName, publisher;

  const TopDisplay({Key key, this.imageUrl, this.characterName, this.publisher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.network(
              this.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0x12000000),
                    Colors.transparent,
                    Color(0x12000000),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.characterName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  this.publisher,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      height: 275,
    );
  }
}

class MyScrollView extends StatefulWidget {

  final char.Character character;

  const MyScrollView({Key key, this.character}) : super(key: key);

  @override
  _MyScrollViewState createState() => _MyScrollViewState();
}

class _MyScrollViewState extends State<MyScrollView> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
      [
        SliverAppBar(
          leading: FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: TopDisplay(
              imageUrl:
              widget.character.image.url,
              characterName: widget.character.name,
              publisher: widget.character.biography.publisher,
            ),
          ),
          expandedHeight: 260,
          pinned: true,
          floating: false,
          snap: false,
        ),
      ],
      body: ListView(),
    );
  }
}
