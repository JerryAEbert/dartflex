import 'dart:html';
import 'dart:math';
import 'dart:uri';
import 'package:dartflex/animation/animation.dart';
import 'package:dartflex/collections/collections.dart';
import 'package:dartflex/components/components.dart';
import 'package:dartflex/core/core.dart';
import 'package:dartflex/events/events.dart';
import 'package:dartflex/layout/layout.dart';
import 'package:demo/demo.dart';

void main() {
  initContainer01();
  initContainer02();
  
  /*
  
  label.graphics.context.beginPath();
  
  label.graphics.context.fillStyle = '#ff9900';
  
  label.graphics.context.moveTo(0, 0);
  label.graphics.context.lineTo(50, 0);
  label.graphics.context.lineTo(50, 50);
  label.graphics.context.lineTo(0, 50);
  label.graphics.context.lineTo(0, 0);
  
  label.graphics.context.fill();
  
  label.graphics.context.closePath();*/
  
  //DivElement aaa; aaa.style.overflowWrap
}

void initContainer01() {
  VGroup divContainer = new VGroup(elementId: '#container01')
  ..percentWidth = 100.0
  ..percentHeight = 100.0;
  
  ComboBox box = new ComboBox()
  ..labelFunction = control_labelHandler
  ..width = 120
  ..height = 22
  ..dataProvider = createDataProvider();
  
  Button button = new Button()
  ..width = 100
  ..height = 22
  ..label = 'add item';
  
  button['click'] = (
      (FrameworkEvent event) {
        // on button click, add a new item directly to the dataProvider
        // the comboBox will auto-update
        ListItem item = createListItem(label: 'I\'m a new option! ', index: box.dataProvider.length);
        
        box.dataProvider + item;
        
        // alternatively, you could just type
        // box + item;
        // as well
      }
  );
  
  divContainer.add(button);
  divContainer.add(box);
}

void initContainerX() {
  VGroup container = new VGroup(elementId: '#container01')
    ..percentWidth = 100.0
    ..percentHeight = 100.0;
  
  HGroup topContainer = new HGroup()
    ..percentWidth = 100.0
    ..percentHeight = 100.0;
  HGroup middleContainer = new HGroup()
    ..percentWidth = 100.0
    ..height = 100;
  HGroup bottomContainer = new HGroup()
    ..percentWidth = 100.0
    ..height = 50;
  
  RichText label = new RichText()
    ..text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut justo ligula, suscipit id venenatis eu, dictum eu augue. Vestibulum et nibh arcu. Nullam gravida risus ac ipsum congue nec ullamcorper lorem iaculis. Vestibulum tellus sapien, interdum ut mollis eget, consequat a elit. Vestibulum eu libero ac leo aliquet blandit. Suspendisse eget erat vitae risus mattis bibendum. Integer diam nibh, egestas nec commodo quis, rutrum ut lacus. Duis pellentesque metus sit amet mauris facilisis sed aliquet sem ultrices. Suspendisse eget nisi nulla. Praesent rutrum, lorem at malesuada fringilla, est mi malesuada dui, eleifend cursus velit augue sed dolor. Nunc viverra risus a elit rutrum feugiat.'
    ..width = 100
    ..percentHeight = 100.0;
  Button button = new Button()
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..label = 'click me';
  ComboBox boxA = new ComboBox()
    ..labelFunction = control_labelHandler
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..dataProvider = createDataProvider();
  ComboBox boxB = new ComboBox()
    ..labelFunction = control_labelHandler
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..dataProvider = createDataProvider();
  ComboBox boxC = new ComboBox()
    ..labelFunction = control_labelHandler
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..dataProvider = createDataProvider();
  ComboBox boxD = new ComboBox()
    ..labelFunction = control_labelHandler
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..dataProvider = createDataProvider();
  ComboBox boxE = new ComboBox()
    ..labelFunction = control_labelHandler
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..dataProvider = createDataProvider();
  ComboBox boxF = new ComboBox()
    ..labelFunction = control_labelHandler
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..dataProvider = createDataProvider();
  
  ListRenderer listRenderer = new ListRenderer()
    //..itemRendererFactory = new ClassFactory('dartflex.components', 'ItemRenderer')
    ..itemRendererFactory = new ClassFactory(constructorMethod: DemoItemRenderer.construct)
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..colPercentWidth = 100.0
    ..rowHeight = 30
    ..dataProvider = createDataProvider(dpLen: 100000)
    ..labelFunction = control_labelHandler;
  
  boxA['selectedItemChanged'] = ((FrameworkEvent event) => label.text = control_labelHandler(event.relatedObject));
  
  container.add(topContainer);
  container.add(middleContainer);
  container.add(bottomContainer);
  
  topContainer.add(boxA);
  topContainer.add(boxB);
  topContainer.add(button);
  
  bottomContainer.add(boxC);
  bottomContainer.add(label);
  bottomContainer.add(boxD);
  
  middleContainer.add(boxE);
  middleContainer.add(listRenderer);
  middleContainer.add(boxF);
}

ListRenderer _listRenderer;
RichText _innerHtmlDisplay;

void initContainer02() {
  _listRenderer = new ListRenderer(orientation: 'horizontal')
  //..itemRendererFactory = new ClassFactory('dartflex.components', 'ItemRenderer')
  ..itemRendererFactory = new ClassFactory(constructorMethod: DemoItemRenderer.construct)
  ..width = 400
  ..percentHeight = 100.0
  ..colWidth = 160
  ..dataProvider = createDataProvider(dpLen: 5000, labelMain: 'Employee nr.');
  
  _innerHtmlDisplay = new RichText()
  ..percentWidth = 100.0
  ..percentHeight = 100.0;
  
  HGroup container01 = new HGroup(elementId: '#container02')
  ..percentWidth = 100.0
  ..percentHeight = 100.0
  ..add(_listRenderer)
  ..add(_innerHtmlDisplay);
}

ListItem createListItem({String label: 'Option:', int index: -1}) {
  ListItem item = new ListItem('$label $index');
  
  return item;
}

ListCollection createDataProvider({int dpLen: 10, String labelMain: 'Option:'}) {
  ListCollection dataProvider = new ListCollection();
  int i;
  
  for (i=0; i<dpLen; i++) {
    dataProvider + createListItem(label: labelMain, index: i);
  }
  
  return dataProvider;
}

String control_labelHandler(ListItem item) {
  return item.label;
}

String getLoremIpsum() {
  return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consectetur sem vitae nibh vulputate a tempus neque feugiat. Nam pellentesque diam nec nunc eleifend ornare. In sapien nisl, luctus in laoreet at, laoreet in mauris. Nullam tempor leo a felis fringilla ut scelerisque mi mollis. In eu commodo arcu. Sed nec tincidunt lectus. Morbi consectetur laoreet tellus, nec aliquet felis congue a. Integer in sem sit amet nisl bibendum rhoncus. Praesent eget libero urna. Mauris et sodales sem. Curabitur vel nisi vel sapien interdum euismod. Integer malesuada, purus nec viverra dapibus, diam ligula scelerisque risus, in dictum nisl neque non diam. Fusce posuere urna a lectus aliquam malesuada.';
}

abstract class Entity {}

class ListItem implements Entity {
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  ListItem(String label) {
    Random rnd = new Random();
    
    _label = label;
    
    rating01 = rnd.nextInt(10);
    rating02 = rnd.nextInt(10);
  }
  
  int rating01;
  int rating02;
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  String _label;
  
  String get label => _label;
  set label(String value) => _label = value;
}
