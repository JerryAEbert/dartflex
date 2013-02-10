part of dartflex.components;

abstract class IUIWrapper implements IFrameworkEventDispatcher {
  
  UIWrapper get owner;
  Element get control;
  Graphics get graphics;
  
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
        _owner._isLayoutUpdateRequired = true;
        
        later > _owner._commitProperties;
      }
      
      later > _commitProperties;
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
      _isLayoutUpdateRequired = true;
      
      dispatch(
        new FrameworkEvent('widthChanged') 
      );
      
      later > _commitProperties;
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
      _isLayoutUpdateRequired = true;
      
      dispatch(
        new FrameworkEvent('percentWidthChanged') 
      );
      
      later > _commitProperties;
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
      _isLayoutUpdateRequired = true;
      
      dispatch(
        new FrameworkEvent('heightChanged')
      );
      
      later > _commitProperties;
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
      _isLayoutUpdateRequired = true;
      
      dispatch(
        new FrameworkEvent('percentHeightChanged') 
      );
      
      later > _commitProperties;
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
      _isLayoutUpdateRequired = true;
      
      dispatch(
        new FrameworkEvent('paddingLeftChanged') 
      );
      
      later > _commitProperties;
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
      _isLayoutUpdateRequired = true;
      
      dispatch(
        new FrameworkEvent('paddingRightChanged') 
      );
      
      later > _commitProperties;
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
      _isLayoutUpdateRequired = true;
      
      dispatch(
        new FrameworkEvent('paddingTopChanged') 
      );
      
      later > _commitProperties;
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
      _isLayoutUpdateRequired = true;
      
      dispatch(
        new FrameworkEvent('paddingBottomChanged') 
      );
      
      later > _commitProperties;
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
    _isLayoutUpdateRequired = true;
    
    later > _commitProperties;
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
          
          if (element.includeInLayout) {
            element._control.style.width = _control.style.width;
            element._control.style.height = _control.style.height;
          } else {
            element._control.style.position = 'absolute';
          }
          
          element._control.style.left = _control.style.left;
          element._control.style.top = _control.style.top;
          
          element._width = _width;
          element._height = _height;
          
          element.invalidateProperties();
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

