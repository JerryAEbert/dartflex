part of dartflex.components;

class VGroup extends Group {

  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------

  VGroup({String elementId: null, int gap: 10}) : super(elementId: elementId) {
    _layout = new VerticalLayout();

    _layout.gap = gap;
  }

  //---------------------------------
  //
  // Public methods
  //
  //---------------------------------

}

