part of dartflex.collections;

class ListCollection extends FrameworkEventDispatcher implements IFrameworkEventDispatcher {
  
  //-----------------------------------
  //
  // Public properties
  //
  //-----------------------------------
  
  //-----------------------------------
  // source
  //-----------------------------------
  
  Iterable _source;
  
  Iterable get source => _source;
  
  //-----------------------------------
  // length
  //-----------------------------------
  
  int get length => _source.length;
  
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
  
  Object operator [](int index) => _source[index];
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
  
  int addItem(Object item) {
    Object obj = new Object();
    
    _source.addLast(item);
    
    dispatch(
      new CollectionEvent(
          CollectionEvent.COLLECTION_CHANGED,
          relatedObject: item
      )
    );
    
    return _source.length;
  }
  
  Object getItemAt(int index) {
    if (index < _source.length) {
      return _source[index];
    }
    
    return null;
  }
  
  Object removeItemAt(int index) {
    if (index < _source.length) {
      Object item = getItemAt(index);
      
      _source.removeAt(index);
      
      dispatch(
          new CollectionEvent(
              CollectionEvent.COLLECTION_CHANGED,
              relatedObject: item
          )
      );
      
      return item;
    }
    
    return null;
  }
  
  int removeItem(Object item) {
    int i = _source.length;
    
    while (i > 0) {
      if (_source[--i] == item) {
        _source.removeAt(i);
        
        dispatch(
            new CollectionEvent(
                CollectionEvent.COLLECTION_CHANGED,
                relatedObject: item
            )
        );
        
        return _source.length;
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
      
      dispatch(
          new CollectionEvent(
              CollectionEvent.COLLECTION_CHANGED
          )
      );
    }
  }
  
  ListCollection reverse() {
    return new ListCollection(source: _source.reversed);
  }
  
  ListCollection concat(ListCollection collection) {
    Iterable newSource = [];
    
    newSource.addAll(_source);
    newSource.addAll(collection._source);
    
    return new ListCollection(source: newSource);
  }
}

