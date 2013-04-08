part of dartflex;

class TileGroup extends Group {
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------

  //---------------------------------
  // gap
  //---------------------------------

  int get gap => _layout.gap;
  set gap(int value) {
    if (value != _layout.gap) {
      _layout.gap = value;

      notify(
        new FrameworkEvent(
          "gapChanged"
        )
      );
    }
  }

  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------

  TileGroup({String elementId: null, int gap: 10}) : super(elementId: elementId) {
    _className = 'TileGroup';
  
    _layout = new TileLayout();

    _layout.gap = gap;
  }

  //---------------------------------
  //
  // Public methods
  //
  //---------------------------------

}

