part of dartflex.core;

class UpdateManager {
  
  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------
  
  List<Function> handlers = [];
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  UpdateManager();
  
  //-----------------------------------
  //
  // Operator overloads
  //
  //-----------------------------------
  
  void operator >(Function handler) {
    Timer timer;
    Function tmpHandler;
    bool hasHandler = false;
    int i = handlers.length;
    
    while (i > 0) {
      tmpHandler = handlers[--i];
      
      if (FunctionEqualityUtil.equals(handler, tmpHandler)) {
        hasHandler = true;
        
        return;
      }
    }
    
    if (!hasHandler) {
      TimeoutHandler timeoutHandler = new TimeoutHandler();
      
      timeoutHandler._handler = handler;
      timeoutHandler._beforeHandler = _removeHandler;
      
      handlers.add(handler);
      
      timer = new Timer(20, timeoutHandler._execute);
    } 
  }
  
  void _removeHandler(Function handler) {
    int i = handlers.length;
    
    while (i > 0) {
      if (handler.toString() == handlers[--i].toString()) {
        handlers.removeAt(i);
        
        return;
      }
    }
  }
}

class TimeoutHandler {
  
  Function _handler;
  Function _beforeHandler;
  
  TimeoutHandler();
  
  void _execute(Timer timer) {
    _beforeHandler(_handler);
    
    _handler();
  }
  
}

