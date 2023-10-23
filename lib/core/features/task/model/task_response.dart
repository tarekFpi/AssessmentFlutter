class TaskResponse {
  TaskResponse({
      this.id, 
      this.name, 
      this.alternateNames, 
      this.species, 
      this.gender, 
      this.house, 
      this.dateOfBirth, 
      this.yearOfBirth, 
      this.wizard, 
      this.ancestry, 
      this.eyeColour, 
      this.hairColour, 
      this.wand, 
      this.patronus, 
      this.hogwartsStudent, 
      this.hogwartsStaff, 
      this.actor, 
      this.alternateActors, 
      this.alive, 
      this.image,});

  TaskResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    alternateNames = json['alternate_names'] != null ? json['alternate_names'].cast<String>() : [];
    species = json['species'];
    gender = json['gender'];
    house = json['house'];
    dateOfBirth = json['dateOfBirth'];
    yearOfBirth = json['yearOfBirth'];
    wizard = json['wizard'];
    ancestry = json['ancestry'];
    eyeColour = json['eyeColour'];
    hairColour = json['hairColour'];
    wand = json['wand'] != null ? Wand.fromJson(json['wand']) : null;
    patronus = json['patronus'];
    hogwartsStudent = json['hogwartsStudent'];
    hogwartsStaff = json['hogwartsStaff'];
    actor = json['actor'];
    if (json['alternate_actors'] != null) {
      alternateActors = [];
      json['alternate_actors'].forEach((v) {
       // alternateActors?.add(dynamic.fromJson(v));
      });
    }
    alive = json['alive'];
    image = json['image'];
  }
  String? id;
  String? name;
  List<String>? alternateNames;
  String? species;
  String? gender;
  String? house;
  String? dateOfBirth;
  dynamic? yearOfBirth;
  bool? wizard;
  String? ancestry;
  String? eyeColour;
  String? hairColour;
  Wand? wand;
  String? patronus;
  bool? hogwartsStudent;
  bool? hogwartsStaff;
  String? actor;
  List<dynamic>? alternateActors;
  bool? alive;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['alternate_names'] = alternateNames;
    map['species'] = species;
    map['gender'] = gender;
    map['house'] = house;
    map['dateOfBirth'] = dateOfBirth;
    map['yearOfBirth'] = yearOfBirth;
    map['wizard'] = wizard;
    map['ancestry'] = ancestry;
    map['eyeColour'] = eyeColour;
    map['hairColour'] = hairColour;
    if (wand != null) {
      map['wand'] = wand?.toJson();
    }
    map['patronus'] = patronus;
    map['hogwartsStudent'] = hogwartsStudent;
    map['hogwartsStaff'] = hogwartsStaff;
    map['actor'] = actor;
    if (alternateActors != null) {
      map['alternate_actors'] = alternateActors?.map((v) => v.toJson()).toList();
    }
    map['alive'] = alive;
    map['image'] = image;
    return map;
  }

}

class Wand {
  Wand({
      this.wood, 
      this.core, 
      this.length,});

  Wand.fromJson(dynamic json) {
    wood = json['wood'];
    core = json['core'];
    length = json['length'] == null ? 0 : json['length'];
  }
  String? wood;
  String? core;
  dynamic? length;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['wood'] = wood;
    map['core'] = core;
    map['length']  = length;
    return map;
  }

}