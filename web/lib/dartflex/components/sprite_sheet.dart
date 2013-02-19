part of dartflex.components;

class SpriteSheet extends Group {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  // source
  //---------------------------------
  
  String _source;
  
  String get source => _source;
  set source(String value) {
    if (value != _source) {
      _source = value;
      
      dispatch(
        new FrameworkEvent(
          'sourceChanged'  
        )    
      );
      
      later > _updateSource;
    }
  }
  
  //---------------------------------
  // index
  //---------------------------------
  
  int _index = 0;
  
  int get index => _index;
  set index(int value) {
    if (value != _index) {
      _index = value;
      
      dispatch(
          new FrameworkEvent(
              'indexChanged'  
          )    
      );
      
      later > _updateIndex;
    }
  }
  
  //---------------------------------
  // columnSize
  //---------------------------------
  
  int _columnSize = 0;
  
  int get columnSize => _columnSize;
  set columnSize(int value) {
    if (value != _columnSize) {
      _columnSize = value;
      width = value;
      
      dispatch(
          new FrameworkEvent(
              'columnSizeChanged'  
          )    
      );
      
      later > _updateIndex;
    }
  }
  
  //---------------------------------
  // rowSize
  //---------------------------------
  
  int _rowSize = 0;
  
  int get rowSize => _rowSize;
  set rowSize(int value) {
    if (value != _rowSize) {
      _rowSize = value;
      height = value;
      
      dispatch(
          new FrameworkEvent(
              'rowSizeChanged'  
          )    
      );
      
      later > _updateIndex;
    }
  }
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  SpriteSheet() : super() {
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
    
    if (_source != null) {
      _control.style.backgroundImage = 'url($_source)';
    }
  }
  
  void _updateSource() {
    if (_control != null) {
      _control.style.backgroundImage = 'url($_source)';
    }
  }
  
  void _updateIndex() {
    if (_control != null) {
      final String px = 'px';
      final int column = _index % _columnSize;
      final int row = _index ~/ _columnSize;
      final int posX = column * _columnSize;
      final int posY = row * _rowSize;
      
      _control.style.backgroundPosition = '$posX$px $posY$px';
    }
  }
}



