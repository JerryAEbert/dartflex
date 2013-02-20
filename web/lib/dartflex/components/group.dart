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
    if (_horizontalScrollPolicy == ScrollPolicy.NONE) {
      _reflowManager.invalidateCSS(_control, 'overflow-x', 'hidden');
    } else if (_horizontalScrollPolicy == ScrollPolicy.AUTO) {
      _reflowManager.invalidateCSS(_control, 'overflow-x', 'auto');
    } else {
      _reflowManager.invalidateCSS(_control, 'overflow-x', 'scroll');
    }
    
    if (_verticalScrollPolicy == ScrollPolicy.NONE) {
      _reflowManager.invalidateCSS(_control, 'overflow-y', 'hidden');
    } else if (_verticalScrollPolicy == ScrollPolicy.AUTO) {
      _reflowManager.invalidateCSS(_control, 'overflow-y', 'auto');
    } else {
      _reflowManager.invalidateCSS(_control, 'overflow-y', 'scroll');
    }
  }
}

