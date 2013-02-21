part of dartflex.components;

class Button extends UIWrapper {

  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------

  //---------------------------------
  // label
  //---------------------------------

  String _label;

  String get label => _label;
  set label(String value) {
    if (value != _label) {
      _label = value;

      dispatch(
        new FrameworkEvent(
          'labelChanged'
        )
      );

      _commitLabel();
    }
  }

  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------

  Button({String elementId: null}) : super(elementId: elementId) {
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
      ButtonElement element = new ButtonElement();

      element.onClick.listen(
        (Event event) => dispatch(
          new FrameworkEvent(
            'click'
          )
        )
      );

      _setControl(element);
    }

    super._createChildren();
  }

  void _commitLabel() {
    if (_control != null) {
      ButtonElement element = _control as ButtonElement;

      _reflowManager.currentNextInterval.then(
          (_) {
            element.text = _label;
          }
      );
    } else {
      later > _commitLabel;
    }
  }
}



