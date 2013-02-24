part of dartflex.collections;

class ListCollection extends FrameworkEventDispatcher implements IFrameworkEventDispatcher {
  
  Map _collapseMap = new Map();
  List<Map> _unrolledHierarchy;

  //-----------------------------------
  //
  // Public properties
  //
  //-----------------------------------

  //-----------------------------------
  // source
  //-----------------------------------

  List _source;

  List get source => _source;

  //-----------------------------------
  // length
  //-----------------------------------
  
  int get length => _source.length;
  
  //-----------------------------------
  // hierarchicalLength
  //-----------------------------------
  
  bool _isCachedHierarchicalLengthInvalid = true;
  int _cachedHierarchicalLength = 0;

  int get hierarchicalLength {
    if (_hierarchyHandler != null) {
      if (_isCachedHierarchicalLengthInvalid) {
        return getHierarchicalLength();
      } else {
        return _cachedHierarchicalLength;
      }
    }
    
    return _source.length;
  }
  
  //---------------------------------
  // hierarchyHandler
  //---------------------------------

  Function _hierarchyHandler;

  Function get hierarchyHandler => _hierarchyHandler;
  set hierarchyHandler(Function value) {
    if (!FunctionEqualityUtil.equals(value, _hierarchyHandler)) {
      _hierarchyHandler = value;

      _invalidate(isLengthInvalid: true);
    }
  }

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  ListCollection({Iterable source: null}) {
    if (source == null) {
      source = [];
    }

    _source = source;
  }

  //-----------------------------------
  //
  // Operator overloads
  //
  //-----------------------------------

  Object operator [](int index) => getItemAt(index);
  int operator +(Object item) => addItem(item);
  int operator -(Object item) => removeItem(item);
  ListCollection operator -() => reverse();
  ListCollection operator &(ListCollection collection) => concat(collection);
  ListCollection operator |(ListCollection collection) => this;

  //-----------------------------------
  //
  // Public methods
  //
  //-----------------------------------
  
  bool getCollapsedForData(Map data) {
    dynamic status = _collapseMap[data];
    
    if (status == null) {
      return false;
    }
    
    return (status as bool);
  }
  
  void setCollapsedForData(Map data, {bool collapsed: true}) {
    bool isUpdate = (collapsed != (_collapseMap[data] as bool));
    
    _collapseMap[data] = collapsed;
    
    if (isUpdate) {
      _invalidate();
    }
  }
  
  String getHierarchyKey(Map data) {
    if (_hierarchyHandler != null) {
      return _hierarchyHandler(data);
    }
    
    return null;
  }
  
  int getHierarchicalLength({List<Map> unrolledHierarchy: null}) {
    Map data;
    String childrenProperty;
    ListCollection childList;
    int currentLength = 0;
    
    _unrolledHierarchy = new List<Map>();
    
    if (unrolledHierarchy == null) {
      unrolledHierarchy = _unrolledHierarchy;
    }
    
    _source.forEach(
      (data) {
        childrenProperty = getHierarchyKey(data);
        
        unrolledHierarchy.add(data);
        
        currentLength++;
        
        if (
            (childrenProperty != null) &&
            !getCollapsedForData(data)
        ) {
          childList = data[childrenProperty] as ListCollection;
          
          childList.addEventListener(
              CollectionEvent.COLLECTION_CHANGED, 
              _hierarchy_collectionChangedHandler
          );
          
          currentLength += childList.getHierarchicalLength(unrolledHierarchy: unrolledHierarchy);
        }
      }    
    );
    
    _cachedHierarchicalLength = currentLength;
    _isCachedHierarchicalLengthInvalid = false;
    
    return currentLength;
  }

  int addItem(Object item) {
    Object obj = new Object();

    _source.addLast(item);

    _invalidate();

    return length;
  }

  Object getItemAt(int index, {bool hierarchicalLookup: false}) {
    if (!hierarchicalLookup) {
      if (index < _source.length) {
        return _source[index];
      }
    } else {
      int len = getHierarchicalLength();
      
      if (index < len) {
        return _unrolledHierarchy[index];
      }
    }

    return null;
  }

  Object removeItemAt(int index) {
    if (index < _source.length) {
      Object item = getItemAt(index);

      _source.removeAt(index);

      _invalidate();

      return item;
    }

    return null;
  }

  int removeItem(Object item) {
    int i = _source.length;

    while (i > 0) {
      if (_source[--i] == item) {
        _source.removeAt(i);

        _invalidate();

        return length;
      }
    }

    return null;
  }

  int getItemIndex(Object item) {
    if (_source != null) {
      int i = _source.length;

      while (i > 0) {
        if (_source[--i] == item) {
          return i;
        }
      }
    }

    return -1;
  }

  void sort(Function compareFunction) {
    if (_source != null) {
      _source.sort(compareFunction);

      _invalidate(isLengthInvalid: false);
    }
  }

  ListCollection reverse() {
    return new ListCollection(source: _source.reversed);
  }

  ListCollection concat(ListCollection collection) {
    List newSource = [];

    newSource.addAll(_source);
    newSource.addAll(collection._source);

    return new ListCollection(source: newSource);
  }
  
  //-----------------------------------
  //
  // Protected methods
  //
  //-----------------------------------
  
  void _invalidate({bool isLengthInvalid: true}) {
    _isCachedHierarchicalLengthInvalid = isLengthInvalid;
    
    dispatch(
        new CollectionEvent(
            CollectionEvent.COLLECTION_CHANGED
        )
    );
  }
  
  void _hierarchy_collectionChangedHandler(FrameworkEvent event) {
    _isCachedHierarchicalLengthInvalid = true;
    
    dispatch(
        new CollectionEvent(
            CollectionEvent.COLLECTION_CHANGED
        )
    );
  }
}

