part of dartflex.components;

class ListWrapper extends UIWrapper {
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  // dataProvider
  //---------------------------------
  
  ListCollection _dataProvider;
  
  ListCollection get dataProvider => _dataProvider;
  set dataProvider(ListCollection value) {
    if (_dataProvider != null) {
      _dataProvider.removeEventListener(
          CollectionEvent.COLLECTION_CHANGED, 
          _dataProvider_collectionChangedHandler
      );
    }
    
    _dataProvider = value;
    
    if (value != null) {
      value.addEventListener(
          CollectionEvent.COLLECTION_CHANGED, 
          _dataProvider_collectionChangedHandler
      );
    }
    
    later > _updateElements;
  }
  
  //---------------------------------
  // labelFunction
  //---------------------------------
  
  Function _labelFunction;
  
  Function get labelFunction => _labelFunction;
  set labelFunction(Function value) {
    _labelFunction = value;
  }
  
  //---------------------------------
  // selectedItem
  //---------------------------------
  
  Object _selectedItem;
  
  Object get selectedItem => _selectedItem;
  set selectedItem(Object value) {
    if (value != _selectedItem) {
      _selectedItem = value;
      
      dispatchEvent(
          new FrameworkEvent(
            'selectedItemChanged',
            relatedObject: value
          )
      );
    }
  }
 
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  ListWrapper({String elementId: null}) : super(elementId: elementId) {
  }
  
  //---------------------------------
  //
  // Operator overloads
  //
  //---------------------------------
  
  int operator +(Object item) {
    if (_dataProvider == null) {
      dataProvider = new ListCollection();
    }
    
    return _dataProvider.addItem(item);
  }
  
  int operator -(Object item) {
    if (_dataProvider == null) {
      dataProvider = new ListCollection();
    }
    
    return _dataProvider.removeItem(item);
  }
  
  //---------------------------------
  //
  // Protected methods
  //
  //---------------------------------
  
  void _updateElements() {
    Object element;
    String itemToString;
    int len = _dataProvider.length;
    int i;
    
    _control.elements = [];
    
    for (i=0; i<len; i++) {
      element = _dataProvider[i];
      
      itemToString = _labelFunction(element);
      
      _control.elements.add(
          new OptionElement(
              itemToString, i.toString()
          )
      );
    }
  }
  
  void _dataProvider_collectionChangedHandler(FrameworkEvent event) {
    later > _updateElements;
  }
  
}

