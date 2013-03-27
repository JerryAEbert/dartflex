part of dartflex;

class ListRenderer extends ListWrapper {

  List<IItemRenderer> _itemRenderers;

  Group _scrollTarget;
  
  bool _hasScrolled = false;

  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------

  //---------------------------------
  // width
  //---------------------------------

  void set width(int value) {
    if (value != _width) {
      super.width = value;

      if (_dataProvider != null) {
        _updateAfterScrollPositionChanged();
      }
    }
  }

  //---------------------------------
  // height
  //---------------------------------

  void set height(int value) {
    if (value != _height) {
      super.height = value;

      if (_dataProvider != null) {
        _updateAfterScrollPositionChanged();
      }
    }
  }

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

      notify(
        new FrameworkEvent(
          'orientationChanged'
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
  // itemRenderer
  //---------------------------------

  ClassFactory _itemRendererFactory;

  ClassFactory get itemRendererFactory => _itemRendererFactory;
  set itemRendererFactory(ClassFactory value) {
    if (value != _itemRendererFactory) {
      _itemRendererFactory = value;

      notify(
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

      notify(
        new FrameworkEvent(
          'colWidthChanged'
        )
      );

      _updateAfterScrollPositionChanged();
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

      notify(
        new FrameworkEvent(
          'colPercentWidthChanged'
        )
      );

      _updateAfterScrollPositionChanged();
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

      notify(
        new FrameworkEvent(
          'rowHeightChanged'
        )
      );

      _updateAfterScrollPositionChanged();
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

      notify(
        new FrameworkEvent(
          'rowPercentHeightChanged'
        )
      );

      _updateAfterScrollPositionChanged();
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

      notify(
        new FrameworkEvent(
          'scrollPositionChanged'
        )
      );

      _updateAfterScrollPositionChanged();
    }
  }

  //---------------------------------
  // rowSpacing
  //---------------------------------

  int _rowSpacing = 0;

  int get rowSpacing => _rowSpacing;
  set rowSpacing(int value) {
    if (value != _rowSpacing) {
      _rowSpacing = value;

      invalidateProperties();
    }
  }

  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------

  ListRenderer({String orientation: 'vertical'}) : super(elementId: null) {
  	_className = 'ListRenderer';
	
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
      _isOrientationChanged = false;
      
      if (orientation == 'horizontal') {
        defaultLayout = new HorizontalLayout();

        _rowHeight = 0;
        _rowPercentHeight = 100.0;

        horizontalScrollPolicy = ScrollPolicy.AUTO;
        verticalScrollPolicy = ScrollPolicy.NONE;
      } else if (orientation == 'vertical') {
        defaultLayout = new VerticalLayout();

        _colWidth = 0;
        _colPercentWidth = 100.0;

        horizontalScrollPolicy = ScrollPolicy.NONE;
        verticalScrollPolicy = ScrollPolicy.AUTO;
      } else if (orientation == 'grid') {
        defaultLayout = new VerticalLayout(constrainToBounds: false);

        _colWidth = 0;
        _colPercentWidth = 100.0;

        verticalScrollPolicy = ScrollPolicy.AUTO;
      }

      defaultLayout.useVirtualLayout = true;
      defaultLayout.gap = _rowSpacing;

      layout = defaultLayout;
    }

    if (_layout != null) {
      _layout.gap = _rowSpacing;
    }
    
    if (_isUseSelectionEffectsChanged) {
      _isUseSelectionEffectsChanged = false;
      
      _itemRenderers.forEach(
        (IItemRenderer renderer) => renderer.autoDrawBackground = _useSelectionEffects    
      );
    }

    super._commitProperties();
  }

  void _createChildren() {
    final DivElement container = new DivElement()
    ..onScroll.listen(_container_scrollHandler)
    ..onTouchMove.listen(_container_scrollHandler)
    ..onTouchCancel.listen(_container_scrollHandler)
    ..onTouchEnd.listen(_container_scrollHandler)
    ..onTouchLeave.listen(_container_scrollHandler)
    ..onTouchStart.listen(_container_scrollHandler)
    ..onTouchEnter.listen(_container_scrollHandler)
    ..onMouseWheel.listen(_container_scrollHandler);

    _scrollTarget = new Group();

    _scrollTarget.autoSize = false;
    _scrollTarget.includeInLayout = false;

    add(_scrollTarget);

    _setControl(container);

    _reflowManager.invalidateCSS(container, 'border', '1px solid rgb(128, 128, 128)');
    _reflowManager.invalidateCSS(container, 'background-color', 'rgb(255, 255, 255)');

    super._createChildren();
  }

  void _removeAllElements() {
    if (_itemRenderers != null) {
      _itemRenderers.removeAll(_itemRenderers);
    }

    removeAll();

    add(_scrollTarget);
  }

  void _updateRenderer(IItemRenderer renderer) {
    if (_colWidth > 0) {
      renderer.width = _colWidth;
    } else if (_colPercentWidth > .0) {
      renderer.percentWidth = _colPercentWidth;
    }

    if (_rowHeight > 0) {
      renderer.height = _rowHeight;
    } else if (_rowPercentHeight > .0) {
      renderer.percentHeight = _rowPercentHeight;
    }
  }

  void _createElement(Object item, int index) {
    if (_itemRenderers == null) {
      _itemRenderers = new List<IItemRenderer>();
    }

    final IItemRenderer renderer = _itemRendererFactory.immediateInstance()
      ..index = index
      ..autoDrawBackground = _useSelectionEffects;

    _updateRenderer(renderer);

    _itemRenderers.add(renderer);

    renderer['controlChanged'] = _itemRenderer_controlChangedHandler;

    add(renderer);

    notify(
        new FrameworkEvent(
            'rendererAdded',
            relatedObject: renderer
        )
    );

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
    return _scrollPosition;
  }

  int _getPageSize() {
    return (_dataProvider.length * _getPageItemSize());
  }

  void remove(IUIWrapper element) {
    super.remove(element);

    if (_itemRenderers != null) {
      _itemRenderers.remove(element);
    }
  }

  bool _updateElements() {
    final bool hasWidth = ((_colWidth > 0) || (_colPercentWidth > .0));
    final bool hasHeight = ((_rowHeight > 0) || (_rowPercentHeight > .0));

    if (
        (_itemRendererFactory != null) &&
        hasWidth &&
        hasHeight
    ) {
      final bool isVerticalLayout = (_layout is VerticalLayout);
      int elementsRequired;

      if (isVerticalLayout) {
        elementsRequired = min(
            (_height ~/ _rowHeight + 2),
            _dataProvider.length
        );
      } else {
        elementsRequired = min(
            (_width ~/ _colWidth + 2),
            _dataProvider.length
        );
      }

      Object element;
      final int existingLen = (_itemRenderers != null) ? _itemRenderers.length : 0;
      final int len = elementsRequired - existingLen;
      int i;

      for (i=len; i<0; i++) {
        remove(_itemRenderers.removeLast());
      }

      for (i=0; i<len; i++) {
        _createElement(null, i);
      }

      if (_scrollTarget != null) {
        if (isVerticalLayout) {
          _scrollTarget.width = 1;

          if (_rowHeight > 0) {
            _scrollTarget.height = _dataProvider.length * _rowHeight;
          }
        } else {
          if (_colWidth > 0) {
            _scrollTarget.width = _dataProvider.length * _colWidth;
          }

          _scrollTarget.height = 1;
        }
      }

      if (len > 0) {
        _updateAfterScrollPositionChanged();

        return true;
      }
    }

    return false;
  }

  void _updateAfterScrollPositionChanged() {
    if (
        (_dataProvider != null) &&
        !_updateElements()
    ) {
      _updateVisibleItemRenderers();
    }

    _updateLayout();
  }

  void _updateVisibleItemRenderers() {
    final List<IUIWrapper> newChildren = new List<IUIWrapper>();
    final List<Element> elementsToSort = new List<Element>();
    final int dpLen = _dataProvider.length;
    final int firstIndex = _scrollPosition ~/ _getPageItemSize();
    final int irLen = _itemRenderers.length;
    final int len = firstIndex + irLen;

    dynamic data, actualData;
    IItemRenderer renderer;
    int rendererIndex = 0;
    int i;

    //
    // START: sort the renderers, this will minimize the amount of updates needed when recycling
    //

    _itemRenderers.sort(
      (IItemRenderer rendererA, IItemRenderer rendererB) {
        int sortIndexA = rendererA.index - firstIndex;
        int sortIndexB = rendererB.index - firstIndex;

        if (sortIndexA >= irLen) {
          sortIndexA = -sortIndexA;
        } else if (sortIndexA < 0) {
          sortIndexA += 1000000;
        }

        if (sortIndexB >= irLen) {
          sortIndexB = -sortIndexB;
        } else if (sortIndexB < 0) {
          sortIndexB += 1000000;
        }

        return sortIndexA.compareTo(sortIndexB);
      }
    );

    for (i=0; i<irLen; i++) {
      newChildren.add(_itemRenderers[i]);
    }

    _children.removeAll(newChildren);
    _children.addAll(newChildren);

    //
    // END
    //

    for (i=firstIndex; i<len; i++) {
      renderer = _itemRenderers[rendererIndex++]
        ..index = i;

      _updateRenderer(renderer);

      if (i < dpLen) {
        data = _dataProvider[i];

        renderer.includeInLayout = true;
        renderer.visible = true;
        renderer.selected = (i == _selectedIndex);
      } else {
        renderer.includeInLayout = false;
        renderer.visible = false;
        renderer.selected = false;

        data = null;
      }
      
      renderer.data = ((_labelFunction != null) && (data != null)) ? _labelFunction(data) : data;
    }
  }

  void _handleMouseInteraction(Event event) {
    final Element target = event.currentTarget as Element;
    final int firstIndex = _scrollPosition ~/ _getPageItemSize();

    IItemRenderer renderer;
    Object newSelectedItem;
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

  void _container_scrollHandler(Event event) => _reflowManager.scheduleMethod(this, _updateScrollPosition, []);
  
  void _updateScrollPosition() {
    _hasScrolled = true;
    
    scrollPosition = (_layout is VerticalLayout) ? _control.scrollTop : _control.scrollLeft;
    
    notify(
        new FrameworkEvent(
            'scrollChanged',
            relatedObject: _control
        )
    );
  }

  void _dataProvider_collectionChangedHandler(FrameworkEvent event) {
    _updateAfterScrollPositionChanged();
  }

  void _itemRenderer_controlChangedHandler(FrameworkEvent event) {
    final DivElement renderer = event.relatedObject as DivElement;

    renderer.onMouseOver.listen(_handleMouseInteraction);
    renderer.onMouseOut.listen(_handleMouseInteraction);
    renderer.onMouseDown.listen(_handleMouseInteraction);
    renderer.onMouseUp.listen(_handleMouseInteraction);
  }
}



