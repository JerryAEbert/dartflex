part of dartflex;

class ReflowManager {

  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------

  static ReflowManager _instance;
  
  List<MethodInvokationMap> _scheduledHandlers = new List<MethodInvokationMap>();
  List<ElementCSSMap> _elements = new List<ElementCSSMap>();
  
  bool _hasCommittedAllScheduledHandlers = false;
  bool _hasCommittedAllPendingCSSProperties = false;

  final HtmlElement _detachedElement = new HtmlElement();

  //---------------------------------
  // preRendering
  //---------------------------------

  Future _preRendering;

  Future get preRendering {
    if (_preRendering == null) {
      _preRendering = _requestPreRenderingSlot();
    }

    return _preRendering;
  }
  
  //---------------------------------
  // postRendering
  //---------------------------------

  Future _postRendering;

  Future get postRendering {
    if (_postRendering == null) {
      _postRendering = _requestPostRenderingSlot();
    }

    return _postRendering;
  }

  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------

  //---------------------------------
  // Singleton
  //---------------------------------

  ReflowManager._construct() {
    window.onMessage.listen(
        (Event event) {
          _preCompleter.complete();
          
          _preCompleter = null;
        }    
    );
  }

  factory ReflowManager() {
    if (_instance == null) {
      _instance = new ReflowManager._construct();
    }

    return _instance;
  }

  //-----------------------------------
  //
  // Public methods
  //
  //-----------------------------------
  
  void scheduleMethod(dynamic owner, Function method, List arguments) {
    //Function.apply(method, arguments); return;
    
    MethodInvokationMap invokation;
    bool hasOccurance = false;
    int i = _scheduledHandlers.length;

    while (i > 0) {
      invokation = _scheduledHandlers[--i];

      if (
          (invokation.owner == owner) &&
          FunctionEqualityUtil.equals(invokation.method, method)
      ) {
        hasOccurance = true;

        break;
      }
    }
    
    if (!hasOccurance) {
      invokation = new MethodInvokationMap()
      ..owner = owner
      ..method = method
      ..arguments = arguments;

      _scheduledHandlers.add(invokation);
    } else {
      invokation.arguments = arguments;
    }
    
    if (!_hasCommittedAllScheduledHandlers) {
      _hasCommittedAllScheduledHandlers = true;
      
      preRendering.whenComplete(_commitAllScheduledHandlers);
    }
  }

  void invalidateCSS(Element element, String property, String value) {
    if (element == null) {
      return;
    }

    ElementCSSMap elementCSSMap;
    bool hasOccurance = false;
    int i = _elements.length;

    while (i > 0) {
      elementCSSMap = _elements[--i];

      if (elementCSSMap.element == element) {
        hasOccurance = true;

        break;
      }
    }

    if (!hasOccurance) {
      elementCSSMap = new ElementCSSMap()
      ..element = element
      ..cssDecl = new Map();

      _elements.add(elementCSSMap);
    }

    elementCSSMap.cssDecl[property] = value;
    
    if (!_hasCommittedAllPendingCSSProperties) {
      _hasCommittedAllPendingCSSProperties = true;

      postRendering.then(_commitAllPendingCSSProperties);
    }
  }
  
  void _commitAllScheduledHandlers() {
    MethodInvokationMap invokation;
    int i = _scheduledHandlers.length;
    
    _hasCommittedAllScheduledHandlers = false;
    
    while (i > 0) {
      invokation = _scheduledHandlers[--i];
      
      Function.apply(invokation.method, invokation.arguments);
      
      _scheduledHandlers.removeAt(i);
    }

    _preRendering = null;
  }

  void _commitAllPendingCSSProperties(_) {
    ElementCSSMap elementCSSMap;
    String cssCache;
    int i = _elements.length;
    
    _hasCommittedAllPendingCSSProperties = false;
    
    _detachedElement.hidden = true;
    
    while (i > 0) {
      elementCSSMap = _elements[--i];
      
      cssCache = elementCSSMap.element.style.cssText;
      
      _detachedElement.style.cssText = cssCache;

      elementCSSMap.cssDecl.forEach(
          (String propertyName, String value) => _detachedElement.style.setProperty(propertyName, value, '')
      );
      
      if (cssCache != _detachedElement.style.cssText) {
        elementCSSMap.element.style.cssText = _detachedElement.style.cssText;
      }
      
      _elements.removeAt(i);
    }

    _postRendering = null;
  }
  
  Completer _preCompleter;
  
  Future _requestPreRenderingSlot() {
    if (_preCompleter != null) {
      return _preCompleter.future;
    }
    
    _preCompleter = new Completer();
    
    window.postMessage('*', '*');

    return _preCompleter.future;
  }
  
  Future _requestPostRenderingSlot() {
    return window.animationFrame;
  }
}

class MethodInvokationMap {

  dynamic owner;
  Function method;
  List arguments;

}

class ElementCSSMap {

  Element element;
  Map cssDecl;

}
