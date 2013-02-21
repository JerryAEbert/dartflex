part of dartflex.components;

class Image extends UIWrapper {

  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------

  //---------------------------------
  // source
  //---------------------------------

  String _source;
  bool _isSourceChanged = false;

  String get source => _source;
  set source(String value) {
    if (value != _source) {
      _source = value;
      _isSourceChanged = true;

      dispatch(
          new FrameworkEvent('sourceChanged')
      );

      _commitSource();
    }
  }

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

  Image({String elementId: null}) : super(elementId: elementId) {
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
      DivElement controlCast = new DivElement();

      _reflowManager.invalidateCSS(controlCast, 'overflow', 'hidden');
      _reflowManager.invalidateCSS(controlCast, 'backgroundRepeat', 'no-repeat');
      _reflowManager.invalidateCSS(controlCast, 'backgroundImage', 'url($_source)');

      _setControl(controlCast);
    }

    super._createChildren();
  }

  void _commitSource() {
    super._commitProperties();

    if (_control != null) {
      DivElement controlCast = _control as DivElement;

      if (_isSourceChanged) {
        _isSourceChanged = false;

        _reflowManager.invalidateCSS(controlCast, 'backgroundImage', 'url($_source)');
      }
    }
  }
}

