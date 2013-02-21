part of dartflex.core;

class ReflowManager {
  
  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------
  
  List<ElementCSSMap> _elements = new List<ElementCSSMap>();
  
  Future _currentNextInterval;
  
  Future get currentNextInterval {
    if (_currentNextInterval == null) {
      _currentNextInterval = awaitNextInterval();
    }
    
    return _currentNextInterval;
  }
  
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
    final HtmlElement stubElement = new HtmlElement();
    final RegExp pattern = new RegExp('[A-Z]');
    Iterable patternMatches;
    String pm, pmA, pmB;
    
    _elements.forEach(
      (ElementCSSMap elementCSSMap) {
        stubElement.style.cssText = elementCSSMap.element.style.cssText;
        
        elementCSSMap.cssDecl.forEach(
          (String propertyName, String value) {
            patternMatches = pattern.allMatches(propertyName);
            
            patternMatches.forEach(
              (Match patternMatch) {
                pm = patternMatch.str.substring(patternMatch.start, patternMatch.end).toLowerCase();
                pmA = patternMatch.str.substring(0, patternMatch.start);
                pmB = patternMatch.str.substring(patternMatch.end);
                
                propertyName = '${pmA}-$pm$pmB';
              }
            );
            
            stubElement.style.setProperty(propertyName, value, '');
            /*stubElement.style.setProperty('-moz-$propertyName', value, '');
            stubElement.style.setProperty('-ms-$propertyName', value, '');
            stubElement.style.setProperty('-o-$propertyName', value, '');
            stubElement.style.setProperty('-webkit-$propertyName', value, '');*/
          }
        );
        
        elementCSSMap.element.style.cssText = stubElement.style.cssText;
      }
    );
    
    _elements = new List<ElementCSSMap>();
    
    _currentNextInterval = null;
  }
  
  Future awaitNextInterval() {
    final completer = new Completer();
    
    window.setImmediate(
      () {
        completer.complete();
      }    
    );
    
    return completer.future;  
  }
}

class ElementCSSMap {
  
  Element element;
  Map cssDecl;
  
}
