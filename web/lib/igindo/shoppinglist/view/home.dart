part of shoppinglist;

class HomeView extends BaseView {
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------

  HomeView() : super();
  
  void _initGrid() {
    TileGroup group = new TileGroup()
    ..percentWidth = 100.0
    ..percentHeight = 100.0;
    
    Button button = new Button()
    ..width = 60
    ..height = 60
    ..label = 'open list';
    
    button.onClick.listen(
        (FrameworkEvent event) => _requestView(sequentialView: ViewStackEvent.REQUEST_PREVIOUS_VIEW)
    );
    
    group.add(button);
    
    add(group);
  }
}

