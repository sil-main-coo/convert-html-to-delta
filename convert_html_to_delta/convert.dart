import 'package:largeer_v2/utils/custom_lib/convert_html_to_delta/quill_delta/define.dart';
import 'package:largeer_v2/utils/custom_lib/convert_html_to_delta/quill_delta/param.dart';

/**
 * code by @Hoang
 * 11/2019
 */


/// Reg used to split html tags. In the future, if data is changed, this function will be changed too

final  RegExp regExp = new RegExp(r'<*\/[0-9a-z]*>');
String _li_tag_type="";

///  return json delta
///  support tags: heading, p, ul, ol, img, em, strong, a
///  model's structure please see in `config/model`

String convertHtmlToJsonDelta(String html){
  var arr= html.split(regExp);

  //print(arr.toString());
  List<Map<String, dynamic>> data= new  List<Map<String, dynamic>>();
  for(var x in arr){
    // Heading chia content và attributes riêng
    if(x.isEmpty || x == ' ' || x==null){
      continue;
    }
    x= x.trimLeft();

    if(x.startsWith('<h')){
      data.add(_contentHeading(x));
      data.add(_headingAttributesTag(x));
    }else if(x.startsWith('<p>')){
      x= x.replaceAll("<p>", "");
      if(x.contains('<h')){
        data.add(_contentHeading(x));
        data.add(_headingAttributesTag(x));
      } else if(x.contains('<')){
        data.add(_basicTag(x));
        data.add(_endDelta()); // xuống dòng
      }
      else {
        data.add(_pTag(x));
        data.add(_endDelta()); // xuống dòng
      }
    }else if(x.startsWith('<ul>') || x.startsWith('<ol>') ){
      data.add(_ul_ol_content(x));
      data.add(_ul_ol_AttributesTag(x));
    }else if(x.startsWith('<li>')) {
      data.add(_li_content(x));
      data.add(_li_AttributesTag(x));
    } else if(x.startsWith('<img')){
      data.add(_imgTag(x));
      data.add(_endDelta()); // xuống dòng
    }  else if(x.startsWith('<div')){
      data.add(_divTag(x));
      data.add(_endDelta()); // xuống dòng
    } else if(x.startsWith('<')) {
      data.add(_basicTag(x));
    }
  }

  data.add(_endDelta()); // kết thúc cần insert : \n
  return data.toString();
}

Map<String, dynamic> _basicTag(String x) {
  if(x.startsWith('<em>'))
    return _italicTag(x);
  else if(x.startsWith('<strong>'))
    return _boldTag(x);
  else if(x.startsWith('<a'))
    return _aTag(x);
  else if(x.startsWith('<img'))
    return _imgTag(x);

  throw x + " not yet defined";
}

Map<String, dynamic> _endDelta(){
  PTag model = PTag("\\n");
  return model.toJson();
}

Map<String, dynamic> _pTag(String html){
  html= html.replaceAll('<p>', "");
  if(html==null)
    html= "";
  PTag model = PTag(html);
  return model.toJson();
}

Map<String, dynamic> _ul_ol_content(String html){
  html= html.replaceRange(0, 4, ""); // indext of <ul> || <ol>
  html= html.replaceAll("<li>", "");
  PTag model = PTag(html);
  return model.toJson();
}

Map<String, dynamic> _ul_ol_AttributesTag(String html){
  // content heading is a p tag
  BlockTag attributes;

  if(html.contains('<ul>')) {
    attributes = new BlockTag(attributes: new QBlock(block: "ul"));
    _li_tag_type= 'ul';
  }
  else if(html.contains('<ol>')) {
    attributes = new BlockTag(attributes: new QBlock(block: "ol"));
    _li_tag_type= 'ol';
  }
  else
    throw "This tag not yet defined";

  return attributes.toJson();
}

Map<String, dynamic> _li_content(String html){
  html= html.replaceAll("<li>", "");
  PTag model = PTag(html);
  return model.toJson();
}

Map<String, dynamic> _li_AttributesTag(String html){
  // content heading is a p tag
  BlockTag attributes;

  if(_li_tag_type.isNotEmpty) {
    attributes = new BlockTag(attributes: new QBlock(block: _li_tag_type));
  } else
    throw "This tag not yet defined";

  return attributes.toJson();
}

Map<String, dynamic> _contentHeading(String html){
  html= html.replaceRange(0, 4, ""); // indext of <h^>
  PTag model = PTag(html);
  return model.toJson();
}

Map<String, dynamic> _headingAttributesTag(String html){
  // content heading is a p tag

  HeadingTag attributes;

  if(html.contains('<h1>'))
    attributes= new HeadingTag(attributes: new QHeading(heading: 1));
  else if(html.contains('<h2>'))
    attributes= new HeadingTag(attributes: new QHeading(heading: 2));
  else if(html.contains('<h3>'))
    attributes= new HeadingTag(attributes: new QHeading(heading: 3));
  else
    throw "This heading tag not yet defined";

  return attributes.toJson();
}


Map<String, dynamic> _divTag(String x) {
  final arr = x.split('>');
  final htmlImg = arr[1];
  return _imgTag(htmlImg);
}

Map<String, dynamic> _imgTag(String html){
  // add id tag
  int startSrc= html.indexOf("http");
  int endSrc= html.indexOf("\"", startSrc+1);
  String id = "5d91d6dde118e";
  String src= html.substring(startSrc, endSrc);
  ImageTag model = ImageTag(attributes: new QEmbed(embed: new PropertiesImage(id: id, source: src)));
  return model.toJson();
}

Map<String, dynamic> _aTag(String html){
  int start= html.indexOf("http");
  int end= html.indexOf('\">');
  int startC= html.indexOf(">")+1;
  String url = html.substring(start, end);
  String content= html.substring(startC);
  ATag model = ATag(attributes: new QLinked(a: url), insert: content);
  return model.toJson();
}

Map<String, dynamic> _boldTag(String html){
  html= html.replaceAll('<strong>', "");
  BoldTag model = BoldTag(attributes: new QBold(), insert: html);
  return model.toJson();
}

Map<String, dynamic> _italicTag(String html){
  html= html.replaceAll('<em>', "");
  ItalicTag model = ItalicTag(attributes: new QItalic(), insert: html);
  return model.toJson();
}

