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
    
    IndividualList individualList = new IndividualList()
    ..listName = 'screen 1';
    IndividualList individualList2 = new IndividualList()
    ..listName = 'screen 2';
    
    _viewStack.addView('shoppingList1', individualList);
    _viewStack.addView('shoppingList2', individualList2);
    
    _viewStack.show('shoppingList1');
  }
  
}

