part of dartflex.components;

class VGroup extends Group {
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  VGroup({String elementId: null}) : super(elementId: elementId) {
    _layout = new VerticalLayout();
  }
  
  //---------------------------------
  //
  // Public methods
  //
  //---------------------------------
  
}

