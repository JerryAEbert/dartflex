part of dartflex.components;

class Group extends UIWrapper {
  
  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------
  
  bool _isScrollPolicyInvalid = false;
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  // horizontalScrollPolicy
  //---------------------------------
  
  String _horizontalScrollPolicy = ScrollPolicy.NONE;
  
  String get horizontalScrollPolicy => _horizontalScrollPolicy;
  set horizontalScrollPolicy(String value) {
    if (value != _horizontalScrollPolicy) {
      _horizontalScrollPolicy = value;
      
      _isScrollPolicyInvalid = true;
      
      dispatch(
        new FrameworkEvent(
          "horizontalScrollPolicyChanged"
        )
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // verticalScrollPolicy
  //---------------------------------
  
  String _verticalScrollPolicy = ScrollPolicy.NONE;
  
  String get verticalScrollPolicy => _verticalScrollPolicy;
  set verticalScrollPolicy(String value) {
    if (value != _verticalScrollPolicy) {
      _verticalScrollPolicy = value;
      
      _isScrollPolicyInvalid = true;
      
      dispatch(
        new FrameworkEvent(
          "verticalScrollPolicyChanged"
        )
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  Group({String elementId: null}) : super(elementId: elementId) {
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
      _setControl(new DivElement());
    }
    
    super._createChildren();
  }
  
  void _setControl(Element element) {
    super._setControl(element);
    
    _isScrollPolicyInvalid = true;
  }
  
  void _commitProperties() {
    super._commitProperties();
    
    if (_control != null) {
      if (_isScrollPolicyInvalid) {
        _isScrollPolicyInvalid = false;
        
        _updateScrollPolicy();
      }  
    }
  }
  
  void _updateScrollPolicy() {
    // TO_FIX
    _control.style.overflow = 'visible';
    
    if (_horizontalScrollPolicy == ScrollPolicy.NONE) {
      _control.style.overflowX = 'hidden';
    } else if (_horizontalScrollPolicy == ScrollPolicy.AUTO) {
      _control.style.overflowX = 'auto';
    } else {
      _control.style.overflowX = 'scroll';
    }
    
    if (_verticalScrollPolicy == ScrollPolicy.NONE) {
      _control.style.overflowY = 'hidden';
    } else if (_verticalScrollPolicy == ScrollPolicy.AUTO) {
      _control.style.overflowY = 'auto';
    } else {
      _control.style.overflowY = 'scroll';
    }
  }
}

