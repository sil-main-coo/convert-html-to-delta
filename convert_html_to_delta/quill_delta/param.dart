class QInsert{
  String insert;

  QInsert(this.insert);

  QInsert.fromJson(Map<String, dynamic> json) {
    insert = json['insert'];
  }

  Map<String, dynamic> toJson() {
    return {
      "\"insert\"":  "\""+ this.insert +"\"",
    };
  }
}

class QEmbed {
  PropertiesImage embed;

  QEmbed({this.embed});

  QEmbed.fromJson(Map<String, dynamic> json) {
    embed = json['embed'];
  }

  Map<String, dynamic> toJson() {
    return {
      "\"embed\"": this.embed.toJson(),
    };
  }

}

class QBold{
  bool b;

  QBold(){
   this.b= true;
  }

  Map<String, dynamic> toJson() {
    return {
      "\"b\"": this.b,
    };
  }
}

class QItalic{
  bool i;

  QItalic(){
    this.i= true;
  }

  Map<String, dynamic> toJson() {
    return {
      "\"i\"": this.i,
    };
  }
}

class QHeading{
  int heading;

  QHeading({this.heading});

  Map<String, dynamic> toJson() {
    return {
      "\"heading\"":  this.heading,
     };
  }
}

class QLinked{
  String a;

  QLinked({this.a});

  Map<String, dynamic> toJson() {
    return {
      "\"a\"":  "\""+ this.a + "\"",
    };
  }
}

class QBlock{
  String block;

  QBlock({this.block});

  Map<String, dynamic> toJson() {
    return {
      "\"block\"":  "\""+ this.block + "\"",
    };
  }
}

class PropertiesImage{
  String type, id, source;

  PropertiesImage({this.id, this.source}) : type= "image";

  Map<String, dynamic> toJson() {
    return {
      "\"type\"":  "\""+ this.type + "\"",
      "\"id\"":  "\""+ this.id + "\"",
      "\"source\"":  "\""+ this.source + "\"",
    };
  }
}