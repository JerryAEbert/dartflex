part of dartflex;

abstract class IFrameworkEventDispatcher {

  //-----------------------------------
  //
  // Public methods
  //
  //-----------------------------------

  bool hasObserver(String type);
  void observe(String type, Function eventHandler);
  void ignore(String type, Function eventHandler);
  void notify(FrameworkEvent event);

}

class FrameworkEventDispatcher implements IFrameworkEventDispatcher {

  //-----------------------------------
  //
  // Private properties
  //
  //-----------------------------------

  IFrameworkEventDispatcher _dispatcher;

  Map _observers = new Map();

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

  bool hasObserver(String type) {
    return (_observers[type] != null);
  }

  void observe(String type, Function eventHandler) {
    List<Function> handlers;

    if (!hasObserver(type)) {
      _observers[type] = new List<Function>();
    }

    handlers = _observers[type] as List<Function>;

    if (handlers.length > 0) {
      ignore(type, eventHandler);
    }

    handlers.add(eventHandler);
  }

  void ignore(String type, Function eventHandler) {
    int i;

    if (_observers.containsKey(type)) {
      List<Function> handlers = _observers[type];

      i = handlers.length;

      while (i > 0) {
        if (FunctionEqualityUtil.equals(handlers[--i], eventHandler)) {
          handlers.removeAt(i);

          break;
        }
      }

      if (handlers.length == 0) {
        //_observers.remove(type);
      }
    }
  }

  void notify(FrameworkEvent event) {
    if (_observers.containsKey(event.type)) {
      event.currentTarget = _dispatcher;
      
      _observers[event.type].forEach(
          (Function handler) => handler(event)
      );
    }
  }
}