part of demo;

class DemoItemRenderer extends ItemRenderer {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
  Group _container;
  RichText _label;
  ComboBox _selection01;
  Image _image;
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  DemoItemRenderer({String elementId: null}) : super(elementId: null) {
  }
  
  static DemoItemRenderer construct() {
    return new DemoItemRenderer();
  }
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  ListCollection createDataProvider({int dpLen: 10, String labelMain, int modifier: 1, String suffix: ''}) {
    ListCollection dataProvider = new ListCollection();
    int value;
    int i;
    
    for (i=0; i<dpLen; i++) {
      value = i * modifier;
      
      dataProvider + '$labelMain $value $suffix';
    }
    
    return dataProvider;
  }
  
  void createChildren() {
    _container = new VGroup()
    ..percentWidth = 100.0
    ..percentHeight = 100.0;
    
    _label = new RichText()
    ..width = 120
    ..height = 18;
    
    _selection01 = new ComboBox()
    ..width = 120
    ..height = 22
    ..dataProvider = createDataProvider(dpLen: 100, labelMain: 'cost', modifier: 10, suffix: '\$');
    
    _image = new Image()
    ..width = 120
    ..height = 22
    ..source = 'http://www.androidguys.com/wp-content/uploads/2012/10/nexus4_hero_image_720.jpg';
    
    if (data != null) {
      _label.text = control_labelHandler(data);
    }
    
    _container.add(_label);
    _container.add(_selection01);
    _container.add(_image);
    
    _selection01['selectedIndexChanged'] = (
      (FrameworkEvent event) {
        if (data != null) {
          data.rating01 = event.relatedObject;
        }
      }
    );
    
    add(_container);
  }
  
  void invalidateData() {
    if (_label != null) {
      _label.text = control_labelHandler(data);
    }
    
    if (_selection01 != null) {
      _selection01.selectedIndex = (data != null) ? data.rating01 : -1;
    }
  }
  
  void updateLayout() {
  }
  
  //---------------------------------
  //
  // Protected methods
  //
  //---------------------------------
}

String control_labelHandler(Object item) {
  if (item != null) {
    return item.label;
  }
  
  return '';
}