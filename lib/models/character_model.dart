// To parse this JSON data, do
//
//     final character = characterFromJson(jsonString);

import 'dart:convert';

Character characterFromJson(String str) => Character.fromMap(json.decode(str));

String characterToJson(Character data) => json.encode(data.toMap());

const Pattern COMMA_SPLITTING_PATTERN = r'[\,\;](?![^\)]+\))\s*|[\,\;](?=[^\(\,]+\()\s*|(?<=\))[\,\;]\s*';

class Character {
  final String id;
  final String name;
  final Powerstats powerstats;
  final Biography biography;
  final Appearance appearance;
  final Work work;
  final Connections connections;
  final CharacterImage image;

  Character({
    this.id,
    this.name,
    this.powerstats,
    this.biography,
    this.appearance,
    this.work,
    this.connections,
    this.image,
  });

  factory Character.fromMap(Map<String, dynamic> json) => Character(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    powerstats: json["powerstats"] == null ? null : Powerstats.fromMap(json["powerstats"]),
    biography: json["biography"] == null ? null : Biography.fromMap(json["biography"]),
    appearance: json["appearance"] == null ? null : Appearance.fromMap(json["appearance"]),
    work: json["work"] == null ? null : Work.fromMap(json["work"]),
    connections: json["connections"] == null ? null : Connections.fromMap(json["connections"]),
    image: json["image"] == null ? null : CharacterImage.fromMap(json["image"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "powerstats": powerstats == null ? null : powerstats.toMap(),
    "biography": biography == null ? null : biography.toMap(),
    "appearance": appearance == null ? null : appearance.toMap(),
    "work": work == null ? null : work.toMap(),
    "connections": connections == null ? null : connections.toMap(),
    "image": image == null ? null : image.toMap(),
  };
}

class Appearance {
  final String gender;
  final String race;
  final String height;
  final String weight;
  final String eyeColor;
  final String hairColor;

  Appearance({
    this.gender,
    this.race,
    this.height,
    this.weight,
    this.eyeColor,
    this.hairColor,
  });

  factory Appearance.fromMap(Map<String, dynamic> json) => Appearance(
    gender: json["gender"] == null ? null : json["gender"],
    race: json["race"] == null ? null : json["race"],
    height: json["height"] == null ? null : json["height"][json["height"].length > 0 ? json["height"].length - 1 : 0],
    weight: json["weight"] == null ? null : json["weight"][json["weight"].length > 0 ? json["weight"].length - 1 : 0],
    eyeColor: json["eye-color"] == null ? null : json["eye-color"],
    hairColor: json["hair-color"] == null ? null : json["hair-color"],
  );

  Map<String, dynamic> toMap() => {
    "gender": gender == null ? null : gender,
    "race": race == null ? null : race,
    "height": height == null ? null : height,
    "weight": weight == null ? null : weight,
    "eye-color": eyeColor == null ? null : eyeColor,
    "hair-color": hairColor == null ? null : hairColor,
  };
}

class Biography {
  final String fullName;
  final String alterEgos;
  final List<String> aliases;
  final String placeOfBirth;
  final String firstAppearance;
  final String publisher;
  final String alignment;

  Biography({
    this.fullName,
    this.alterEgos,
    this.aliases,
    this.placeOfBirth,
    this.firstAppearance,
    this.publisher,
    this.alignment,
  });

  factory Biography.fromMap(Map<String, dynamic> json) => Biography(
    fullName: json["full-name"] == null ? null : json["full-name"],
    alterEgos: json["alter-egos"] == null ? null : json["alter-egos"],
    aliases: json["aliases"] == null ? null : List<String>.from(json["aliases"].map((x) => x)),
    placeOfBirth: json["place-of-birth"] == null ? null : json["place-of-birth"],
    firstAppearance: json["first-appearance"] == null ? null : json["first-appearance"],
    publisher: json["publisher"] == null ? null : json["publisher"],
    alignment: json["alignment"] == null ? null : json["alignment"],
  );

  Map<String, dynamic> toMap() => {
    "full-name": fullName == null ? null : fullName,
    "alter-egos": alterEgos == null ? null : alterEgos,
    "aliases": aliases == null ? null : List<dynamic>.from(aliases.map((x) => x)),
    "place-of-birth": placeOfBirth == null ? null : placeOfBirth,
    "first-appearance": firstAppearance == null ? null : firstAppearance,
    "publisher": publisher == null ? null : publisher,
    "alignment": alignment == null ? null : alignment,
  };
}

class Connections {
  final List<String> groupAffiliation;
  final List<String> relatives;

  Connections({
    this.groupAffiliation,
    this.relatives,
  });

  factory Connections.fromMap(Map<String, dynamic> json) => Connections(
    groupAffiliation: json["group-affiliation"] == null ? null : json["group-affiliation"].split(RegExp(COMMA_SPLITTING_PATTERN)),
    relatives: json["relatives"] == null ? null : json["relatives"].split(RegExp(COMMA_SPLITTING_PATTERN)),
  );

  Map<String, dynamic> toMap() => {
    "group-affiliation": groupAffiliation == null ? null : groupAffiliation,
    "relatives": relatives == null ? null : relatives,
  };
}

class CharacterImage {
  final String url;

  CharacterImage({
    this.url,
  });

  factory CharacterImage.fromMap(Map<String, dynamic> json) => CharacterImage(
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toMap() => {
    "url": url == null ? null : url,
  };
}

class Powerstats {
  final String intelligence;
  final String strength;
  final String speed;
  final String durability;
  final String power;
  final String combat;

  Powerstats({
    this.intelligence,
    this.strength,
    this.speed,
    this.durability,
    this.power,
    this.combat,
  });

  factory Powerstats.fromMap(Map<String, dynamic> json) => Powerstats(
    intelligence: json["intelligence"] == null ? '' : json["intelligence"],
    strength: json["strength"] == null ? '' : json["strength"],
    speed: json["speed"] == null ? '' : json["speed"],
    durability: json["durability"] == null ? '' : json["durability"],
    power: json["power"] == null ? '' : json["power"],
    combat: json["combat"] == null ? '' : json["combat"],
  );

  Map<String, dynamic> toMap() => {
    "intelligence": intelligence == '' ? null : intelligence,
    "strength": strength == '' ? null : strength,
    "speed": speed == '' ? null : speed,
    "durability": durability == '' ? null : durability,
    "power": power == '' ? null : power,
    "combat": combat == '' ? null : combat,
  };

  get average {
    num _average, valsSum;
    int valsCount = 0;
    valsSum = 0;
    List fields = [this.combat, this.power, this.durability, this.speed, this.strength, this.intelligence];

    fields.forEach((element) {
      try {
        num value = num.parse(element);
        valsSum += value;
        valsCount++;
      } on TypeError {}
    });

    _average = valsSum > 0 ? (valsSum ~/ valsCount) as int : this.power;

    return _average;
  }
}

class Work {
  final String occupation;
  final String base;

  Work({
    this.occupation,
    this.base,
  });

  factory Work.fromMap(Map<String, dynamic> json) => Work(
    occupation: json["occupation"] == null ? null : json["occupation"],
    base: json["base"] == null ? null : json["base"],
  );

  Map<String, dynamic> toMap() => {
    "occupation": occupation == null ? null : occupation,
    "base": base == null ? null : base,
  };
}
