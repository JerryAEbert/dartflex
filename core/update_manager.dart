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
  
  void testFnc() {}
  
  void operator >(Function handler) {
    Timer timer;
    Function tmpHandler;
    bool isVM = (testFnc != testFnc); // always true in the VM
    bool hasHandler = false;
    bool isEqual;
    int i = handlers.length;
    
    while (i > 0) {
      tmpHandler = handlers[--i];
      
      if (isVM) {
        // dart VM does not currently support function equality checks
        isEqual = (handler.toString() == tmpHandler.toString());
      } else {
        // JS obviously does
        isEqual = (handler == tmpHandler);
      }
      
      if (isEqual) {
        hasHandler = true;
        
        break;
      }
    }
    
    if (!hasHandler) {
      TimeoutHandler timeoutHandler = new TimeoutHandler();
      
      timeoutHandler._handler = handler;
      timeoutHandler._beforeHandler = _removeHandler;
      
      handlers.add(handler);
      
      timer = new Timer(30, timeoutHandler._execute);
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

