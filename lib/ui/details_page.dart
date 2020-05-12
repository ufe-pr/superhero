import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:superhero/models/character_model.dart' as char;

class TopDisplay extends StatelessWidget {
  final String imageUrl, characterName, publisher, heroTag;

  const TopDisplay(
      {Key key,
      this.imageUrl,
      this.characterName,
      this.publisher,
      this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
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
        tag: heroTag,
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

Widget _buildDifferentSizeText(String text) {
  String part1, part2;
  List<String> splitString = text.split(' ');
  part1 = splitString[0];
  part2 = splitString[1];

  return RichText(
    text: TextSpan(
      children: [
        TextSpan(text: part1, style: ATTRIBUTE_VALUE_STYLE),
        TextSpan(
          text: part2,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

class _MyScrollViewState extends State<MyScrollView> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
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
              imageUrl: widget.character.image.url,
              characterName: widget.character.name,
              publisher: widget.character.biography.publisher,
              heroTag: widget.character.id.toString(),
            ),
          ),
          expandedHeight: 260,
          pinned: true,
          floating: false,
          snap: false,
        ),
      ],
      body: ListView(
        children: <Widget>[
          Text('Details'),
          Wrap(
            spacing: 10,
            runSpacing: 20,
            children: <Widget>[
              AttributeCard(
                attributeValue: Text(
                  widget.character.biography.alignment,
                  style: ATTRIBUTE_VALUE_STYLE,
                ),
                attributeName: 'Alignment',
                repIcon: Icon(Icons.format_align_right),
              ),
              AttributeCard(
                attributeValue: Text(
                  '${widget.character.powerstats.power}',
                  style: ATTRIBUTE_VALUE_STYLE,
                ),
                attributeName: 'Power',
                repIcon: Icon(Icons.offline_bolt),
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.appearance.race,
                  style: ATTRIBUTE_VALUE_STYLE,
                ),
                attributeName: 'Race',
                repIcon: Icon(Icons.person),
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.appearance.gender,
                  style: ATTRIBUTE_VALUE_STYLE,
                ),
                attributeName: 'Gender',
                repIcon: FaIcon(FontAwesomeIcons.transgender),
              ),
              AttributeCard(
                attributeValue:
                    _buildDifferentSizeText(widget.character.appearance.height),
                attributeName: 'Height',
                repIcon: Icon(Icons.swap_vert),
              ),
              AttributeCard(
                attributeValue:
                    _buildDifferentSizeText(widget.character.appearance.weight),
                attributeName: 'Weight',
                repIcon: Icon(Icons.fitness_center),
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.appearance.eyeColor,
                  style: ATTRIBUTE_VALUE_STYLE,
                ),
                attributeName: 'Eye color',
                repIcon: Icon(Icons.remove_red_eye),
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.appearance.hairColor,
                  style: ATTRIBUTE_VALUE_STYLE,
                ),
                attributeName: 'Hair color',
                repIcon: Icon(Icons.face),
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.work.base,
                  style: ATTRIBUTE_VALUE_STYLE,
                ),
                attributeName: 'Base of operation',
                repIcon: Icon(Icons.location_on),
                isFullWidth: true,
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.biography.fullName,
                  style: ATTRIBUTE_VALUE_STYLE,
                ),
                attributeName: 'Full Name',
                repIcon: Icon(Icons.details),
                isFullWidth: true,
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.biography.alignment,
                  style: ATTRIBUTE_VALUE_STYLE,
                ),
                attributeName: 'Alignment',
                repIcon: Icon(Icons.format_align_right),
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.work.occupation,
                  style: ATTRIBUTE_VALUE_STYLE,
                ),
                attributeName: 'Occupation',
                repIcon: Icon(Icons.work),
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.biography.placeOfBirth,
                  style: ATTRIBUTE_VALUE_STYLE,
                ),
                attributeName: 'Place of birth',
                repIcon: Icon(Icons.my_location),
              ),
              AttributeCard(
                attributeValue: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.character.connections.groupAffiliation
                      .map((group) => Text(
                            group,
                            style: ATTRIBUTE_VALUE_STYLE,
                          ))
                      .toList(),
                ),
                attributeName: 'Group Affiliations',
                repIcon: Icon(Icons.swap_horiz),
              ),
              AttributeCard(
                attributeValue: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      widget.character.connections.relatives.map((relative) {
                    List<String> splitString = relative.split(RegExp(
                      '\s.\(|\)',
                      dotAll: true,
                    ));
                    String part1 = splitString[0];
                    String part2 = splitString[1];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          part1,
                          style: ATTRIBUTE_VALUE_STYLE,
                        ),
                        Text(
                          part2,
                          style: ATTRIBUTE_NAME_STYLE,
                        ),
                      ],
                    );
                  }).toList(),
                ),
                attributeName: 'Relatives',
                repIcon: Icon(Icons.people),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const ATTRIBUTE_VALUE_STYLE = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

const ATTRIBUTE_NAME_STYLE = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w300,
);

class AttributeCard extends StatelessWidget {
  final attributeValue;
  final String attributeName;
  final Widget repIcon;
  final bool isFullWidth;

  const AttributeCard({
    Key key,
    this.attributeValue,
    this.attributeName,
    this.repIcon,
    this.isFullWidth: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        padding: EdgeInsets.all(10),
        width: isFullWidth
            ? MediaQuery.of(context).size.width - 20
            : (MediaQuery.of(context).size.width - 30) / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                this.attributeValue,
                this.repIcon,
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              this.attributeName,
              style: ATTRIBUTE_NAME_STYLE,
            ),
          ],
        ),
      ),
    );
  }
}
