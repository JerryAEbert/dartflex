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
  
  bool get autoSize;
  set autoSize(bool value);
  
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
      _graphics = new Graphics()
      ..width = _width
      ..height = _height;
      
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
  // autoSize
  //---------------------------------
  
  bool _autoSize = true;
  
  bool get autoSize => _autoSize;
  
  set autoSize(bool value) {
    if (value != _autoSize) {
      _autoSize = value;
      
      dispatch(
        new FrameworkEvent('autoSizeChanged') 
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
      
      _updateControl(1);
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
      
      _updateControl(2);
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
      
      _updateControl(3);
      
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
      
      _updateControl(4);
      
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
  
  UpdateManager _later;
  
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
    _later = new UpdateManager();
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
    if (_children.indexOf(element) >= 0) {
      return;
    }
    
    if (_control == null) {
      if (prepend) {
        final List<UIWrapper> newList = new List<UIWrapper>();
        
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
        final List<Element> newElementList = new List<Element>();
        
        newElementList.add(element.control);
        newElementList.addAll(_owner._control.children);
        
        _owner._control.children.removeAll(_owner._control.children);
        
        _owner._control.children.addAll(newElementList); 
      } else {
        _control.append(element._control);
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
    
    _updateControl(5);
    
    dispatch(
      new FrameworkEvent(
          'controlChanged',
          relatedObject: element
      )
    );
    
    invalidateProperties();
  }
  
  void _updateControl(int type) {
    final String px = 'px';
    
    if (_control != null) {
      if (_elementId == null) {
        switch (type) {
          case 1 : _control.style.setProperty('left', '$_x$px', ''); break;
          case 2 : _control.style.setProperty('top', '$_y$px', ''); break;
          case 3 : _control.style.setProperty('width', '$_width$px', ''); break;
          case 4 : _control.style.setProperty('height', '$_height$px', ''); break;
          case 5 : 
            _control.style.cssText = 'left:$_x$px;top:$_y$px;width:$_width$px;height:$_height$px;';
            
            break;
        }
      } /*else {
        width = _control.clientWidth;
        height = _control.clientHeight;
      }*/
    }
  }
  
  void _wrapDOMTarget() {
    if (_elementId != null) {
      _control = query(_elementId);
      
      //_control.$dom_addEventListener('resize', _invalidateSize, true);
      //_control.document.$dom_addEventListener('resize', _invalidateSize, true);
      _control.document.window.$dom_addEventListener('resize', _invalidateSize, true);
      
      later > _updateSize;
    }
  }
  
  void _initialize() {
    if (!_isInitialized) {
      _isInitialized = true;
      
      _createChildren();
      
      invalidateProperties();
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
          
          if (
              !element.includeInLayout &&
              (element.control.style.position != 'absolute')
          ) {
            element.control.style.position = 'absolute';
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
  
  void _invalidateSize(Event event) {
    later > _updateSize;
  }
  
  void _updateSize() {
    width = _control.clientWidth;
    height = _control.clientHeight;
  }
  
  void _addAllPendingElements() {
    _eventDispatcher.removeEventListener(
        'controlChanged', 
        _addAllPendingElements
    );
    
    _addLaterElements.forEach(
        (element) => add(element)
    );
    
    _addLaterElements = new List<UIWrapper>();
  }
}
