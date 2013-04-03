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

    _button['click'] = (FrameworkEvent event) => notify(
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

class ProductItemRenderer extends ItemRenderer {

  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------

  Image _icon;
  EditableText _label;

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

  ProductItemRenderer({String elementId: null}) : super(elementId: null, autoDrawBackground: false) {
    layout = new HorizontalLayout();
  }

  static ProductItemRenderer construct() {
    return new ProductItemRenderer();
  }

  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------

  void createChildren() {
    _label = new EditableText()
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..paddingBottom = 5
    ..paddingRight = 1
    ..text = (data != null) ? data['product'] : '';

    add(_label);
  }

  void invalidateData() {
    if (_label != null) {
      _label.text = (data != null) ? data['product'] : '';
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

class TagItemRenderer extends ItemRenderer {

  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------

  ComboBox _dropdown;

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

  TagItemRenderer({String elementId: null}) : super(elementId: null, autoDrawBackground: false) {
    layout = new HorizontalLayout();
  }

  static TagItemRenderer construct() {
    return new TagItemRenderer();
  }

  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------

  void createChildren() {
    ListCollection dataProvider = new ListCollection();
    
    dataProvider + 'dairy';
    dataProvider + 'sweets';
    dataProvider + 'fruits';
    dataProvider + 'veggies';
    dataProvider + 'bread';
    dataProvider + 'poultry';
    dataProvider + 'meat';
    dataProvider + 'fish';
    dataProvider + 'beverages';
    dataProvider + 'household';
    dataProvider + 'multimedia';
    dataProvider + 'press shop';
    dataProvider + 'liquors';
    dataProvider + 'cleaning';
    
    _dropdown = new ComboBox()
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..dataProvider = dataProvider
    ..selectedItem = data['tag'];

    add(_dropdown);
  }
  
  void invalidateData() {
    if (_dropdown != null) {
      _dropdown.selectedItem = (data != null) ? data['tag'] : '';
    }
  }
}

class PhoneItemRenderer extends ItemRenderer {

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
    _label = new RichText()
    ..percentWidth = 100.0
    ..paddingLeft = 3
    ..text = (data != null) ? data['phone'] : '';

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
    ..sheetWidth = 400
    ..sheetHeight = 14
    ..columnSize = 80
    ..rowSize = 14
    ..source = 'http://www.igindo.com/dart/m/rating.png';

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

class ToggleItemRenderer extends ItemRenderer {

  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------

  Toggle _toggle;

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

  ToggleItemRenderer({String elementId: null}) : super(elementId: null, autoDrawBackground: false) {
    layout = new HorizontalLayout();
  }

  static ToggleItemRenderer construct() {
    return new ToggleItemRenderer();
  }

  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------

  void createChildren() {
    _toggle = new Toggle()
    ..width = 80
    ..height = 30;

    add(_toggle);
  }

  void invalidateData() {
    if (
        (data != null) &&
        (_toggle != null)
    ) {
      //_toggle.index = data['rating'];
    }
  }
}