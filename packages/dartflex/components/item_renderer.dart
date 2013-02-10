part of dartflex.components;

abstract class IItemRenderer implements IFrameworkEventDispatcher, IUIWrapper {
  
  String get state;
  set state(String value);
  
  int get width;
  set width(int value);
  
  int get height;
  set height(int value);
  
  bool get selected;
  set selected(bool value);
  
  Object get data;
  set data(Object value);
  
  void createChildren();
  
  void invalidateData();
  
  void updateLayout();
  
  void updateAfterInteraction();
  
}

class ItemRenderer extends UIWrapper implements IItemRenderer {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
  Graphics _selectIndicator;
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  // data
  //---------------------------------
  
  Object _data;
  
  Object get data => _data;
  set data(Object value) {
    if (value != _data) {
      _data = value;
      
      _invalidateData();
    }
  }
  
  //---------------------------------
  // state
  //---------------------------------
  
  String _state = 'mouseout';
  
  String get state => _state;
  set state(String value) {
    if (value != _state) {
      _state = value;
      
      _updateAfterInteraction();
    }
  }
  
  //---------------------------------
  // selected
  //---------------------------------
  
  bool _selected = false;
  bool _isSelectionInvalid = false;
  
  bool get selected => _selected;
  set selected(bool value) {
    if (value != _selected) {
      _selected = value;
      _isSelectionInvalid = true;
      
      _updateAfterInteraction();
    }
  }
  
  //---------------------------------
  // selected
  //---------------------------------
  
  String get interactionStyle {
    List<String> enum = new List<String>();
    
    if (_selected) {
      enum.add('selected');
    }
    
    enum.add(_state);
    
    return enum.join('_');
  }
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  ItemRenderer({String elementId: null}) : super(elementId: null) {
  }
  
  static ItemRenderer construct() {
    return new ItemRenderer();
  }
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  void createChildren() {
  }
  
  void invalidateData() {
  }
  
  void updateLayout() {
  }
  
  void updateAfterInteraction() {
  }
  
  //---------------------------------
  //
  // Protected methods
  //
  //---------------------------------
  
  void _createChildren() {
    super._createChildren();
    
    _setControl(new DivElement());
    
    _selectIndicator = new Graphics();
    
    add(_selectIndicator, prepend: true);
    
    _control.style.overflow = 'hidden';
    
    createChildren();
  }
  
  void _invalidateData() {
    invalidateData();
  }
  
  void _updateLayout() {
    super._updateLayout();
    
    later > _updateAfterInteraction;
    
    updateLayout();
  }
  
  double _fraction;
  
  void _updateAfterInteraction() {
    if (
        (_selectIndicator != null) &&
        (_selectIndicator.context != null)
    ) {
      if (_selected) {
        if (_isSelectionInvalid) {
          _isSelectionInvalid = false;
          
          _fraction = .0;
          
          later > _applySelectionAlpha;
        }
      } else if (_state != 'mouseout') {
        _selectIndicator.context.clearRect(0, 0, _width, _height);
        
        _selectIndicator.context.beginPath();
        
        _selectIndicator.context.globalAlpha = .5;
        _selectIndicator.context.fillStyle = '#80bbee';
        _selectIndicator.context.fillRect(0, 0, _width, _height);
        
        _selectIndicator.context.closePath();
      } else {
        _selectIndicator.context.clearRect(0, 0, _width, _height);
      }
    } else {
      later > _updateAfterInteraction;
    }
    
    updateAfterInteraction();
  }
  
  void _applySelectionAlpha() {
    if (_selected) {
      _fraction += .025;
      
      IEaser easer = new Sine();
      double currentFraction = easer.ease((_fraction > 1.0) ? 1.0 : _fraction);
      
      _selectIndicator.context.clearRect(0, 0, _width, _height);
      
      _selectIndicator.context.beginPath();
      
      _selectIndicator.context.globalAlpha = currentFraction;
      _selectIndicator.context.fillStyle = '#80bbee';
      _selectIndicator.context.fillRect(0, 0, _width, _height);
      
      _selectIndicator.context.closePath();
      
      if (_fraction < 1.0) {
        later > _applySelectionAlpha;
      }
    }
  }
}

