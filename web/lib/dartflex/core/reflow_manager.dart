part of dartflex.core;

class ReflowManager {
  
  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------
  
  List<ElementCSSMap> _elements = new List<ElementCSSMap>();
  Future _currentNextInterval;
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  ReflowManager();
  
  //-----------------------------------
  //
  // Public methods
  //
  //-----------------------------------
  
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
      
      _elements.addLast(elementCSSMap);
    }
    
    elementCSSMap.cssDecl[property] = value;
    
    if (_currentNextInterval == null) {
      _currentNextInterval = awaitNextInterval();
    }
    
    _currentNextInterval.then(
        (_) {
          _commitAllPendingCSSProperties();
        }
    );
  }
  
  void _commitAllPendingCSSProperties() {
    _elements.forEach(
      (ElementCSSMap elementCSSMap) {
        String cssText = elementCSSMap.element.style.cssText;
        
        elementCSSMap.cssDecl.forEach(
          (String property, String value) {
            RegExp pattern = new RegExp('\\s*${property}:[^;]+;');
            
            if (cssText.contains(pattern)) {
              cssText = cssText.replaceFirst(pattern, ' ${property}: ${value};');
            } else {
              cssText = cssText.concat(' ${property}: ${value};');
            }
          }
        );
        
        elementCSSMap.element.style.cssText = cssText;
      }
    );
    
    _elements = new List<ElementCSSMap>();
    
    _currentNextInterval = null;
  }
  
  Future awaitNextInterval() {
    final completer = new Completer();  
    
    void runAfterTimeout(_) {  
      completer.complete();  
    }  
    
    new Timer(30, runAfterTimeout);  
    
    return completer.future;  
  }
}

class ElementCSSMap {
  
  Element element;
  Map cssDecl;
  
}
