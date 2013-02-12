part of dartflex.components;

class DataGrid extends ListWrapper {
  
  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------
  
  Group _scrollTarget;
  HGroup _headerContainer;
  HGroup _columnContainer;
  VGroup _containerMain;
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  // columns
  //---------------------------------
  
  ListCollection _columns;
  bool _isColumnsChanged = false;
  
  ListCollection get columns => _columns;
  set columns(ListCollection value) {
    if (value != _columns) {
      if (_columns != null) {
        _columns.removeEventListener(
            CollectionEvent.COLLECTION_CHANGED, 
            _columns_collectionChangedHandler
        );
      }
      
      _columns = value;
      _isColumnsChanged = true;
      
      if (value != null) {
        value.addEventListener(
            CollectionEvent.COLLECTION_CHANGED, 
            _columns_collectionChangedHandler
        );
      }
      
      dispatch(
        new FrameworkEvent(
          'columnsChanged' 
        )    
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // headerHeight
  //---------------------------------
  
  int _headerHeight = 24;
  
  int get headerHeight => _headerHeight;
  set headerHeight(int value) {
    if (value != _headerHeight) {
      _headerHeight = value;
      
      dispatch(
        new FrameworkEvent(
          'headerHeightChanged' 
        )    
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // rowHeight
  //---------------------------------
  
  int _rowHeight = 0;
  
  int get rowHeight => _rowHeight;
  set rowHeight(int value) {
    if (value != _rowHeight) {
      _rowHeight = value;
      
      dispatch(
        new FrameworkEvent(
          'rowHeightChanged' 
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
  
  DataGrid() : super(elementId: null) {
    ILayout defaultLayout = new HorizontalLayout();
    
    defaultLayout.gap = 0;
    
    layout = defaultLayout;
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
  
  void _commitProperties() {
    super._commitProperties();
    
    if (_headerContainer != null) {
      _headerContainer.height = _headerHeight;
    }
    
    if (_isColumnsChanged) {
      _isColumnsChanged = false;
      
      _updateElements();
    }
  }
  
  void _createChildren() {
    DivElement container = new DivElement();
    
    _scrollTarget = new Group();
    
    _scrollTarget.includeInLayout = false;
    
    _headerContainer = new HGroup(gap: 0)
    ..percentWidth = 100.0
    ..height = _headerHeight;
    
    _columnContainer = new HGroup(gap: 0)
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..verticalScrollPolicy = ScrollPolicy.AUTO
    ..add(_scrollTarget);
    
    _containerMain = new VGroup(gap: 0)
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..horizontalScrollPolicy = ScrollPolicy.AUTO
    ..add(_headerContainer)
    ..add(_columnContainer);
    
    _setControl(container);
    
    container.style.border = '1px solid #808080';
    container.style.backgroundColor = '#ffffff';
    
    add(_containerMain);
    
    super._createChildren();
  }
  
  void _removeAllElements() {
    super._removeAllElements();
    
    add(_containerMain);
  }
  
  void _updateElements() {
    if (_columnContainer != null) {
      DataGridColumn column;
      int len = _columns.length;
      int i;
      
      _removeAllElements();
      
      for (i=0; i<len; i++) {
        column = _columns[i];
        
        _createElement(column, i);
      }
      
      _scrollTarget.width = _width;
      _scrollTarget.height = _dataProvider.length * _rowHeight;
      
      _columnContainer._control.onScroll.listen(_container_scrollHandler);  
      
      _updateSelection();
    }
  }
  
  void _createElement(Object item, int index) {
    DataGridColumn column = item as DataGridColumn;
    
    column.dataProvider = _dataProvider;
    column.rowHeight = _rowHeight;
    column._hasOwnScroller = false;
    
    _columnContainer.add(column);
  }
  
  void _columns_collectionChangedHandler(FrameworkEvent event) {
    _isColumnsChanged = true;
    
    invalidateProperties();
  }
  
  void _container_scrollHandler(Event event) {
    DataGridColumn column;
    int len = _columns.length;
    int i;
    
    for (i=0; i<len; i++) {
      column = _columns[i];
      
      column.scrollPosition = _columnContainer._control.scrollTop;
      
      column.y = min(
          column._scrollPosition, 
          ((_dataProvider.length * _rowHeight) - _columnContainer._height)
      );
    }
    
    later > _updateLayout;
  }
}

class DataGridColumn extends ListRenderer {
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  // label
  //---------------------------------
  
  String _label;
  
  String get label => _label;
  set label(String value) {
    if (value != _label) {
      _label = value;
      
      dispatch(
        new FrameworkEvent(
          'labelChanged' 
        )    
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // headerItemRendererFactory
  //---------------------------------
  
  ClassFactory _headerItemRendererFactory;
  
  ClassFactory get headerItemRendererFactory => _headerItemRendererFactory;
  set headerItemRendererFactory(ClassFactory value) {
    if (value != _headerItemRendererFactory) {
      _headerItemRendererFactory = value;
      
      dispatch(
        new FrameworkEvent(
          'headerItemRendererFactoryChanged' 
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
  
  DataGridColumn() : super() {
    orientation = 'vertical';
  }
  
}

class DataGridHeaderItemRenderer extends ItemRenderer {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
  Group _container;
  RichText _label;
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  DataGridHeaderItemRenderer({String elementId: null}) : super(elementId: null) {
  }
  
  static DataGridHeaderItemRenderer construct() {
    return new DataGridHeaderItemRenderer();
  }
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  void createChildren() {
    _container = new HGroup()
    ..percentWidth = 100.0
    ..percentHeight = 100.0;
    
    _label = new RichText()
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..text = data as String;
    
    _container.add(_label);
    
    add(_container);
  }
  
  void invalidateData() {
    if (_label != null) {
      _label.text = data as String;
    }
  }
}