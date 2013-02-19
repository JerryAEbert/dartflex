part of demo;

class HeaderItemRenderer extends ItemRenderer {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
  Button _button;
  
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
  
  HeaderItemRenderer({String elementId: null}) : super(elementId: null, autoDrawBackground: false) {
  }
  
  static HeaderItemRenderer construct() {
    return new HeaderItemRenderer();
  }
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  void createChildren() {
    _button = new Button()
    ..percentWidth = 100.0
    ..percentHeight = 100.0;
    
    if (data != null) {
      _button.label = data['label'];
    }
    
    _button['click'] = (FrameworkEvent event) => dispatch(
      new FrameworkEvent(
        'click',
        relatedObject: data
      )    
    );
    
    add(_button);
  }
  
  void invalidateData() {
    if (
       (_button != null) &&
       (data != null)
    ) {
      _button.label = data['label'];
    }
  }
}

class IdItemRenderer extends ItemRenderer {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
  RichText _label;
  
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
  
  IdItemRenderer({String elementId: null}) : super(elementId: null, autoDrawBackground: false) {
    layout = new HorizontalLayout();
  }
  
  static IdItemRenderer construct() {
    return new IdItemRenderer();
  }
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  void createChildren() {
    _label = new RichText()
    ..percentWidth = 100.0
    ..height = 18
    ..paddingLeft = 5
    ..text = (data != null) ? data['id'].toString() : '';
    
    add(_label);
  }
  
  void invalidateData() {
    if (_label != null) {
      _label.text = (data != null) ? data['id'].toString() : '';
    }
  }
}

class NameItemRenderer extends ItemRenderer {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
  Image _icon;
  RichText _label;
  
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
  
  NameItemRenderer({String elementId: null}) : super(elementId: null, autoDrawBackground: false) {
    layout = new HorizontalLayout();
  }
  
  static NameItemRenderer construct() {
    return new NameItemRenderer();
  }
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  void createChildren() {
    _icon = new Image()
    ..width = 28
    ..height = 28
    ..paddingLeft = 5
    ..source = 'http://www.igindo.com/dart/datagrid/user.png';
    
    _label = new RichText()
    ..percentWidth = 100.0
    ..height = 18
    ..paddingLeft = 5
    ..text = (data != null) ? data['fullname'] : '';
    
    add(_icon);
    add(_label);
  }
  
  void invalidateData() {
    if (_label != null) {
      _label.text = (data != null) ? data['fullname'] : '';
    }
  }
}

class ManagerItemRenderer extends ItemRenderer {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
  Image _icon;
  RichText _label;
  
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
  
  ManagerItemRenderer({String elementId: null}) : super(elementId: null, autoDrawBackground: false) {
    layout = new HorizontalLayout();
  }
  
  static ManagerItemRenderer construct() {
    return new ManagerItemRenderer();
  }
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  void createChildren() {
    _icon = new Image()
    ..width = 28
    ..height = 28
    ..paddingLeft = 5
    ..source = 'http://www.igindo.com/dart/datagrid/user.png';
    
    _label = new RichText()
    ..percentWidth = 100.0
    ..height = 18
    ..paddingLeft = 5
    ..text = (data != null) ? data['manager'] : '';
    
    add(_icon);
    add(_label);
  }
  
  void invalidateData() {
    if (_label != null) {
      _label.text = (data != null) ? data['manager'] : '';
    }
  }
}

class JobItemRenderer extends ItemRenderer {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
  Image _icon;
  RichText _label;
  
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
  
  JobItemRenderer({String elementId: null}) : super(elementId: null, autoDrawBackground: false) {
    layout = new HorizontalLayout();
  }
  
  static JobItemRenderer construct() {
    return new JobItemRenderer();
  }
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  void createChildren() {
    _icon = new Image()
    ..width = 28
    ..height = 28
    ..paddingLeft = 5
    ..source = 'http://www.igindo.com/dart/datagrid/Briefcase.png';
    
    _label = new RichText()
    ..percentWidth = 100.0
    ..height = 18
    ..paddingLeft = 5
    ..text = (data != null) ? data['job'] : '';
    
    add(_icon);
    add(_label);
  }
  
  void invalidateData() {
    if (_label != null) {
      _label.text = (data != null) ? data['job'] : '';
    }
  }
}

class PhoneItemRenderer extends ItemRenderer {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
  Image _icon;
  RichText _label;
  
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
  
  PhoneItemRenderer({String elementId: null}) : super(elementId: null, autoDrawBackground: false) {
    layout = new HorizontalLayout();
  }
  
  static PhoneItemRenderer construct() {
    return new PhoneItemRenderer();
  }
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  void createChildren() {
    _icon = new Image()
    ..width = 28
    ..height = 28
    ..paddingLeft = 5
    ..source = 'http://www.igindo.com/dart/datagrid/phone_icon.png';
    
    _label = new RichText()
    ..percentWidth = 100.0
    ..height = 18
    ..text = (data != null) ? data['phone'] : '';
    
    add(_icon);
    add(_label);
  }
  
  void invalidateData() {
    if (_label != null) {
      _label.text = (data != null) ? data['phone'] : '';
    }
  }
}

class ImageItemRenderer extends ItemRenderer {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
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
  
  ImageItemRenderer({String elementId: null}) : super(elementId: null, autoDrawBackground: false) {
    layout = new HorizontalLayout();
  }
  
  static ImageItemRenderer construct() {
    return new ImageItemRenderer();
  }
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  void createChildren() {
    _image = new Image()
    ..percentWidth = 100.0
    ..percentHeight = 100.0;
    
    if (data != null) {
      int imageNumber = data['imageNumber'];
      
      _image.source = 'http://www.igindo.com/orgchart/assets/rndImg/$imageNumber.jpg';
    }
    
    add(_image);
  }
  
  void invalidateData() {
    if (
        (_image != null) &&
        (data != null)
    ) {
      int imageNumber = data['imageNumber'];
      
      _image.source = 'http://www.igindo.com/orgchart/assets/rndImg/$imageNumber.jpg';
    }
  }
}

class RatingItemRenderer extends ItemRenderer {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
  SpriteSheet _spriteSheet;
  
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
  
  RatingItemRenderer({String elementId: null}) : super(elementId: null, autoDrawBackground: false) {
    layout = new HorizontalLayout();
  }
  
  static RatingItemRenderer construct() {
    return new RatingItemRenderer();
  }
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  void createChildren() {
    _spriteSheet = new SpriteSheet()
    ..sheetWidth = 700
    ..sheetHeight = 25
    ..columnSize = 140
    ..rowSize = 25
    ..source = 'http://www.igindo.com/dart/datagrid/rating.png';
    
    add(_spriteSheet);
  }
  
  void invalidateData() {
    if (
        (data != null) && 
        (_spriteSheet != null)
    ) {
      _spriteSheet.index = data['rating'];
    }
  }
}