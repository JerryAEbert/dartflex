part of dartflex.components;

class RichText extends UIWrapper {
  
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
      
      dispatch(
        new FrameworkEvent(
          'textChanged'
        )    
      );
      
      later > _commitText;
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
      
      dispatch(
        new FrameworkEvent(
          'alignChanged'
        )    
      );
      
      later > _commitTextAlign;
    }
  }
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  RichText({String elementId: null}) : super(elementId: elementId) {
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
    
    _setControl(new SpanElement());
    
    _commitTextAlign();
    _commitText();
    
    _control.style.overflow = 'hidden';
  }
  
  void _commitTextAlign() {
    if (_control != null) {
      _control.style.textAlign = _align;
    }
  }
  
  void _commitText() {
    if (_control != null) {
      _control.innerHtml = (_text != null) ? _text : '';
    }
  }
}



