library poortext.models.richtext;

part 'manipulate.dart';

abstract class Node {
  int get txtLength;
}

abstract class Element implements Node {
  List<Node> get allChildren;

  Node getNodeAtTxtOffset(final int aTxtOffset) {
    if (aTxtOffset < 0) {
      return null;
    }

    if (aTxtOffset >= txtLength) {
      return null;
    }

    int lRemOffset = aTxtOffset;

    for(Node cNode in allChildren) {
      if(lRemOffset > cNode.txtLength) {
        lRemOffset -= cNode.txtLength;
        continue;
      }

      if(cNode is Node) {
        return cNode;
      } else if(cNode is Element) {
        return cNode.getNodeAtTxtOffset(lRemOffset);
      } else {
        return null;
      }
    }

    return null;
  }
}

class TextProperties {
  TextProperties() {}

  TextProperties.Make(this.isBold, this.isItallic, this.isUnderlined);

  bool isBold = false;

  bool isItallic = false;

  bool isUnderlined = false;
}

/// Leaf nodes
class Span implements Node {
  Span.Make(this.text);

  String text = "Type something here...";

  final TextProperties textProp = new TextProperties();

  int get txtLength => text.length;
}

class ListProperties {}

class Paragraph extends Element {
  Paragraph.Make(this.spans);

  List<Span> spans = new List<Span>();

  int fontSize = 12;

  int get txtLength {
    int lRet = 0;

    for (final cSpan in spans) {
      lRet += cSpan.txtLength;
    }

    return lRet;
  }

  List<Node> get allChildren => spans.toList();
}

class Heading implements Node {
  Heading.Make(this.text);

  String text = "Heading";

  int get txtLength => text.length;
}

class Section extends Element {
  Section.Make(this.heading, this.paragraphs, this.sections);

  Heading heading;

  List<Paragraph> paragraphs = new List<Paragraph>();

  List<Section> sections = new List<Section>();

  int get txtLength {
    int lRet = heading.txtLength;

    for (final cPar in paragraphs) {
      lRet += cPar.txtLength;
    }

    for (final cSecs in sections) {
      lRet += cSecs.txtLength;
    }

    return lRet;
  }

  List<Node> get allChildren {
    List<Node> lRet = new List<Node>();

    lRet.add(heading);
    lRet.addAll(paragraphs);
    lRet.addAll(sections);

    return lRet;
  }
}

class Article extends Element {
  List<Section> sections = new List<Section>();

  int get txtLength {
    int lRet = 0;

    for (final cSecs in sections) {
      lRet += cSecs.txtLength;
    }

    return lRet;
  }

  List<Node> get allChildren => sections;
}
