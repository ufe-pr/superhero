import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:superhero/models/character_model.dart' as char;
import 'package:superhero/providers/theme_provider.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var args = ModalRoute.of(context).settings.arguments;
    char.Character character = args;
    return Scaffold(
      body: MyScrollView(
        character: character,
      ),
      backgroundColor: themeProvider.isDarkTheme ? themeProvider.darkTheme.primaryColor : Colors.grey.shade300,
    );
  }
}

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Hero(
              tag:this.heroTag,
              child: CachedNetworkImage(
                imageUrl: this.imageUrl,
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
                    Color(0x8f000000),
                    Colors.transparent,
                    themeProvider.isDarkTheme ? Color(0x62000000) : Color(0x62ffffff),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.characterName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  this.publisher,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white
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

Widget _buildDifferentSizeText(String text, BuildContext context) {
  String part1, part2;
  List<String> splitString = text.split(' ');
  if (splitString.length == 2) {
    part1 = splitString[0];
    part2 = splitString[1];
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: part1, style: ATTRIBUTE_VALUE_STYLE.copyWith(color: Theme.of(context).textTheme.bodyText1.color)),
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

  return Text(
    text,
    style: ATTRIBUTE_VALUE_STYLE,
  );
}

class _MyScrollViewState extends State<MyScrollView> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
        SliverAppBar(
          leading: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.chevronLeft,
              color: themeProvider.isDarkTheme ? Colors.white : Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
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
        ),
      ],
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: Text(
              'Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Wrap(
            spacing: 5,
            runSpacing: 10,
            children: <Widget>[
              AttributeCard(
                attributeValue: Text(
                  widget.character.biography.alignment,
                  style: ATTRIBUTE_VALUE_STYLE,
                  softWrap: true,
                ),
                attributeName: 'Alignment',
                repIcon: Icon(Icons.format_align_right),
              ),
              AttributeCard(
                attributeValue: Text(
                  '${widget.character.powerstats.average}',
                  style: ATTRIBUTE_VALUE_STYLE,
                  softWrap: true,
                ),
                attributeName: 'Power',
                repIcon: Icon(Icons.offline_bolt),
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.appearance.race,
                  style: ATTRIBUTE_VALUE_STYLE,
                  softWrap: true,
                ),
                attributeName: 'Race',
                repIcon: Icon(Icons.person),
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.appearance.gender,
                  style: ATTRIBUTE_VALUE_STYLE,
                  softWrap: true,
                ),
                attributeName: 'Gender',
                repIcon: FaIcon(FontAwesomeIcons.transgender),
              ),
              AttributeCard(
                attributeValue:
                    _buildDifferentSizeText(widget.character.appearance.height, context),
                attributeName: 'Height',
                repIcon: Icon(Icons.swap_vert),
              ),
              AttributeCard(
                attributeValue:
                    _buildDifferentSizeText(widget.character.appearance.weight, context),
                attributeName: 'Weight',
                repIcon: Icon(Icons.fitness_center),
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.appearance.eyeColor,
                  style: ATTRIBUTE_VALUE_STYLE,
                  softWrap: true,
                ),
                attributeName: 'Eye color',
                repIcon: Icon(Icons.remove_red_eye),
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.appearance.hairColor,
                  style: ATTRIBUTE_VALUE_STYLE,
                  softWrap: true,
                ),
                attributeName: 'Hair color',
                repIcon: Icon(Icons.face),
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.work.base,
                  style: ATTRIBUTE_VALUE_STYLE,
                  softWrap: true,
                ),
                attributeName: 'Base of operation',
                repIcon: Icon(Icons.location_on),
                isFullWidth: true,
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.biography.fullName,
                  style: ATTRIBUTE_VALUE_STYLE,
                  softWrap: true,
                ),
                attributeName: 'Full Name',
                repIcon: Icon(Icons.details),
                isFullWidth: true,
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.work.occupation,
                  style: ATTRIBUTE_VALUE_STYLE,
                  softWrap: true,
                ),
                attributeName: 'Occupation',
                repIcon: Icon(Icons.work),
                isFullWidth: true,
              ),
              AttributeCard(
                attributeValue: Text(
                  widget.character.biography.placeOfBirth,
                  style: ATTRIBUTE_VALUE_STYLE,
                  softWrap: true,
                ),
                attributeName: 'Place of birth',
                repIcon: Icon(Icons.my_location),
                isFullWidth: true,
              ),
              AttributeCard(
                attributeValue: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.character.connections.groupAffiliation
                      .map((group) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              group.toUpperCase(),
                              style: ATTRIBUTE_VALUE_STYLE,
                              softWrap: true,
                            ),
                          ))
                      .toList(),
                ),
                attributeName: 'Group Affiliations',
                repIcon: Icon(Icons.swap_horiz),
                isFullWidth: true,
              ),
              AttributeCard(
                attributeValue: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      widget.character.connections.relatives.map((relative) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        relative.toUpperCase(),
                        style: ATTRIBUTE_VALUE_STYLE,
                        softWrap: true,
                      ),
                    );
                  }).toList(),
                ),
                attributeName: 'Relatives',
                repIcon: Icon(Icons.people),
                isFullWidth: true,
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
  fontWeight: FontWeight.w400,
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      elevation: themeProvider.isDarkTheme ? 0 : 10,
      child: Container(
        padding: EdgeInsets.all(10),
        width: isFullWidth
            ? MediaQuery.of(context).size.width - 20
            : (MediaQuery.of(context).size.width - 41) / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: this.attributeValue),
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
