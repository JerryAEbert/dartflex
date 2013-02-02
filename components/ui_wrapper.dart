part of dartflex.components;

class UIWrapper extends FrameworkEventDispatcher implements IFrameworkEventDispatcher {
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  // width
  //---------------------------------
  
  int _width = 0;
  
  int get width => _width;
  
  set width(int value) {
    if (value != _width) {
      _width = value;
      
      dispatchEvent(
        new FrameworkEvent('widthChanged') 
      );
      
      later > _updateLayout;
    }
  }
  
  //---------------------------------
  // percentWidth
  //---------------------------------
  
  double _percentWidth = 0.0;
  
  double get percentWidth => _percentWidth;
  
  set percentWidth(double value) {
    if (value != _percentWidth) {
      _percentWidth = value;
      
      dispatchEvent(
        new FrameworkEvent('percentWidthChanged') 
      );
      
      later > _updateLayout;
    }
  }
  
  //---------------------------------
  // height
  //---------------------------------
  
  int _height = 0;
  
  int get height => _height;
  
  set height(int value) {
    if (value != _height) {
      _height = value;
      
      dispatchEvent(
        new FrameworkEvent('heightChanged')
      );
      
      later > _updateLayout;
    }
  }
  
  //---------------------------------
  // percentHeight
  //---------------------------------
  
  double _percentHeight = 0.0;
  
  double get percentHeight => _percentHeight;
  
  set percentHeight(double value) {
    if (value != _percentHeight) {
      _percentHeight = value;
      
      dispatchEvent(
        new FrameworkEvent('percentHeightChanged') 
      );
      
      later > _updateLayout;
    }
  }
  
  //---------------------------------
  // layout
  //---------------------------------
  
  ILayout _layout;
  
  ILayout get layout => _layout;
  
  //---------------------------------
  // addLaterElements
  //---------------------------------
  
  List<UIWrapper> addLaterElements = new List<UIWrapper>();
  
  //---------------------------------
  // later
  //---------------------------------
  
  UpdateManager _later = new UpdateManager();
  
  UpdateManager get later => _later;
  
  //---------------------------------
  // hasCreatedChildren
  //---------------------------------
  
  bool _hasCreatedChildren = false;
  
  bool get hasCreatedChildren => _hasCreatedChildren;
  
  //---------------------------------
  // owner
  //---------------------------------
  
  UIWrapper _owner;
  
  UIWrapper get owner => _owner;
  
  //---------------------------------
  // children
  //---------------------------------
  
  List<UIWrapper> _children = new List<UIWrapper>();
  
  List<UIWrapper> get children => _children;
  
  //---------------------------------
  // elementId
  //---------------------------------
  
  String _elementId;
  
  String get elementId => _elementId;
  
  //---------------------------------
  // control
  //---------------------------------
  
  Element _control;
  
  Element get control => _control;
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  UIWrapper({String elementId: null}) {
    _elementId = elementId;
    
    _createChildren();
  }
  
  //---------------------------------
  //
  // Public methods
  //
  //---------------------------------
  
  void add(UIWrapper element) {
    if (_control == null) {
      addLaterElements.add(element);
      
      later > _addAllPendingElements;
    } else {
      _children.addLast(element);
      
      element._owner = this;
      
      _control.children.add(element.control);
      
      later > _updateLayout;
    }
  }
  
  //---------------------------------
  //
  // Operator overloads
  //
  //---------------------------------
  
  void operator []=(String type, Function eventHandler) => addEventListener(type, eventHandler);
  
  //---------------------------------
  //
  // Protected methods
  //
  //---------------------------------
  
  void _createChildren() {
    _hasCreatedChildren = true;
    
    _initialize();
  }
  
  void _initialize() {
    if (_elementId != null) {
      _control = query(_elementId);
      
      later > _invalidateSize;
    }
  }
  
  void _updateLayout() {
    if (
      (_width > 0) &&
      (_height > 0) &&
      (_layout != null)
    ) {
      _layout.doLayout(
         _width,
         _height,
         _children    
      );
      
      _children.forEach(
          (element) => later > element._updateLayout
      );
    }
  }
  
  void _invalidateSize() {
    width = _control.clientWidth;
    height = _control.clientHeight;
    
    later > _invalidateSize;
  }
  
  void _addAllPendingElements() {
    addLaterElements.forEach(
        (element) => add(element)
    );
  }
}

