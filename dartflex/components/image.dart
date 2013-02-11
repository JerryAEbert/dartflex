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
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // aspectRatio
  //---------------------------------
  
  String _aspectRatio = 'cover';
  bool _isAspectRatioChanged = false;
  
  String get aspectRatio => _aspectRatio;
  set aspectRatio(String value) {
    if (value != _aspectRatio) {
      _aspectRatio = value;
      
      dispatch(
          new FrameworkEvent('aspectRatioChanged') 
      );
      
      invalidateProperties();
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
      ImageElement controlCast = new ImageElement();
      
      controlCast.onLoad.listen(_control_loadHandler);
      
      controlCast.src = _source;
      
      controlCast.style.aspectRatio = _aspectRatio;
      
      _setControl(controlCast);
    }
    
    super._createChildren();
  }
  
  void _commitProperties() {
    super._commitProperties();
    
    if (_control != null) {
      ImageElement controlCast = _control as ImageElement;
      
      if (_isSourceChanged) {
        _isSourceChanged = false;
        
        controlCast.src = _source;
      }
      
      if (_isAspectRatioChanged) {
        _isAspectRatioChanged = false;
        
        controlCast.style.objectFit = _aspectRatio;
      }
    }
  }
  
  void _control_loadHandler(Event event) {
    dispatch(
        new FrameworkEvent('loadComplete') 
    );
  }
}

