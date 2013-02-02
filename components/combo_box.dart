part of dartflex.components;

class ComboBox extends ListWrapper {
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  ComboBox() : super(elementId: null) {
    _width = 120;
    _height = 21;
  }
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  //
  // Protected methods
  //
  //---------------------------------
  
  void _createChildren() {
    super._createChildren();
    
    _control = new SelectElement();
    
    _control.on.change.add(control_changeHandler);
  }
  
  void control_changeHandler(Event event) {
    if (_control.selectedOptions.length > 0) {
      selectedItem = _dataProvider[_control.selectedIndex];
    } else {
      selectedItem = null;
    }
  }
}

