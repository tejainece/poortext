// Copyright (c) 2016, Ravi Teja Gudapati. All rights reserved.

import 'package:angular2/core.dart';
import 'package:angular2/angular2.dart';
import 'dart:html' as dom;

import 'package:poortext/models/richtext/richtext.dart' as rtxt;

@Component(
    selector: 'my-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: const [NgFor])
class AppComponent implements AfterViewInit {
  @ViewChild("editor")
  ElementRef editorRef;

  dom.DivElement get editorDiv => editorRef.nativeElement;

  ngAfterViewInit() {
    {
      final bHeading = new rtxt.Heading.Make("Section1");
      final bParagraphs = <rtxt.Paragraph>[
        new rtxt.Paragraph.Make(
            [new rtxt.Span.Make("How are you?"), new rtxt.Span.Make(" Fine!"),])
      ];
      final bSec = new rtxt.Section.Make(bHeading, bParagraphs, null);

      rt.sections.add(bSec);
    }
  }

  rtxt.Article rt = new rtxt.Article();

  edKeyPressed(dom.KeyboardEvent aArg) {
    aArg.preventDefault();

    aArg.stopPropagation();
    aArg.stopImmediatePropagation();

    /*
    if (dom.document.activeElement != editorDiv) {
      //TODO could be child, check if the activeElement is child
      return;
    }
    */

    dom.Selection lSelection = dom.window.getSelection();
    if (lSelection == null) {
      return;
    }

    for(int cIdx = 0; cIdx < lSelection.rangeCount; cIdx++) {
      dom.Range lRange = lSelection.getRangeAt(0);
      print('${lRange.startOffset} ${lRange.endOffset}');
    }
  }

  render() {
    List<dom.Element> lElements = new List<dom.Element>();

    for(final cSec in rt.sections) {
      lElements.add();
    }
  }
}

class Span {
  dom.SpanElement _el = new dom.SpanElement();

  dom.SpanElement get el => _el;

  rtxt.Span _data = new rtxt.Span.Make("");

  bool _isDirty = true;

  bool get isDirty => _isDirty;

  rtxt.Span get data => data;

  void setText(String aNewTxt) {
    _data.text = aNewTxt;
    _isDirty = true;
  }

  void render() {
    _el.text = _data.text;
    _isDirty = false;
  }
}

class Paragraph {
  dom.DivElement _el = new dom.DivElement();

  rtxt.Paragraph _data = new rtxt.Paragraph.Make([]);

  bool _isDirty = true;

  bool get isDirty => _isDirty;

  void insertText(String aNewTxt) {
    //TODO
    _isDirty = true;
  }

  void render() {
    //TODO
    _isDirty = false;
  }
}

class Article extends rtxt.Article {
  Article(this._renderPt);

  rtxt.Paragraph _data = new rtxt.Paragraph.Make([]);

  dom.DivElement _renderPt;

  bool _isDirty = true;

  bool get isDirty => _isDirty;

  void insertText(String aNewTxt) {
    //TODO
    _isDirty = true;
  }

  void render() {
    //TODO
    _isDirty = false;
  }
}
