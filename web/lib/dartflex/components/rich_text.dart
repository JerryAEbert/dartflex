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
      
      dispatch(
        new FrameworkEvent(
          'alignChanged'
        )    
      );
      
      _commitTextAlign();
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
    
    _setControl(new LabelElement());
    
    _commitTextAlign();
    _commitText();
    
    _reflowManager.invalidateCSS(_control, 'overflow', 'hidden');
  }
  
  void _commitTextAlign() {
    if (_control != null) {
      _reflowManager.invalidateCSS(_control, 'textAlign', '_align');
    }
  }
  
  void _commitText() {
    if (_control != null) {
      _reflowManager.currentNextInterval.then(
          (_) {
            _control.innerHtml = (_text != null) ? _text : '';
          }
      ); 
    }
  }
}



