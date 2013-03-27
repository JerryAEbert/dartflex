part of dartflex;

class EditableText extends UIWrapper {
  
  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------
  
  bool _isWidthAutoScaled = false;
  bool _isHeightAutoScaled = false;

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
    
    TextAreaElement label = new TextAreaElement();
    
    _autoSize = true;

    _setControl(label);

    _commitTextAlign();
    _commitTextVerticalAlign();
    _commitText();

    _reflowManager.invalidateCSS(_control, 'overflow', 'hidden');
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
      _reflowManager.scheduleMethod(this, _commitTextOnReflow, []);
    }
  }
  
  void _commitTextOnReflow() {
    final String newText = (_text != null) ? _text : '';
    
    if (newText == _control.text) {
      return;
    }
    
    _control.text = newText;
    
    if (
        _isWidthAutoScaled ||
        (
          (_width == 0) &&
          (_percentWidth == .0)
        )
    ) {
      _isWidthAutoScaled = true;
      
      _reflowManager.postRendering.whenComplete(_updateWidth);
    }
    
    if (
        _isHeightAutoScaled ||
        (
          (_height == 0) &&
          (_percentHeight == .0)
        )
    ) {
      _isHeightAutoScaled = true;
      
      _reflowManager.postRendering.whenComplete(_updateHeight);
    }
  }
  
  void _updateWidth() {
    final int newWidth = _control.client.width;
    
    if (newWidth > 0) {
      if (newWidth != _width) {
        width = newWidth;
      
        _owner.invalidateProperties();
      }
    } else {
      _reflowManager.postRendering.whenComplete(_updateWidth);
    }
  }
  
  void _updateHeight() {
    final int newHeight = _control.client.height;
    
    if (newHeight > 0) {
      if (newHeight != _height) {
        height = newHeight;
        
        _owner.invalidateProperties();
      }
    } else {
      _reflowManager.postRendering.whenComplete(_updateHeight);
    }
  }
}