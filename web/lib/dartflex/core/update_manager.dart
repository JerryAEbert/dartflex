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

    if (fncToString == 'Closure') {
      // JavaScript path
      if (
          _pendingHandlersJS.contains(handler)
      ) {
        return;
      }

      _pendingHandlersJS.add(handler);

      _reflowManager.postRendering.then(
          (_) {
            _pendingHandlersJS.remove(handler);

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

      _reflowManager.postRendering.then(
          (_) {
            _pendingHandlers.remove(fncToString);

            handler();
          }
      );
    }
  }
}
