part of dartflex.events;

abstract class IFrameworkEventDispatcher {
  
  //-----------------------------------
  //
  // Public methods
  //
  //-----------------------------------
  
  bool hasEventListener(String type, Function eventHandler);
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
  
  IFrameworkEventDispatcher _dispatcher;
  
  List<FrameworkEventListenerValuePair> _listenerValuePairs = new List<FrameworkEventListenerValuePair>();
  
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
  
  FrameworkEventDispatcher({IFrameworkEventDispatcher dispatcher: null}) {
    if (dispatcher == null) {
      _dispatcher = this;
    } else {
      _dispatcher = dispatcher;
    }
  }
  
  //-----------------------------------
  //
  // Public methods
  //
  //-----------------------------------
  
  bool hasEventListener(String type, Function eventHandler) {
    FrameworkEventListenerValuePair valuePair;
    int i = _listenerValuePairs.length;
    
    while (i > 0) {
      valuePair = _listenerValuePairs[--i];
      
      if (
          (valuePair.type == type) &&
          FunctionEqualityUtil.equals(valuePair.eventHandler, eventHandler)
      ) {
        return true;
      }
    }
    
    return false;
  }
  
  void addEventListener(String type, Function eventHandler) {
    if (!hasEventListener(type, eventHandler)) {
      _listenerValuePairs.add(
          new FrameworkEventListenerValuePair(type, eventHandler)
      );
    }
  }
  
  void removeEventListener(String type, Function eventHandler) {
    int i = _listenerValuePairs.length;
    FrameworkEventListenerValuePair valuePair;
    
    while (i > 0) {
      valuePair = _listenerValuePairs[--i];
      
      if (
          (type == valuePair.type) &&
          FunctionEqualityUtil.equals(eventHandler, valuePair.eventHandler)
      ) {
        _listenerValuePairs.removeAt(i);
        
        return;
      }
    }
  }
  
  void dispatch(FrameworkEvent event) {
    FrameworkEventListenerValuePair valuePair;
    int i = _listenerValuePairs.length;
    
    if (i > 0) {
      event.currentTarget = _dispatcher;
      
      while (i > 0) {
        valuePair = _listenerValuePairs[--i];
        
        if (event.type == valuePair.type) {
          valuePair.eventHandler(event);
        }
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

