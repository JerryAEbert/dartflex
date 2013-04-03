part of dartflex;

class DataGrid extends ListWrapper {

  //---------------------------------
  //
  // Private properties
  //
  //---------------------------------

  List<IItemRenderer> _headerItemRenderers;

  VGroup _gridContainer;
  HGroup _headerContainer;
  ListRenderer _list;

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
        _columns.ignore(
            CollectionEvent.COLLECTION_CHANGED,
            _columns_collectionChangedHandler
        );
      }

      _columns = value;
      _isColumnsChanged = true;

      if (value != null) {
        value.observe(
            CollectionEvent.COLLECTION_CHANGED,
            _columns_collectionChangedHandler
        );
      }

      notify(
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

      notify(
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

  int _rowHeight = 30;

  int get rowHeight => _rowHeight;
  set rowHeight(int value) {
    if (value != _rowHeight) {
      _rowHeight = value;

      notify(
        new FrameworkEvent(
          'rowHeightChanged'
        )
      );

      invalidateProperties();
    }
  }

  //---------------------------------
  // columnSpacing
  //---------------------------------

  int _columnSpacing = 1;

  int get columnSpacing => _columnSpacing;
  set columnSpacing(int value) {
    if (value != _columnSpacing) {
      _columnSpacing = value;

      notify(
        new FrameworkEvent(
          'columnSpacingChanged'
        )
      );

      invalidateProperties();
    }
  }

  //---------------------------------
  // rowSpacing
  //---------------------------------

  int _rowSpacing = 1;

  int get rowSpacing => _rowSpacing;
  set rowSpacing(int value) {
    if (value != _rowSpacing) {
      _rowSpacing = value;

      notify(
        new FrameworkEvent(
          'rowSpacingChanged'
        )
      );

      invalidateProperties();
    }
  }
  
  //---------------------------------
  // useSelectionEffects
  //---------------------------------

  bool _useSelectionEffects = true;
  bool _isUseSelectionEffectsChanged = false;

  bool get useSelectionEffects => _useSelectionEffects;
  set useSelectionEffects(bool value) {
    if (value != _useSelectionEffects) {
      _useSelectionEffects = value;
      _isUseSelectionEffectsChanged = true;

      notify(
        new FrameworkEvent(
          'useSelectionEffectsChanged'
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
	_className = 'DataGrid';
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
    final DivElement container = new DivElement();

    _gridContainer = new VGroup(gap: 0)
    ..percentWidth = 100.0
    ..percentHeight = 100.0;

    _headerContainer = new HGroup(gap: _columnSpacing)
    ..percentWidth = 100.0
    ..height = _headerHeight
    ..autoSize = false;

    _list = new ListRenderer(orientation: 'grid')
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..colPercentWidth = 100.0
    ..rowSpacing = _rowSpacing
    ..rowHeight = _rowHeight
    ..dataProvider = _dataProvider
    ..itemRendererFactory = new ClassFactory(constructorMethod: DataGridItemRenderer.construct)
    ..useSelectionEffects = _useSelectionEffects;

    _gridContainer.add(_headerContainer);
    _gridContainer.add(_list);

    add(_gridContainer);

    _setControl(container);

    _list.observe(
      'rendererAdded',
      _list_rendererAddedHandler
    );

    super._createChildren();
  }

  void _commitProperties() {
    super._commitProperties();

    if (_isColumnsChanged) {
      _isColumnsChanged = false;

      _updateColumnsAndHeaders();
    }
    
    if (_isUseSelectionEffectsChanged) {
      _isUseSelectionEffectsChanged = false;
      
      if (_list != null) {
        _list.useSelectionEffects = _useSelectionEffects;
      }
    }
  }
  
  void _updateScrollPolicy() {
    super._updateScrollPolicy();
    
    if (_horizontalScrollPolicy == ScrollPolicy.NONE) {
      _list.ignore(
          'scrollChanged',
          _list_scrollChangedHandler
      );
    } else {
      _list.observe(
          'scrollChanged',
          _list_scrollChangedHandler
      );
    }
  }

  void _removeAllElements() {
    if (_headerItemRenderers != null) {
      _headerItemRenderers.removeAll(_headerItemRenderers);
    }
    
    if (_headerContainer != null) {
      _headerContainer.removeAll();
    }
  }

  void _updateElements() {
    if (_list != null) {
      _list.dataProvider = _dataProvider;
    }
  }

  void _updateColumnsAndHeaders() {
    if (_headerContainer == null) {
      return;
    }
    
    DataGridColumn column;
    DataGridItemRenderer renderer;
    IItemRenderer header;
    int i, len;

    _removeAllElements();

    _headerItemRenderers = new List<IItemRenderer>();

    if (_columns != null) {
      len = _columns.length;

      for (i=0; i<len; i++) {
        column = _columns[i] as DataGridColumn;

        header = column.headerItemRendererFactory.immediateInstance()
          ..height = _headerHeight
          ..data =  column.headerData
          ..['click'] = _header_clickHandler;

        if (column.width > 0) {
          header.width = column.width;
        } else {
          header.percentWidth = column.percentWidth;
        }

        _headerContainer.add(header);
      }

      if (
          (_list != null) &&
          (_list._itemRenderers != null)
      ) {
        _list._itemRenderers.forEach(
          (renderer) {
            renderer.gap = _columnSpacing;
            renderer.columns = _columns;
          }
        );
      }
    }
  }

  void _header_clickHandler(FrameworkEvent event) {
    final String property = event.relatedObject['property'];

    if (event.relatedObject['isAscSort'] == null) {
      event.relatedObject['isAscSort'] = true;
    }

    final bool isAscSort = event.relatedObject['isAscSort'];
    
    _dataProvider.sort(
        (Map itemA, Map itemB) {
          if (isAscSort) {
            return itemA[property].compareTo(itemB[property]);
          } else {
            return itemB[property].compareTo(itemA[property]);
          }
        }
    );

    event.relatedObject['isAscSort'] = !isAscSort;
  }

  void _updateLayout() {
    if (_list != null) {
      DataGridColumn column;
      int i = _columns.length;
      int w = 0;
      int tw = 0;
      int remainingWidth = 0;
      double procCount = .0;

      while (i > 0) {
        column = _columns[--i];

        if (column.percentWidth > .0) {
          procCount += column.percentWidth;

          tw += column.minWidth;
        } else if (column.width > .0) {
          w += column.width + ((i > 0) ? _columnSpacing : 0);
        }
      }

      i = _columns.length;

      tw += w;

      remainingWidth = _width - w;

      remainingWidth = (remainingWidth < 0) ? 0 : remainingWidth;

      if (procCount > .0) {
        while (i > 0) {
          column = _columns[--i];

          if (column.percentWidth > .0) {
            w += max(column.minWidth, (remainingWidth * column.percentWidth / procCount).toInt());
          }
        }
      }

      _list.rowHeight = _rowHeight;
      _list.colWidth = w;
      _list.horizontalScrollPolicy = (tw > _width) ? ScrollPolicy.AUTO : ScrollPolicy.NONE;

      if (_headerContainer != null) {
        _headerContainer.width = w;
        _headerContainer.height = _headerHeight;
      }
    }

    super._updateLayout();
  }

  void _list_rendererAddedHandler(FrameworkEvent event) {
    final DataGridItemRenderer renderer = event.relatedObject as DataGridItemRenderer
      ..gap = _columnSpacing
      ..columns = _columns;

    invalidateProperties();
  }

  void _list_scrollChangedHandler(FrameworkEvent event) => _reflowManager.scheduleMethod(this, _updateHeaderContainerPosition, []);
  
  void _updateHeaderContainerPosition() {
    _headerContainer.x = -_list._control.scrollLeft;
  }

  void _columns_collectionChangedHandler(FrameworkEvent event) {
    _isColumnsChanged = true;

    invalidateProperties();
  }

  void _dataProvider_collectionChangedHandler(FrameworkEvent event) {
    super._dataProvider_collectionChangedHandler(event);

    if (_list != null) {
      _list._updateVisibleItemRenderers();
    }
  }
}