part of dartflex.components;

abstract class IItemRenderer implements IUIWrapper {

  int get index;
  set index(int value);

  String get state;
  set state(String value);

  bool get selected;
  set selected(bool value);

  Object get data;
  set data(Object value);

  bool get autoDrawBackground;
  set autoDrawBackground(bool value);

  double get opacity;
  set opacity(double value);

  int get gap;
  set gap(int value);

  String get interactionStyle;

  void setOpacityDimmed();

  void setOpacityNormal();

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
  
  bool _isSelectIndicatorRendered = false;

  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------

  //---------------------------------
  // index
  //---------------------------------

  int _index = 0;

  int get index => _index;
  set index(int value) {
    if (value != _index) {
      _index = value;
    }
  }

  //---------------------------------
  // data
  //---------------------------------

  dynamic _data;

  dynamic get data => _data;
  set data(dynamic value) {
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

      later > _updateAfterInteraction;
    }
  }

  //---------------------------------
  // selected
  //---------------------------------

  bool _selected = false;

  bool get selected => _selected;
  set selected(bool value) {
    if (value != _selected) {
      _selected = value;

      later > _updateAfterInteraction;
    }
  }

  //---------------------------------
  // interactionStyle
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
  // autoDrawBackground
  //---------------------------------

  bool _autoDrawBackground;

  bool get autoDrawBackground => _autoDrawBackground;
  set autoDrawBackground(bool value) {
    if (value != _autoDrawBackground) {
      _autoDrawBackground = value;
    }
  }

  //---------------------------------
  // opacity
  //---------------------------------

  double _opacity = 1.0;

  double get opacity => _opacity;
  set opacity(double value) {
    if (value != _opacity) {
      _opacity = value;

      _updateOpacity();
    }
  }

  //---------------------------------
  // gap
  //---------------------------------

  int _gap = 0;

  int get gap => _gap;
  set gap(int value) {
    if (value != _gap) {
      _gap = value;

      later > _updateLayout;
    }
  }

  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------

  ItemRenderer({String elementId: null, bool autoDrawBackground: true}) : super(elementId: null) {
    _autoDrawBackground = autoDrawBackground;
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

  void setOpacityDimmed() {
    opacity = .25;
  }

  void setOpacityNormal() {
    opacity = 1.0;
  }

  //---------------------------------
  //
  // Protected methods
  //
  //---------------------------------

  void _setControl(Element element) {
    super._setControl(element);

    _updateOpacity();
  }

  void _createChildren() {
    super._createChildren();

    DivElement container = new DivElement();

    _setControl(container);

    _reflowManager.invalidateCSS(_control, 'overflow', 'hidden');
    _reflowManager.invalidateCSS(container, 'border', '1px solid #cccccc');
    
    _selectIndicator = new Graphics()
    ..includeInLayout = false;

    add(_selectIndicator, prepend: true);

    createChildren();

    later > _invalidateData;
  }

  void _invalidateData() {
    invalidateData();
  }

  void _updateLayout() {
    super._updateLayout();

    updateLayout();
  }

  void _updateOpacity() {
    if (_control != null) {
      //_reflowManager.invalidateCSS(_control, 'opacity', _opacity.toString());
    }
  }

  void _updateAfterInteraction() {
    if (!_autoDrawBackground) {
      return;
    }

    if (
        (_selectIndicator != null) &&
        (_selectIndicator.context != null)
    ) {
      double targetOpacity;
      
      if (_selected) {
        _reflowManager.invalidateCSS(_selectIndicator._control, 'transition', 'opacity .5s');
        _reflowManager.invalidateCSS(_selectIndicator._control, '-o-transition', 'opacity .5s');
        _reflowManager.invalidateCSS(_selectIndicator._control, '-webkit-transition', 'opacity .5s');
        _reflowManager.invalidateCSS(_selectIndicator._control, '-moz-transition', 'opacity .5s');
        
        targetOpacity = 1.0;
      } else if (_state != 'mouseout') {
        _reflowManager.invalidateCSS(_selectIndicator._control, 'transition', 'opacity 0s');
        
        targetOpacity = 0.5;
      } else {
        _reflowManager.invalidateCSS(_selectIndicator._control, 'transition', 'opacity .5s');
        
        targetOpacity = 0.0;
      }
      
      _drawSelectIndicator();
      
      _reflowManager.invalidateCSS(_selectIndicator._control, 'opacity', targetOpacity.toString());
    } else {
      later > _updateAfterInteraction;
    }

    updateAfterInteraction();
  }
  
  void _drawSelectIndicator() {
    _selectIndicator.x = _x;
    _selectIndicator.y = _y;
    _selectIndicator.width = _width;
    _selectIndicator.height = _height;
    
    _selectIndicator.context.clearRect(0, 0, _width, _height);
    _selectIndicator.context.beginPath();
    _selectIndicator.context.fillStyle = '#80bbee';
    _selectIndicator.context.fillRect(0, 0, _width, _height);
    _selectIndicator.context.closePath();
  }
}

