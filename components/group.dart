part of dartflex.components;

class Group extends UIWrapper {
  
  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  Group({String elementId: null}) : super(elementId: elementId) {
  }
  
  //---------------------------------
  //
  // Public methods
  //
  //---------------------------------
  
  //---------------------------------
  //
  // Protected methods
  //
  //---------------------------------
  
  void _initialize() {
    super._initialize();
    
    if (_control == null) {
      _control = new DivElement();
    }
  }
}

