part of dartflex;

class ViewStack extends UIWrapper {

  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------

  bool _isScrollPolicyInvalid = false;

  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  // container
  //---------------------------------
  
  Group _container;
  
  Group get container => _container;
  
  //---------------------------------
  // registeredViews
  //---------------------------------
  
  List<ViewStackElement> _registeredViews = new List<ViewStackElement>();
  
  List<ViewStackElement> get registeredViews => _registeredViews;
  
  //---------------------------------
  // activeView
  //---------------------------------
  
  String get activeView => (_activeViewStackElement != null) ? _activeViewStackElement.uniqueId : null;
  
  //---------------------------------
  // activeViewStackElement
  //---------------------------------
  
  ViewStackElement _activeViewStackElement;
  ViewStackElement _inactiveViewStackElement;
  
  ViewStackElement get activeViewStackElement => _activeViewStackElement;

  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------

  ViewStack({String elementId: null}) : super(elementId: elementId) {
  	_className = 'ViewStack';
  	
  	_createChildren();
  }

  //---------------------------------
  //
  // Public methods
  //
  //---------------------------------
  
  void add(IUIWrapper element, {bool prepend: false}) {
    throw new ArgumentError('Please use addView() instead');
  }
  
  void addView(String uniqueId, IUIWrapper element) {
    ViewStackElement viewStackElement;
    int i = _registeredViews.length;
    
    while (i > 0) {
      viewStackElement = _registeredViews[--i];
      
      if (viewStackElement.uniqueId == uniqueId) {
        return;
      }
    }
    
    viewStackElement = new ViewStackElement();
    
    viewStackElement.element = element;
    viewStackElement.uniqueId = uniqueId;
    
    element.observe(
        ViewStackEvent.REQUEST_VIEW_CHANGE, 
        _viewStackElement_requestViewChangeHandler
    );
    
    _registeredViews.add(viewStackElement);
  }
  
  bool show(String uniqueId) {
    if (_container == null) {
      onControlChanged.listen(
          (FrameworkEvent event) => show(uniqueId)
      );
    } else {
      ViewStackElement viewStackElement;
      final int currentIndex = (_activeViewStackElement != null) ? _registeredViews.indexOf(_activeViewStackElement) : -1;
      int newIndex = -1;
      int i = _registeredViews.length;
      
      while (i > 0) {
        viewStackElement = _registeredViews[--i];
        
        if (viewStackElement.uniqueId == uniqueId) {
          newIndex = i;
          
          break;
        }
      }
      
      if (
          (currentIndex == newIndex) ||
          (newIndex == -1)
      ) {
        return false;
      }
      
      viewStackElement.element.visible = true;
      viewStackElement.element.preInitialize(this);
      
      if (currentIndex >= 0) {
        _inactiveViewStackElement = _activeViewStackElement;
        
        if (newIndex > currentIndex) {
          _container.x -= _width;
          
          viewStackElement.element.x = _inactiveViewStackElement.element.x + _width;
        } else {
          _container.x += _width;
          
          viewStackElement.element.x = _inactiveViewStackElement.element.x - _width;
        }
      }
      
      _activeViewStackElement = viewStackElement;
      
      _container.add(viewStackElement.element);
      
      _updateLayout();
      
      return true;
    }
    
    return false;
  }

  //---------------------------------
  //
  // Protected methods
  //
  //---------------------------------

  void _createChildren() {
    if (_control == null) {
      _setControl(new DivElement());
    }
    
    _layout = new AbsoluteLayout();
    
    _container = new Group()
    ..inheritsDefaultCSS = false
    ..classes = ['_ViewStackSlider']
    .._layout = new AbsoluteLayout();
    
    _reflowManager.invalidateCSS(
        _container._control,
        'position',
        'absolute'
    );
    
    super.add(_container);
    
    _container.control.onTransitionEnd.listen(_container_transitionEndHandler);

    super._createChildren();
  }
  
  void _updateLayout() {
    super._updateLayout();
    
    if (_graphics != null) {
      _graphics.width = _width;
      _graphics.height = _height;
    }
    
    if (_container != null) {
      _container.width = 2 * _width;
      _container.height = _height;
    }

    if (_activeViewStackElement != null) {
      _activeViewStackElement.element.width = _width;
      _activeViewStackElement.element.height = _height;
    }
  }
  
  void _viewStackElement_requestViewChangeHandler(ViewStackEvent event) {
    if (event.namedView != null) {
      show(event.namedView);
    } else if (event.sequentialView > 0) {
      final int len = _registeredViews.length;
      final int index = _registeredViews.indexOf(_activeViewStackElement);
      ViewStackElement requestedElement;
      int requestedIndex;
      
      if (event.sequentialView == ViewStackEvent.REQUEST_PREVIOUS_VIEW) {
        requestedIndex = index - 1;
      } else if (event.sequentialView == ViewStackEvent.REQUEST_NEXT_VIEW) {
        requestedIndex = index + 1;
      } else if (event.sequentialView == ViewStackEvent.REQUEST_FIRST_VIEW) {
        requestedIndex = 0;
      } else if (event.sequentialView == ViewStackEvent.REQUEST_LAST_VIEW) {
        requestedIndex = len - 1;
      }
      
      requestedIndex = (requestedIndex < 0) ? (len - 1) : (requestedIndex >= len) ? 0 : requestedIndex;
      
      requestedElement = _registeredViews[requestedIndex];
      
      show(requestedElement.uniqueId);
    }
  }
  
  void _container_transitionEndHandler(Event event) {
    if (_inactiveViewStackElement != null) {
      _inactiveViewStackElement.element.visible = false;
      
      _inactiveViewStackElement = null;
    }
  }
}

class ViewStackElement {
  
  IUIWrapper element;
  String uniqueId;
  
}

