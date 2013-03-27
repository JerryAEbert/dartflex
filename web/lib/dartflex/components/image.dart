part of dartflex;

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

  String get source => _source;
  set source(String value) {
    if (value != _source) {
      _source = value;

      notify(
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
  	_className = 'Image';
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
      _reflowManager.invalidateCSS(controlCast, 'background-repeat', 'no-repeat');
      _reflowManager.invalidateCSS(controlCast, 'background-rmage', 'url($_source)');

      _setControl(controlCast);
    }

    super._createChildren();
  }

  void _commitSource() {
    super._commitProperties();

    if (_control != null) {
      DivElement controlCast = _control as DivElement;

      _reflowManager.invalidateCSS(controlCast, 'background-image', 'url($_source)');
    }
  }
}

