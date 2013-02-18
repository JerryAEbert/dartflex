part of dartflex.components;

abstract class IUIWrapper implements IFrameworkEventDispatcher {
  
  Graphics _graphics;
  Graphics get graphics;
  
  bool get includeInLayout;
  set includeInLayout(bool value);
  
  bool get autoSize;
  set autoSize(bool value);
  
  bool get visible;
  set visible(bool value);
  
  int get x;
  set x(int value);
  
  int get y;
  set y(int value);
  
  int get width;
  set width(int value);
  
  double get percentWidth;
  set percentWidth(double value);
  
  int get height;
  set height(int value);
  
  double get percentHeight;
  set percentHeight(double value);
  
  int get paddingLeft;
  set paddingLeft(int value);
  
  int get paddingRight;
  set paddingRight(int value);
  
  int get paddingTop;
  set paddingTop(int value);
  
  int get paddingBottom;
  set paddingBottom(int value);
  
  ILayout get layout;
  set layout(ILayout value);
  
  UpdateManager get later;
  
  bool get isInitialized;
  
  IUIWrapper get owner;
  
  List<IUIWrapper> get children;
  
  String get elementId;
  
  Element get control;
  
  void invalidateProperties();
  void add(IUIWrapper element, {bool prepend: false});
  void remove(IUIWrapper element);
  void removeAll();
  
  void operator []=(String type, Function eventHandler) => addEventListener(type, eventHandler);
  
}

class UIWrapper implements IUIWrapper {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
  FrameworkEventDispatcher _eventDispatcher;
  bool _isLayoutUpdateRequired = false;
  
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
  // visible
  //---------------------------------
  
  bool _visible = true;
  
  bool get visible => _visible;
  
  set visible(bool value) {
    if (value != _visible) {
      _visible = value;
      
      dispatch(
        new FrameworkEvent('visibleChanged') 
      );
      
      _updateVisibility();
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
  
  List<IUIWrapper> _addLaterElements = new List<IUIWrapper>();
  
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
  
  IUIWrapper _owner;
  
  IUIWrapper get owner => _owner;
  
  //---------------------------------
  // children
  //---------------------------------
  
  List<IUIWrapper> _children = new List<IUIWrapper>();
  
  List<IUIWrapper> get children => _children;
  
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
  // IFrameworkEventDispatcher
  //
  //---------------------------------
  
  bool hasEventListener(String type, Function eventHandler) {
    return _eventDispatcher.hasEventListener(type, eventHandler);
  }
  
  void addEventListener(String type, Function eventHandler) {
    _eventDispatcher.addEventListener(type, eventHandler);
  }
  
  void removeEventListener(String type, Function eventHandler) {
    _eventDispatcher.removeEventListener(type, eventHandler);
  }
  
  void dispatch(FrameworkEvent event) {
    _eventDispatcher.dispatch(event);
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
  
  void add(IUIWrapper element, {bool prepend: false}) {
    if (_children.indexOf(element) >= 0) {
      return;
    }
    
    if (_control == null) {
      if (prepend) {
        final List<IUIWrapper> newList = new List<IUIWrapper>();
        
        newList.add(element);
        newList.addAll(_addLaterElements);
        
        _addLaterElements = newList;
      } else {
        _addLaterElements.add(element);
      }
      
      this['controlChanged'] = ((FrameworkEvent event) => _addAllPendingElements());
    } else {
      _children.addLast(element);
      
      (element as UIWrapper)._owner = this;
      (element as UIWrapper)._initialize();
      
      if (prepend) {
        final List<Element> newElementList = new List<Element>();
        
        newElementList.add(element.control);
        newElementList.addAll(_owner.control.children);
        
        _owner.control.children.removeAll(_owner.control.children);
        
        _owner.control.children.addAll(newElementList); 
      } else {
        _control.append(element.control);
      }
      
      invalidateProperties();
    }
  }
  
  void remove(IUIWrapper element) {
    _children.removeMatching((IUIWrapper child) => (child == element));
    _addLaterElements.removeMatching((IUIWrapper child) => (child == element));
    
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
    
    _updateVisibility();
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
          case 2 : _control.style.setProperty('top', '$_y$px', ''); break; //_control.style.cssText = _control.style.cssText.replaceFirst(new RegExp(' top: \\d+px;'), ' top: $_y$px;'); break;
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
        IUIWrapper element;
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
  
  void _updateVisibility() {
    if (_control != null) {
      _control.hidden = !_visible;
    } else {
      this['controlChanged'] = (
        (FrameworkEvent event) {
          _control.hidden = !_visible;
        }    
      );
    }
  }
  
  void _addAllPendingElements() {
    _eventDispatcher.removeEventListener(
        'controlChanged', 
        _addAllPendingElements
    );
    
    _addLaterElements.forEach(
        (element) => add(element)
    );
    
    _addLaterElements = new List<IUIWrapper>();
  }
}

