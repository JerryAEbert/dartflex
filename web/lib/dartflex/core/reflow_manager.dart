part of dartflex.core;

class ReflowManager {

  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------

  List<ElementCSSMap> _elements = new List<ElementCSSMap>();
  
  bool _hasFinalHandler = false;
  
  final Element _detachedElement = new HtmlElement();
  final RegExp _pattern = new RegExp('[A-Z]');
  
  //---------------------------------
  // currentNextInterval
  //---------------------------------
  
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
    
    if (!_hasFinalHandler) {
      _hasFinalHandler = true;
      
      currentNextInterval.whenComplete(_commitAllPendingCSSProperties);
    }
  }

  void _commitAllPendingCSSProperties() {
    _elements.forEach(_commitCSSProperties);

    _elements = new List<ElementCSSMap>();

    _currentNextInterval = null;
    _hasFinalHandler = false;
  }
  
  void _commitCSSProperties(ElementCSSMap elementCSSMap) {
    _detachedElement.style.cssText = elementCSSMap.element.style.cssText;

    elementCSSMap.cssDecl.forEach(_commitCSSProperty);
        
    elementCSSMap.element.style.cssText = _detachedElement.style.cssText;
  }
  
  void _commitCSSProperty(String propertyName, String value) {
    String propertyNameCopy = propertyName;
    String pm, pmA, pmB;
    
    _pattern.allMatches(propertyName).forEach(
        (Match patternMatch) {
          pm = patternMatch.str.substring(patternMatch.start, patternMatch.end).toLowerCase();
          pmA = patternMatch.str.substring(0, patternMatch.start);
          pmB = patternMatch.str.substring(patternMatch.end);

          propertyNameCopy = '${pmA}-$pm$pmB';
        }
    );

    _detachedElement.style.setProperty(propertyNameCopy, value, '');
    /*stubElement.style.setProperty('-moz-$propertyName', value, '');
    stubElement.style.setProperty('-ms-$propertyName', value, '');
    stubElement.style.setProperty('-o-$propertyName', value, '');
    stubElement.style.setProperty('-webkit-$propertyName', value, '');*/
  }

  Future awaitNextInterval() {
    final completer = new Completer();

    window.setImmediate(completer.complete);

    return completer.future;
  }
}

class ElementCSSMap {

  Element element;
  Map cssDecl;

}
