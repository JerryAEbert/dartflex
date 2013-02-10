part of demo;

class DemoItemRenderer extends ItemRenderer {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
  HGroup _container;
  RichText _label;
  ComboBox _selection01;
  ComboBox _selection02;
  
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
    _container = new HGroup()
    ..percentWidth = 100.0
    ..percentHeight = 100.0;
    
    _label = new RichText()
    ..width = 120
    ..height = 18;
    
    _selection01 = new ComboBox()
    ..width = 120
    ..height = 22
    ..dataProvider = createDataProvider(dpLen: 100, labelMain: 'cost', modifier: 10, suffix: '\$');
    
    _selection02 = new ComboBox()
    ..width = 120
    ..height = 22
    ..dataProvider = createDataProvider(dpLen: 10, labelMain: 'rating');
    
    if (data != null) {
      _label.text = control_labelHandler(data);
    }
    
    _container.add(_label);
    _container.add(_selection01);
    _container.add(_selection02);
    
    _selection01['selectedIndexChanged'] = (
      (FrameworkEvent event) {
        if (data != null) {
          data.rating01 = event.relatedObject;
        }
      }
    );
    
    _selection02['selectedIndexChanged'] = (
        (FrameworkEvent event) {
          if (data != null) {
            data.rating02 = event.relatedObject;
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
    
    if (_selection02 != null) {
      _selection02.selectedIndex = (data != null) ? data.rating02 : -1;
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