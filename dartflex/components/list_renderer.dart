part of dartflex.components;

class ListRenderer extends ListWrapper {
  
  List<IItemRenderer> _itemRenderers;
  Group _scrollTarget;
  bool _hasOwnScroller = true;
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  // orientation
  //---------------------------------
  
  String _orientation;
  bool _isOrientationChanged = false;
  
  String get orientation => _orientation;
  set orientation(String value) {
    if (value != _orientation) {
      _orientation = value;
      _isOrientationChanged = true;
      
      dispatch(
        new FrameworkEvent(
          'orientationChanged' 
        )    
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // itemRenderer
  //---------------------------------
  
  ClassFactory _itemRendererFactory;
  
  ClassFactory get itemRendererFactory => _itemRendererFactory;
  set itemRendererFactory(ClassFactory value) {
    if (value != _itemRendererFactory) {
      _itemRendererFactory = value;
      
      dispatch(
        new FrameworkEvent(
          'itemRendererFactoryChanged' 
        )    
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // colWidth
  //---------------------------------
  
  int _colWidth = 0;
  
  int get colWidth => _colWidth;
  set colWidth(int value) {
    if (value != _colWidth) {
      _colWidth = value;
      
      dispatch(
        new FrameworkEvent(
          'colWidthChanged' 
        )    
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // colPercentWidth
  //---------------------------------
  
  double _colPercentWidth = .0;
  
  double get colPercentWidth => _colPercentWidth;
  set colPercentWidth(double value) {
    if (value != _colPercentWidth) {
      _colPercentWidth = value;
      
      dispatch(
        new FrameworkEvent(
          'colPercentWidthChanged' 
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
  // rowPercentHeight
  //---------------------------------
  
  double _rowPercentHeight = .0;
  
  double get rowPercentHeight => _rowPercentHeight;
  set rowPercentHeight(double value) {
    if (value != _rowPercentHeight) {
      _rowPercentHeight = value;
      
      dispatch(
        new FrameworkEvent(
          'rowPercentHeightChanged' 
        )    
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // scrollPosition
  //---------------------------------
  
  int _scrollPosition = 0;
  
  int get scrollPosition => _scrollPosition;
  set scrollPosition(int value) {
    if (value != _scrollPosition) {
      _scrollPosition = value;
      
      dispatch(
        new FrameworkEvent(
          'scrollPositionChanged' 
        )    
      );
      
      _updateVisibleItemRenderers();
      _updateLayout();
    }
  }
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  ListRenderer({String orientation: 'vertical'}) : super(elementId: null) {
    this.orientation = orientation;
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
    ILayout defaultLayout;
    
    if (_isOrientationChanged) {
      if (orientation == 'horizontal') {
        defaultLayout = new HorizontalLayout();
        
        _rowHeight = 0;
        _rowPercentHeight = 100.0;
        
        horizontalScrollPolicy = _hasOwnScroller ? ScrollPolicy.AUTO : ScrollPolicy.NONE;
        verticalScrollPolicy = ScrollPolicy.NONE;
      } else if (orientation == 'vertical') {
        defaultLayout = new VerticalLayout();
        
        _colWidth = 0;
        _colPercentWidth = 100.0;
        
        horizontalScrollPolicy = ScrollPolicy.NONE;
        verticalScrollPolicy = _hasOwnScroller ? ScrollPolicy.AUTO : ScrollPolicy.NONE;
      }
      
      defaultLayout.useVirtualLayout = true;
      defaultLayout.gap = 0;
      
      layout = defaultLayout;
    }
    
    super._commitProperties();
  }
  
  void _createChildren() {
    DivElement container = new DivElement();
    
    _scrollTarget = new Group();
    
    _scrollTarget.includeInLayout = false;
    
    add(_scrollTarget);
    
    _setControl(container);
    
    container.style.border = '1px solid #808080';
    container.style.backgroundColor = '#ffffff';
    
    container.onScroll.listen(_container_scrollHandler);
    
    super._createChildren();
  }
  
  void _removeAllElements() {
    if (_itemRenderers != null) {
      _itemRenderers.removeAll(_itemRenderers);
    }
    
    removeAll();
  }
  
  void _createElement(Object item, int index) {
    if (_itemRenderers == null) {
      _itemRenderers = new List<IItemRenderer>();
    }
    
    IItemRenderer renderer = _itemRendererFactory.immediateIntance();
    
    if (_colWidth > 0) {
      renderer.width = _colWidth;
    } else {
      renderer.percentWidth = _colPercentWidth;
    }
    
    if (_rowHeight > 0) {
      renderer.height = _rowHeight;
    } else {
      renderer.percentHeight = _rowPercentHeight;
    }
    
    _itemRenderers.add(renderer);
    
    renderer['controlChanged'] = _itemRenderer_controlChangedHandler;
    
    add(renderer);
    
    /*Future rendererFuture = _itemRendererFactory.futureInstance();
    
    rendererFuture.then(
      (Object result) {
        IItemRenderer renderer;
        
        if (result is InstanceMirror) {
          renderer = instanceMirror.reflectee as IItemRenderer;
        } else if (result is IItemRenderer) {
          renderer = result as IItemRenderer;
        }
        
        Object dataToSet = (_labelFunction != null) ? _labelFunction(item) : item;
        
        if (_colWidth > 0) {
          renderer.width = _colWidth;
        } else {
          renderer.percentWidth = _colPercentWidth;
        }
        
        if (_rowHeight > 0) {
          renderer.height = _rowHeight;
        } else {
          renderer.percentHeight = _colPercentHeight;
        }
        
        renderer.data = dataToSet;
        
        _itemRenderers.add(renderer);
        
        renderer['controlChanged'] = _itemRenderer_controlChangedHandler;
        
        add(renderer);
      }
    );*/
  }
  
  int _getPageItemSize() {
    if (
        (_dataProvider == null) ||
        (_dataProvider.length == 0)
    ) {
      return super._getPageItemSize();
    }
    
    return (_layout is VerticalLayout) ? _rowHeight : _colWidth;
  }
  
  int _getPageOffset() {
    return _hasOwnScroller ? _scrollPosition : 0;
  }
  
  int _getPageSize() {
    return (_dataProvider.length * _getPageItemSize());
  }
  
  void _updateElements() {
    if (
        (_itemRendererFactory != null) &&
        (
            (_colWidth > 0) ||
            (_colPercentWidth > .0)
        ) &&
        (
            (_rowHeight > 0) ||
            (_rowPercentHeight > .0)
        )
    ) {
      bool isVerticalLayout = (_layout is VerticalLayout);
      int elementsRequired;
      
      if (isVerticalLayout) {
        elementsRequired = min(
            ((_height / _rowHeight).toInt() + 2),
            _dataProvider.length
        );
      } else {
        elementsRequired = min(
            ((_width / _colWidth).toInt() + 2),
            _dataProvider.length
        );
      }
      
      Object element;
      int existingLen = (_itemRenderers != null) ? _itemRenderers.length : 0;
      int len = elementsRequired - existingLen;
      int i;
      
      for (i=0; i<len; i++) {
        _createElement(null, -1);
      }
      
      if (isVerticalLayout) {
        _scrollTarget.width = _width;
        _scrollTarget.height = _dataProvider.length * _rowHeight;
      } else {
        _scrollTarget.width = _dataProvider.length * _colWidth;
        _scrollTarget.height = _height;
      }
      
      if (len > 0) {
        _updateVisibleItemRenderers();
        _updateLayout();
      }
    }
  }
  
  void _updateLayout() {
    _updateElements();
    
    later > super._updateLayout;
  }
  
  void _updateVisibleItemRenderers() {
    Object data;
    IItemRenderer renderer;
    int dpLen = _dataProvider.length;
    int firstIndex = (_scrollPosition / _getPageItemSize()).toInt();
    int len = firstIndex + _itemRenderers.length;
    int rendererIndex = 0;
    int i;
    
    for (i=firstIndex; i<len; i++) {
      renderer = _itemRenderers[rendererIndex++];
      
      if (i < dpLen) {
        data = _dataProvider[i];
        
        renderer.includeInLayout = true;
        renderer._control.hidden = false;
        renderer.selected = (i == _selectedIndex);
      } else {
        renderer.includeInLayout = false;
        renderer._control.hidden = true;
        renderer.selected = false;
        
        data = null;
      }
      
      renderer.data = ((_labelFunction != null) && (data != null)) ? _labelFunction(data) : data;
      renderer.invalidateData();
    }
  }
  
  void _handleMouseInteraction(Event event) {
    IItemRenderer renderer;
    Object newSelectedItem;
    Element target = event.currentTarget as Element;
    int firstIndex = (_scrollPosition / _getPageItemSize()).toInt();
    int i = _itemRenderers.length;
    
    while (i > 0) {
      renderer = _itemRenderers[--i];
      
      if (event.type == 'mousedown') {
        if (renderer.control == target) {
          selectedIndex = firstIndex + i;
          
          newSelectedItem = _dataProvider[selectedIndex];
          
          renderer.selected = true;
        } else {
          renderer.selected = false;
        }
      } else {
        if (renderer.control == target) {
          renderer.state = event.type;
        } else {
          renderer.state = 'mouseout';
        }
      }
    }
    
    selectedItem = newSelectedItem;
  }
  
  void _container_scrollHandler(Event event) {
    scrollPosition = (_layout is VerticalLayout) ? _control.scrollTop : _control.scrollLeft;
  }
  
  void _itemRenderer_controlChangedHandler(FrameworkEvent event) {
    DivElement renderer = event.relatedObject as DivElement;
    
    renderer.onMouseOver.listen(_handleMouseInteraction);
    renderer.onMouseOut.listen(_handleMouseInteraction);
    renderer.onMouseDown.listen(_handleMouseInteraction);
    renderer.onMouseUp.listen(_handleMouseInteraction);
  }
}



