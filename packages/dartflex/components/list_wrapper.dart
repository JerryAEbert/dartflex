part of dartflex.components;

class ListWrapper extends UIWrapper {
  
  bool _isElementUpdateRequired = false;
  bool _isScrollPolicyInvalid = false;
  
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
    _isElementUpdateRequired = true;
    
    if (value != null) {
      value.addEventListener(
          CollectionEvent.COLLECTION_CHANGED, 
          _dataProvider_collectionChangedHandler
      );
    }
    
    later > _commitProperties;
  }
  
  //---------------------------------
  // horizontalScrollPolicy
  //---------------------------------
  
  String _horizontalScrollPolicy = ScrollPolicy.NONE;
  
  String get horizontalScrollPolicy => _horizontalScrollPolicy;
  set horizontalScrollPolicy(Function value) {
    if (value != _horizontalScrollPolicy) {
      _horizontalScrollPolicy = value;
      
      _isScrollPolicyInvalid = true;
      
      dispatch(
        new FrameworkEvent(
          "horizontalScrollPolicyChanged"
        )
      );
      
      later > _commitProperties;
    }
  }
  
  //---------------------------------
  // verticalScrollPolicy
  //---------------------------------
  
  String _verticalScrollPolicy = ScrollPolicy.NONE;
  
  String get verticalScrollPolicy => _verticalScrollPolicy;
  set verticalScrollPolicy(Function value) {
    if (value != _verticalScrollPolicy) {
      _verticalScrollPolicy = value;
      
      _isScrollPolicyInvalid = true;
      
      dispatch(
        new FrameworkEvent(
          "verticalScrollPolicyChanged"
        )
      );
      
      later > _commitProperties;
    }
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
  // selectedIndex
  //---------------------------------
  
  int _selectedIndex = -1;
  
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value) {
    if (value != _selectedIndex) {
      _selectedIndex = value;
      
      dispatch(
          new FrameworkEvent(
            'selectedIndexChanged',
            relatedObject: value
          )
      );
      
      later > _updateSelection;
    }
  }
  
  //---------------------------------
  // selectedItem
  //---------------------------------
  
  Object _selectedItem;
  
  Object get selectedItem => _selectedItem;
  set selectedItem(Object value) {
    if (value != _selectedItem) {
      _selectedItem = value;
      
      dispatch(
          new FrameworkEvent(
            'selectedItemChanged',
            relatedObject: value
          )
      );
      
      later > _updateSelection;
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
  
  void _setControl(Element element) {
    super._setControl(element);
    
    _isElementUpdateRequired = true;
    _isScrollPolicyInvalid = true;
  }
  
  void _commitProperties() {
    super._commitProperties();
    
    if (_control != null) {
      if (_isElementUpdateRequired) {
        _isElementUpdateRequired = false;
        
        _updateElements();
      }
      
      if (_isScrollPolicyInvalid) {
        _isScrollPolicyInvalid = false;
        
        _updateScrollPolicy();
      }  
    }
  }
  
  void _removeAllElements() {
    while (_control.children.length > 0) {
      _control.children.removeLast();
    }
  }
  
  void _updateElements() {
    Object element;
    int len = _dataProvider.length;
    int i;
    
    _removeAllElements();
    
    for (i=0; i<len; i++) {
      element = _dataProvider[i];
      
      _createElement(element, i);
    }
    
    _updateSelection();
  }
  
  void _updateSelection() {
  }
  
  void _createElement(Object item, int index) {
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
  
  void _dataProvider_collectionChangedHandler(FrameworkEvent event) {
    _isElementUpdateRequired = true;
    
    later > _commitProperties;
  }
  
}

