part of shoppinglist;

class BaseView extends VGroup implements IViewStackElement {
  
  static const EventHook<ViewStackEvent> onRequestViewChangeEvent = const EventHook<ViewStackEvent>(ViewStackEvent.REQUEST_VIEW_CHANGE);
  Stream<ViewStackEvent> get onRequestViewChange => BaseView.onRequestViewChangeEvent.forTarget(this);
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  // listName
  //---------------------------------
  
  static const EventHook<FrameworkEvent> onListNameChangedEvent = const EventHook<FrameworkEvent>('listNameChanged');
  Stream<FrameworkEvent> get onListNameChanged => BaseView.onListNameChangedEvent.forTarget(this);
  
  String _listName;
  bool _isListNameInvalid = false;
  
  String get listName => _listName;
  set listName(String value) {
    if (_listName != value) {
      _listName = value;
      _isListNameInvalid = true;
      
      notify(
          new FrameworkEvent(
            'listNameChanged'    
          )
      );
      
      invalidateProperties();
    }
  }
  
  //---------------------------------
  // header
  //---------------------------------
  
  Header _header;
  
  Header get header => _header;
  
  //---------------------------------
  // homeButton
  //---------------------------------
  
  Button _homeButton;
  
  Button get homeButton => _homeButton;
  
  //---------------------------------
  // settingsButton
  //---------------------------------
  
  Button _settingsButton;
  
  Button get settingsButton => _settingsButton;
  
  //---------------------------------
  // grid
  //---------------------------------
  
  DataGrid _grid;
  
  DataGrid get grid => _grid;
  
  //---------------------------------
  // footer
  //---------------------------------
  
  Footer _footer;
  
  Footer get footer => _footer;
  
  //---------------------------------
  // toggleRowSizeButton
  //---------------------------------
  
  Button _toggleRowSizeButton;
  
  Button get toggleRowSizeButton => _toggleRowSizeButton;
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------

  BaseView() : super(elementId: null, gap: 0) {
    onInitializationComplete.listen(_initializationCompleteHandler);
  }
  
  void _init() {
    _initHeader();
    _initGrid();
    _initFooter();
  }
  
  void _initHeader() {
    _header = new Header()
    ..percentWidth = 100.0
    ..height = 40
    ..label = _listName;
    
    _homeButton = new Button()
    ..inheritsDefaultCSS = false
    ..width = 32
    ..height = 32
    ..classes = ['backButton'];
    
    _settingsButton = new Button()
    ..inheritsDefaultCSS = false
    ..width = 32
    ..height = 32
    ..classes = ['options'];
    
    _header.leftSideItems + _homeButton;
    _header.rightSideItems + _settingsButton;
    
    _homeButton.onClick.listen(
        (FrameworkEvent event) => _requestView(sequentialView: ViewStackEvent.REQUEST_PREVIOUS_VIEW)
    );
    
    addComponent(_header);
  }
  
  void _initGrid() {}
  
  void _initFooter() {
    _footer = new Footer()
    ..percentWidth = 100.0
    ..height = 40;
    
    _toggleRowSizeButton = new Button()
    ..width = 40
    ..height = 40
    ..label = 'E';
    
    _toggleRowSizeButton.onClick.listen(
        (FrameworkEvent event) => _grid.rowHeight = (_grid.rowHeight == 60) ? 200 : 60
    );
    
    _footer.addComponent(_toggleRowSizeButton);
    
    addComponent(_footer);
  }
  
  void invalidateProperties() {
    super.invalidateProperties();
    
    later > _commitProperties;
  }
  
  void _commitProperties() {
    if (_isListNameInvalid) {
      _isListNameInvalid = false;
      
      if (_header != null) {
        _header.label = _listName;
      }
    }
  }
  
  void _requestView({String namedView: null, int sequentialView: -1}) {
    notify(
        new ViewStackEvent(
            ViewStackEvent.REQUEST_VIEW_CHANGE,
            relatedObject: this,
            namedView: namedView,
            sequentialView: sequentialView
        )
    );
  }
  
  void _initializationCompleteHandler(FrameworkEvent event) {
    _init();
  }
}

