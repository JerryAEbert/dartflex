part of dartflex;

class EditableText extends UIWrapper {
  
  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------

  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------

  //---------------------------------
  // text
  //---------------------------------

  String _text;

  String get text => _text;
  set text(String value) {
    if (value != _text) {
      _text = value;

      notify(
        new FrameworkEvent(
          'textChanged'
        )
      );

      _commitText();
    }
  }

  //---------------------------------
  // align
  //---------------------------------

  String _align = 'left';

  String get align => _align;
  set align(String value) {
    if (value != _align) {
      _align = value;

      notify(
        new FrameworkEvent(
          'alignChanged'
        )
      );

      _commitTextAlign();
    }
  }
  
  //---------------------------------
  // verticalAlign
  //---------------------------------

  String _verticalAlign = 'text-top';

  String get verticalAlign => _verticalAlign;
  set verticalAlign(String value) {
    if (value != _verticalAlign) {
      _verticalAlign = value;

      notify(
        new FrameworkEvent(
          'verticalAlignChanged'
        )
      );

      _commitTextVerticalAlign();
    }
  }

  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------

  EditableText({String elementId: null}) : super(elementId: elementId) {
    _className = 'EditableText';
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
    
    TextInputElement label = new TextInputElement();
    
    _autoSize = true;

    _setControl(label);

    _commitTextAlign();
    _commitTextVerticalAlign();
    _commitText();
  }

  void _commitTextAlign() {
    if (_control != null) {
      _reflowManager.invalidateCSS(_control, 'text-align', _align);
    }
  }
  
  void _commitTextVerticalAlign() {
    if (_control != null) {
      _reflowManager.invalidateCSS(_control, 'vertical-align', _verticalAlign);
    }
  }

  void _commitText() {
    if (_control != null) {
      _reflowManager.postRendering.whenComplete(_commitTextOnReflow);
    }
  }
  
  void _commitTextOnReflow() {
    final String newText = (_text != null) ? _text : '';
    final TextInputElement controlCast = _control as TextInputElement;
    
    if (newText == controlCast.value) {
      return;
    }
    
    controlCast.value = newText;
  }
}