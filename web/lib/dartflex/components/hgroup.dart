part of dartflex.components;

class HGroup extends Group {

  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------

  HGroup({String elementId: null, int gap: 10}) : super(elementId: elementId) {
    _layout = new HorizontalLayout();

    _layout.gap = gap;
  }

  //---------------------------------
  //
  // Public methods
  //
  //---------------------------------

}



