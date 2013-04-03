part of dartflex;

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
  
  bool get inheritsDefaultCSS;
  set inheritsDefaultCSS(bool value);

  ILayout get layout;
  set layout(ILayout value);

  UpdateManager get later;

  bool get isInitialized;

  IUIWrapper get owner;

  List<IUIWrapper> get children;

  String get elementId;
  
  String get className;

  Element get control;
  
  void preInitialize(IUIWrapper forOwner);
  void invalidateProperties();
  void add(IUIWrapper element, {bool prepend: false});
  void remove(IUIWrapper element);
  void removeAll();

  void operator []=(String type, Function eventHandler) => observe(type, eventHandler);

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
  // reflowManager
  //---------------------------------

  ReflowManager _reflowManager;

  ReflowManager get reflowManager => _reflowManager;

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
  // classes
  //---------------------------------

  Collection<String> _classes;
  bool _isClassesChanged = false;

  Collection<String> get classes => _classes;

  set classes(Collection<String> value) {
    if (value != _classes) {
      _classes = value;

      notify(
        new FrameworkEvent('classesChanged')
      );

      invalidateProperties();
    }
  }

  //---------------------------------
  // includeInLayout
  //---------------------------------

  bool _includeInLayout = true;

  bool get includeInLayout => _includeInLayout;

  set includeInLayout(bool value) {
    if (value != _includeInLayout) {
      _includeInLayout = value;

      notify(
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

      notify(
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

      notify(
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

      notify(
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

      notify(
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

      notify(
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

      notify(
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

      notify(
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

      notify(
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

      notify(
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

      notify(
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

      notify(
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

      notify(
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

      notify(
        new FrameworkEvent('layoutChanged')
      );

      invalidateProperties();
    }
  }
  
  //---------------------------------
  // inheritsDefaultCSS
  //---------------------------------

  bool _inheritsDefaultCSS = true;

  bool get inheritsDefaultCSS => _inheritsDefaultCSS;
  set inheritsDefaultCSS(bool value) {
    if (value != _inheritsDefaultCSS) {
      _inheritsDefaultCSS = value;
      
      if (_isInitialized) {
        if (value) {
          _reflowManager.postRendering.whenComplete(
            () => _control.classes.add('_' + _className)
          );
        } else {
          _reflowManager.postRendering.whenComplete(
              () => _control.classes.remove('_' + _className)
          );
        }
      }

      notify(
        new FrameworkEvent('inheritsDefaultCSSChanged')
      );
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
  // className
  //---------------------------------

  String _className = 'UIWrapper';

  String get className => _className;

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

  bool hasObserver(String type) {
    return _eventDispatcher.hasObserver(type);
  }

  void observe(String type, Function eventHandler) {
    _eventDispatcher.observe(type, eventHandler);
  }

  void ignore(String type, Function eventHandler) {
    _eventDispatcher.ignore(type, eventHandler);
  }

  void notify(FrameworkEvent event) {
    _eventDispatcher.notify(event);
  }

  //---------------------------------
  //
  // Operator overloads
  //
  //---------------------------------

  void operator []=(String type, Function eventHandler) => observe(type, eventHandler);

  //---------------------------------
  //
  // Public methods
  //
  //---------------------------------
  
  void preInitialize(IUIWrapper forOwner) {
    _reflowManager = new ReflowManager();
    _owner = forOwner;
    _initialize();
  }

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
    } else {
      final UIWrapper elementCast = element as UIWrapper;

      elementCast._reflowManager = _reflowManager;
      elementCast._owner = this;
      elementCast._initialize();
      
      if (_elementId != null) {
        if (prepend) {
          new Timer(
              new Duration(milliseconds: 250), 
              () => _control.children.insert(0, element.control)
          );
        } else {
          new Timer(
              new Duration(milliseconds: 250), 
              () => _control.append(element.control)
          );
        }
      } else {
        if (prepend) {
          _reflowManager.postRendering.whenComplete(
              () => _control.children.insert(0, element.control)
          );
        } else {
          _reflowManager.postRendering.whenComplete(
              () => _control.append(element.control)
          );
        }
      }

      invalidateProperties();
      
      _children.add(element);
    }
  }

  void remove(IUIWrapper element) {
    if (
        (_control != null) &&
        _control.contains(element.control)
    ) {
      _control.children.remove(element.control);
    }
    
    _children.remove(element);
    _addLaterElements.remove(element);

    element.removeAll();
  }

  void removeAll() {
    while (_children.length > 0) {
      remove(_children.removeLast());
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
    
    if (_inheritsDefaultCSS) {
      _reflowManager.postRendering.then(
          (_) {
            _control.classes.add('_' + _className);
          }
      );
    }
    
    if (_classes != null) {
      _reflowManager.postRendering.then(
          (_) => _control.classes.addAll(_classes)
      );
    }

    _updateVisibility();
    _updateControl(5);

    notify(
      new FrameworkEvent(
          'controlChanged',
          relatedObject: element
      )
    );

    invalidateProperties();
    
    _addAllPendingElements();
  }

  void _updateControl(int type) {
    if (_control != null) {
      if (_elementId == null) {
        final String cssX = _x.toString() + 'px';
        final String cssY = _y.toString() + 'px';
        final String cssWidth = (_width == 0) ? 'auto' : _width.toString() + 'px';
        final String cssHeight = (_height == 0) ? 'auto' : _height.toString() + 'px';

        switch (type) {
          case 1 : _reflowManager.invalidateCSS(_control, 'left', cssX);        break;
          case 2 : _reflowManager.invalidateCSS(_control, 'top', cssY);         break;
          case 3 : _reflowManager.invalidateCSS(_control, 'width', cssWidth);   break;
          case 4 : _reflowManager.invalidateCSS(_control, 'height', cssHeight); break;
          case 5 :
            _reflowManager.invalidateCSS(_control, 'left', cssX);
            _reflowManager.invalidateCSS(_control, 'top', cssY);
            _reflowManager.invalidateCSS(_control, 'width', cssWidth);
            _reflowManager.invalidateCSS(_control, 'height', cssHeight);

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
      _reflowManager = new ReflowManager();

      window.$dom_addEventListener('resize', _invalidateSize, true);

      later > _updateSize;
    }
  }

  void _initialize() {
    if (!_isInitialized) {
      _isInitialized = true;

      _createChildren();
      
      notify(
          new FrameworkEvent(
              'initializationComplete'
          )
      );

      invalidateProperties();
    }
  }

  void _createChildren() {
  }

  void _commitProperties() {
    if (_isClassesChanged) {
      _isClassesChanged = false;
      
      if (_control != null) {
        _control.classes.addAll(_classes);
      }
    }
    
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

        _children.forEach(
          (element) {
            element.x = element.paddingLeft;
            element.y = element.paddingRight;
            element.width = _width - element.paddingLeft - element.paddingRight;
            element.height = _height - element.paddingTop - element.paddingBottom;
          }
        );
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
    width = _control.client.width;
    height = _control.client.height;
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
    _eventDispatcher.ignore(
        'controlChanged',
        _addAllPendingElements
    );
    
    _addLaterElements.forEach(
        (element) => add(element)
    );

    _addLaterElements = new List<IUIWrapper>();
  }
}

