

import 'package:largeer_v2/utils/custom_lib/convert_html_to_delta/quill_delta/param.dart';

class PTag extends QInsert {
  PTag(String insert) : super(insert);

  PTag.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  Map<String, dynamic> toJson(){
    return super.toJson();
  }
}

class HeadingTag extends QInsert{
  QHeading attributes;

  HeadingTag({this.attributes}) : super('\\n');

  Map<String, dynamic> toJson(){
    return {
      "\"insert\"": "\""+this.insert+"\"",
      "\"attributes\"": this.attributes.toJson()
    };
  }
}

class BoldTag extends QInsert{
  QBold attributes;

  BoldTag({this.attributes,String insert}) : super(insert);

  Map<String, dynamic> toJson(){
    return {
      "\"insert\"": "\""+this.insert+"\"",
      "\"attributes\"": this.attributes.toJson()
    };
  }
}

class ItalicTag extends QInsert{
  QItalic attributes;

  ItalicTag({this.attributes,String insert}) : super(insert);

  Map<String, dynamic> toJson(){
    return {
    "\"insert\"": "\""+this.insert+"\"",
    "\"attributes\"": this.attributes.toJson()
   };
  }
}

class ATag extends QInsert{
  QLinked attributes;

  ATag({this.attributes, String insert}) : super(insert);

  Map<String, dynamic> toJson(){
    return {
      "\"insert\"": "\""+this.insert+"\"",
      "\"attributes\"": this.attributes.toJson()
    };
  }
}

class BlockTag extends QInsert{
  QBlock attributes;

  BlockTag({this.attributes}) : super("\\n");

  Map<String, dynamic> toJson(){
    return {
      "\"insert\"": "\""+this.insert+"\"",
      "\"attributes\"": this.attributes.toJson()
    };
  }
}

class ImageTag extends QInsert{
  QEmbed attributes;

  ImageTag({this.attributes}) : super("\u200b"); // kí tự trống trong img

  Map<String, dynamic> toJson(){
    return {
      "\"insert\"": "\""+this.insert+"\"",
      "\"attributes\"": this.attributes.toJson()
    };
  }
}