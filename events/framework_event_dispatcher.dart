part of dartflex.events;

abstract class IFrameworkEventDispatcher {
  
  //-----------------------------------
  //
  // Public methods
  //
  //-----------------------------------
  
  void addEventListener(String type, Function eventHandler);
  void removeEventListener(String type, Function eventHandler);
  void dispatchEvent(FrameworkEvent event);
  
}

class FrameworkEventDispatcher implements IFrameworkEventDispatcher {
  
  //-----------------------------------
  //
  // Private properties
  //
  //-----------------------------------
  
  List<FrameworkEventListenerValuePair> _listenerValuePairs = new List<FrameworkEventListenerValuePair>();
  
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
  
  FrameworkEventDispatcher();
  
  //-----------------------------------
  //
  // Public methods
  //
  //-----------------------------------
  
  void addEventListener(String type, Function eventHandler) {
    FrameworkEventListenerValuePair valuePair = new FrameworkEventListenerValuePair(type, eventHandler);
    
    _listenerValuePairs.add(valuePair);
  }
  
  void removeEventListener(String type, Function eventHandler) {
    int i = _listenerValuePairs.length;
    FrameworkEventListenerValuePair valuePair;
    
    while (i > 0) {
      valuePair = _listenerValuePairs[--i];
      
      if (
          (type == valuePair.type) &&
          (eventHandler == valuePair.eventHandler)
      ) {
        _listenerValuePairs.removeAt(i);
      }
    }
  }
  
  void dispatchEvent(FrameworkEvent event) {
    FrameworkEventListenerValuePair valuePair;
    int i = _listenerValuePairs.length;
    
    event.currentTarget = this;
    
    while (i > 0) {
      valuePair = _listenerValuePairs[--i];
      
      if (event.type == valuePair.type) {
        valuePair.eventHandler(event);
      }
    }
  }
}

class FrameworkEventListenerValuePair {
  
  //-----------------------------------
  //
  // Public properties
  //
  //-----------------------------------
  
  //-----------------------------------
  // type
  //-----------------------------------
  
  String _type;
  
  String get type => _type;
  
  //-----------------------------------
  // eventHandler
  //-----------------------------------
  
  Function _eventHandler;
  
  Function get eventHandler => _eventHandler;
  
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
  
  FrameworkEventListenerValuePair(String type, Function eventHandler) {
    _type = type;
    _eventHandler = eventHandler;
  }
  
}

