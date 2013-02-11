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
    
    _control.style.overflow = 'hidden';
  }
  
  void _commitText() {
    if (_control != null) {
      SpanElement element = _control as SpanElement;
      
      element.text = _text;
    } else {
      later > _commitText;
    }
  }
}



