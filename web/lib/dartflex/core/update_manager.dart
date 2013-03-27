part of dartflex;

class UpdateManager {

  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------

  Map _pendingHandlers = new Map();
  List<Function> _pendingHandlersJS = new List<Function>();

  static ReflowManager _reflowManager = new ReflowManager();

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
        if (_pendingHandlersJS[--i] == handler) {
          return;
        }
      }

      _pendingHandlersJS.add(handler);

      _reflowManager.preRendering.then(
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

      _reflowManager.preRendering.then(
          (_) {
            _pendingHandlers.remove(fncToString);

            handler();
          }
      );
    }
  }
}
