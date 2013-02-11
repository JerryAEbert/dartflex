part of dartflex.components;

abstract class IUIWrapper implements IFrameworkEventDispatcher {
  
  UIWrapper get owner;
  Element get control;
  Graphics get graphics;
  
  int get x;
  set x(int value);
  
  int get y;
  set y(int value);
  
  bool get includeInLayout;
  set includeInLayout(bool value);
  
}

class UIWrapper implements IUIWrapper {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
  FrameworkEventDispatcher _eventDispatcher;
  bool _isLayoutUpdateRequired = false;
  
  Function get addEventListener => _eventDispatcher.addEventListener;
  Function get removeEventListener => _eventDispatcher.removeEventListener;
  Function get dispatch => _eventDispatcher.dispatch;
  
  //---------------------------------
  // graphics
  //---------------------------------
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  // graphics
  //---------------------------------
  
  Graphics _graphics;
  
  Graphics get graphics {
    if (_graphics == null) {
      _graphics = new Graphics();
      
      add(_graphics, prepend: true);
    }
    
    return _graphics;
  }
  
  //---------------------------------
  // includeInLayout
  //---------------------------------
  
  bool _includeInLayout = true;
  
  bool get includeInLayout => _includeInLayout;
  
  set includeInLayout(bool value) {
    if (value != _includeInLayout) {
      _includeInLayout = value;
      
      dispatch(
        new FrameworkEvent('includeInLayoutChanged') 
      );
      
      if (_owner != null) {
        _owner.invalidateProperties();
      }
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // x
  //---------------------------------
  
  int _x = 0;
  
  int get x => _x;
  
  set x(int value) {
    if (value != _x) {
      _x = value;
      
      dispatch(
        new FrameworkEvent('xChanged') 
      );
      
      _updateControl();
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // y
  //---------------------------------
  
  int _y = 0;
  
  int get y => _y;
  
  set y(int value) {
    if (value != _y) {
      _y = value;
      
      dispatch(
        new FrameworkEvent('yChanged') 
      );
      
      _updateControl();
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // width
  //---------------------------------
  
  int _width = 0;
  
  int get width => _width;
  
  set width(int value) {
    if (value != _width) {
      _width = value;
      
      dispatch(
        new FrameworkEvent('widthChanged') 
      );
      
      _updateControl();
      
      invalidateProperties();
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
      
      dispatch(
        new FrameworkEvent('percentWidthChanged') 
      );
      
      invalidateProperties();
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
      
      dispatch(
        new FrameworkEvent('heightChanged')
      );
      
      _updateControl();
      
      invalidateProperties();
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
      
      dispatch(
        new FrameworkEvent('percentHeightChanged') 
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // paddingLeft
  //---------------------------------
  
  int _paddingLeft = 0;
  
  int get paddingLeft => _paddingLeft;
  
  set paddingLeft(int value) {
    if (value != _paddingLeft) {
      _paddingLeft = value;
      
      dispatch(
        new FrameworkEvent('paddingLeftChanged') 
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // paddingRight
  //---------------------------------
  
  int _paddingRight = 0;
  
  int get paddingRight => _paddingRight;
  
  set paddingRight(int value) {
    if (value != _paddingRight) {
      _paddingRight = value;
      
      dispatch(
        new FrameworkEvent('paddingRightChanged') 
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // paddingTop
  //---------------------------------
  
  int _paddingTop = 0;
  
  int get paddingTop => _paddingTop;
  
  set paddingTop(int value) {
    if (value != _paddingTop) {
      _paddingTop = value;
      
      dispatch(
        new FrameworkEvent('paddingTopChanged') 
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // paddingBottom
  //---------------------------------
  
  int _paddingBottom = 0;
  
  int get paddingBottom => _paddingBottom;
  
  set paddingBottom(int value) {
    if (value != _paddingBottom) {
      _paddingBottom = value;
      
      dispatch(
        new FrameworkEvent('paddingBottomChanged') 
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // layout
  //---------------------------------
  
  ILayout _layout;
  
  ILayout get layout => _layout;
  set layout(ILayout value) {
    if (value != _layout) {
      _layout = value;
      
      dispatch(
        new FrameworkEvent('layoutChanged') 
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // addLaterElements
  //---------------------------------
  
  List<UIWrapper> _addLaterElements = new List<UIWrapper>();
  
  //---------------------------------
  // later
  //---------------------------------
  
  UpdateManager _later = new UpdateManager();
  
  UpdateManager get later => _later;
  
  //---------------------------------
  // isInitialized
  //---------------------------------
  
  bool _isInitialized = false;
  
  bool get isInitialized => _isInitialized;
  
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
    _eventDispatcher = new FrameworkEventDispatcher(dispatcher: this);
    
    _elementId = elementId;
    
    _wrapDOMTarget();
  }
  
  //---------------------------------
  //
  // Operator overloads
  //
  //---------------------------------
  
  void operator []=(String type, Function eventHandler) => addEventListener(type, eventHandler);
  
  //---------------------------------
  //
  // Public methods
  //
  //---------------------------------
  
  void invalidateProperties() {
    if (!_isLayoutUpdateRequired) {
      _isLayoutUpdateRequired = true;
      
      later > _commitProperties;
    }
  }
  
  void add(UIWrapper element, {bool prepend: false}) {
    if (_control == null) {
      if (prepend) {
        List<UIWrapper> newList = new List<UIWrapper>();
        
        newList.add(element);
        newList.addAll(_addLaterElements);
        
        _addLaterElements = newList;
      } else {
        _addLaterElements.add(element);
      }
      
      this['controlChanged'] = ((FrameworkEvent event) => _addAllPendingElements());
    } else {
      _children.addLast(element);
      
      element._owner = this;
      element._initialize();
      
      if (prepend) {
        List<Element> newList = new List<Element>();
        
        newList.add(element.control);
        newList.addAll(_owner._control.children);
        
        _owner._control.children.removeAll(_owner._control.children);
        
        _owner._control.children.addAll(newList); 
      } else {
        _control.children.add(element.control); 
      }
      
      invalidateProperties();
    }
  }
  
  void remove(UIWrapper element) {
    _children.removeMatching((UIWrapper child) => (child == element));
    _addLaterElements.removeMatching((UIWrapper child) => (child == element));
    
    element.removeAll();
  }
  
  void removeAll() {
    while (_children.length > 0) {
      remove(_children.last);
    }
    
    if (_control != null) {
      while (_control.children.length > 0) {
        _control.children.removeLast();
      }
    }
  }
  
  //---------------------------------
  //
  // Protected methods
  //
  //---------------------------------
  
  void _setControl(Element element) {
    _control = element;
    
    dispatch(
      new FrameworkEvent(
          'controlChanged',
          relatedObject: element
      )
    );
    
    later > _commitProperties;
  }
  
  void _updateControl() {
    if (_control != null) {
      if (_elementId == null) {
        _control.style.left = _x.toString().concat('px');
        _control.style.top = _y.toString().concat('px');
        _control.style.width = _width.toString().concat('px');
        _control.style.height = _height.toString().concat('px');
      } else {
        width = _control.clientWidth;
        height = _control.clientHeight;
      }
    }
  }
  
  void _wrapDOMTarget() {
    if (_elementId != null) {
      _control = query(_elementId);
      
      later > _invalidateSize;
    }
  }
  
  void _initialize() {
    if (!_isInitialized) {
      _isInitialized = true;
      
      _createChildren();
      
      later > _commitProperties;
    }
  }
  
  void _createChildren() {
  }
  
  void _commitProperties() {
    if (_isLayoutUpdateRequired) {
      _isLayoutUpdateRequired = false;
      
      _updateLayout();
    }
  }
  
  void _updateLayout() {
    if (_graphics != null) {
      _graphics.width = _width;
      _graphics.height = _height;
    }
    
    if (
      (_width > 0) &&
      (_height > 0)
    ) {
      if (_layout != null) {
        _layout.doLayout(
           _width,
           _height,
           _getPageItemSize(),
           _getPageOffset(),
           _getPageSize(),
           _children    
        );
      } else {
        UIWrapper element;
        int i = _children.length;
        
        while (i > 0) {
          element = _children[--i];
          
          if (!element.includeInLayout) {
            element._control.style.position = 'absolute';
          }
          
          element.x = _x;
          element.y = _y;
          element.width = _width;
          element.height = _height;
        }
      }
    }
  }
  
  int _getPageItemSize() => 0;
  int _getPageOffset() => 0;
  int _getPageSize() => 0;
  
  void _invalidateSize() {
    width = _control.clientWidth;
    height = _control.clientHeight;
    
    if (_owner == null) {
      later > _invalidateSize;
    }
  }
  
  void _addAllPendingElements() {
    _addLaterElements.forEach(
        (element) => add(element)
    );
    
    _addLaterElements = new List<UIWrapper>();
  }
}

