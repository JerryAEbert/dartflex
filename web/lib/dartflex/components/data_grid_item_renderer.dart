part of dartflex.components;

class DataGridItemRenderer extends ItemRenderer {
  
  //---------------------------------
  //
  // Protected properties
  //
  //---------------------------------
  
  List<IItemRenderer> _itemRendererInstances;
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  // itemRenderers
  //---------------------------------
  
  ListCollection _columns;
  bool _isColumnsChanged = false;
  
  ListCollection get columns => _columns;
  set columns(ListCollection value) {
    if (value != _columns) {
      if (_columns != null) {
        _columns.removeEventListener(
            CollectionEvent.COLLECTION_CHANGED, 
            _itemRenderers_collectionChangedHandler
        );
      }
      
      _columns = value;
      _isColumnsChanged = true;
      
      if (value != null) {
        value.addEventListener(
            CollectionEvent.COLLECTION_CHANGED, 
            _itemRenderers_collectionChangedHandler
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
  //
  // Constructor
  //
  //---------------------------------
  
  DataGridItemRenderer({int gap: 0}) : super(elementId: null) {
    _gap = gap;
    
    _layout = new HorizontalLayout();
    
    _layout.gap = gap;
    
    percentWidth = 100.0;
  }
  
  static DataGridItemRenderer construct() {
    return new DataGridItemRenderer();
  }
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  void invalidateData() {
  }
  
  void _commitProperties() {
    super._commitProperties();
    
    if (_isColumnsChanged) {
      _isColumnsChanged = false;
      
      _updateItemRenderers();
    }
  }
  
  void _updateItemRenderers() {
    DataGridColumn column;
    IItemRenderer renderer;
    int i, len;
    
    removeAll();
    
    _itemRendererInstances = new List<IItemRenderer>();
    
    if (
      (_columns != null) &&
      (_columns.length > 0)
    ) {
      len = _columns.length;
      
      for (i=0; i<len; i++) {
        column = _columns[i];
        
        renderer = column.columnItemRendererFactory.immediateInstance();
        
        renderer.data = _data;
        
        if (column.percentWidth > .0) {
          renderer.percentWidth = column.percentWidth;
        } else {
          renderer.width = column.width;
        }
        
        renderer.percentHeight = 100.0;
        
        _itemRendererInstances.add(renderer);
        
        add(renderer);
      }
    }
  }
  
  void _invalidateData() {
    super._invalidateData();
    
    if (
        (_itemRendererInstances != null) &&
        (_itemRendererInstances.length > 0)
    ) {
      IItemRenderer renderer;
      int len = _itemRendererInstances.length;
      int i;
      
      for (i=0; i<len; i++) {
        renderer = _itemRendererInstances[i];
        
        renderer.data = _data;
      }
    }
  }
  
  void _itemRenderers_collectionChangedHandler() {
    _updateItemRenderers();
  }
  
  void _itemRendererSizes_collectionChangedHandler() {
    _invalidateData();
  }
  
  void _updateLayout() {
    _layout.gap = _gap;
    
    super._updateLayout();
  }
}





