part of dartflex.core;

class UpdateManager {
  
  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------
  
  Map _pendingHandlers = new Map();
  List<Function> _pendingHandlersJS = new List<Function>();
  
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
    final String fncToString = handler.toString();
    int i;
    
    if (fncToString == 'Closure') {
      // JavaScript path
      i = _pendingHandlersJS.length;
      
      while (i > 0) {
        if (_pendingHandlersJS[--i] == handler) {print('has');
          return;
        }
      }
      
      _pendingHandlersJS.addLast(handler);
      
      waitForTick().then(
          (_) {
            i = _pendingHandlersJS.length;
            
            while (i > 0) {
              if (_pendingHandlersJS[--i] == handler) {
                _pendingHandlersJS.removeAt(i);
                
                break;
              }
            }
            
            handler();
          }
      );
    } else {
      // Dart path
      if (
          _pendingHandlers.containsKey(fncToString)
      ) {
        return;
      }
      
      _pendingHandlers[fncToString] = true;
      
      waitForTick().then(
          (_) {
            _pendingHandlers.remove(fncToString);
            
            handler();
          }
      );
    }
  }
  
  Future waitForTick() {
    final completer = new Completer();  
    
    void runAfterTimeout(_) {  
      completer.complete();  
    }  
    
    new Timer(30, runAfterTimeout);  
    
    return completer.future;  
  }
}
