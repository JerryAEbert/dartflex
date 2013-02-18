part of dartflex.components;

class Graphics extends UIWrapper {
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  // renderingObject
  //---------------------------------
  
  CanvasRenderingContext2D _context;
  
  CanvasRenderingContext2D get context => _context;
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  Graphics({String elementId: null}) : super(elementId: elementId) {
    _includeInLayout = false;
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
    
    _setControl(new CanvasElement(width: _owner._width, height: _owner._height));
    
    _control.style.position = 'absolute';
    _control.style.left = '0px';
    _control.style.top = '0px';
    
    _context = _control.getContext("2d");
  }
  
  void _updateLayout() {
    if (
      (_width > 0) &&
      (_height > 0)
    ) {
      if (_control != null) {
        CanvasElement controlCast = _control as CanvasElement;
        
        controlCast.width = _width;
        controlCast.height = _height;
      }
      
      super._updateLayout();
    }
  }
}





