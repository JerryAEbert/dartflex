part of dartflex;

class Toggle extends UIWrapper {
  
  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------
  
  Button _handle;

  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------

  //---------------------------------
  // label
  //---------------------------------

  bool _isToggled = false;

  bool get isToggled => _isToggled;
  set isToggled(bool value) {
    if (value != _isToggled) {
      _isToggled = value;

      notify(
        new FrameworkEvent(
          'isToggledChanged'
        )
      );
    }
  }

  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------

  Toggle({String elementId: null}) : super(elementId: elementId) {
    _className = 'Toggle';
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

  void _createChildren() {
    if (_control == null) {
      _handle = new Button()
      ..inheritsDefaultCSS = false
      ..width = 30
      ..height = 30;
      
      _handle.classes = ['_ToggleHandle'];
      
      add(_handle);

      _setControl(new DivElement());
    }

    super._createChildren();
  }
  
  void _updateLayout() {
    //super._updateLayout();
  }
}

