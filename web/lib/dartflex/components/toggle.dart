part of dartflex;

class Toggle extends UIWrapper {
  
  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------
  
  RangeInputElement _handle;

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
      
      _commitIsToggled();
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
      _handle = new RangeInputElement()
      ..value = _isToggled ? '1' : '0'
      ..min = '0'
      ..max = '1'
      ..step = '1';
      
      _handle.onChange.listen(_handle_changeHandler);
      
      _setControl(_handle);
    }

    super._createChildren();
  }
  
  void _updateLayout() {
    //super._updateLayout();
  }
  
  void _commitIsToggled() {
    if (_control != null) {
      _reflowManager.scheduleMethod(this, _commitIsToggledOnReflow, []);
    }
  }
  
  void _commitIsToggledOnReflow() {
    _handle.value = _isToggled ? '1' : '0';
  }
  
  void _handle_changeHandler(Event event) {
    isToggled = (_handle.value == '1');
  }
}

