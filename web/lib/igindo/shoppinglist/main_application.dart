part of shoppinglist;

class MainApplication {
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------

  //---------------------------------
  // viewStack
  //---------------------------------
  
  ViewStack _viewStack;
  
  ViewStack get viewStack => _viewStack;
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  MainApplication({String elementId: null}) {
    _viewStack = new ViewStack(elementId: elementId)
    ..percentWidth = 100.0
    ..percentHeight = 100.0;
    
    HomeView homeView = new HomeView()
    ..listName = 'home';
    IndividualList individualList = new IndividualList()
    ..listName = 'list';
    
    _viewStack.addView('home', homeView);
    _viewStack.addView('shoppingList', individualList);
    
    _viewStack.show('home');
  }
  
}

