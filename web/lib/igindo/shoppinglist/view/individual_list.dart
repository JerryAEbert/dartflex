part of shoppinglist;

class IndividualList extends BaseView {
  
  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------

  IndividualList() : super();
  
  void _initGrid() {
    _grid = new DataGrid()
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..headerHeight = 40
    ..rowHeight = 60
    ..columnSpacing = 0
    ..rowSpacing = 0
    ..useSelectionEffects = false
    ..dataProvider = createDataProvider(dpLen: 1000)
    ..columns = new ListCollection(
        source: [
                 new DataGridColumn()
                 ..minWidth = 120
                 ..percentWidth = 100.0
                 ..headerData = { 'label' : 'product', 'property' : 'product' }
                 ..headerItemRendererFactory = new ClassFactory(constructorMethod: HeaderItemRenderer.construct)
                 ..columnItemRendererFactory = new ClassFactory(constructorMethod: ProductItemRenderer.construct),

                 new DataGridColumn()
                 ..width = 120
                 ..headerData = { 'label' : 'tags', 'property' : 'tag' }
                 ..headerItemRendererFactory = new ClassFactory(constructorMethod: HeaderItemRenderer.construct)
                 ..columnItemRendererFactory = new ClassFactory(constructorMethod: TagItemRenderer.construct),

                 new DataGridColumn()
                 ..width = 120
                 ..headerData = { 'label' : 'have it', 'property' : 'rating' }
                 ..headerItemRendererFactory = new ClassFactory(constructorMethod: HeaderItemRenderer.construct)
                 ..columnItemRendererFactory = new ClassFactory(constructorMethod: ToggleItemRenderer.construct)
                 ]
    );
    
    add(_grid);
  }
  
  String getRandomProduct() {
    Random rnd = new Random();

    List<String> products = [
                             'lettuce', 'tomatoes', 'whole grain bread', 'grapes', 'paprika', 'pineapple', 'corned beef', 'coca cola', 'fanta', 'sprite', 'ice tea',
                             'eggs', 'rice', 'hamburgers', 'french fries', 'cookies (any)', 'chocolate', 'butter', 'cheese', 'salmon', 'chicken wings', 'water',
                             'toilet paper', 'shampoo', 'mineral water', 'soda', 'baking powder', 'diapers', 'cucumber', 'apples', 'union', 'sausage'
                             ];

    return products[rnd.nextInt(products.length)];
  }

  String getRandomTag() {
    Random rnd = new Random();

    List<String> tags = [
                         'dairy', 'sweets', 'fruits & veggies', 'bread', 'poultry', 'meat', 'fish', 'beverages', 'household', 'multimedia', 'press shop', 'liquors', 'cleaning'
                         ];

    return tags[rnd.nextInt(tags.length)];
  }

  String getRandomPhone() {
    Random rnd = new Random();

    int a = rnd.nextInt(9);
    int b = rnd.nextInt(9);
    int c = rnd.nextInt(9);
    int d = rnd.nextInt(9);
    int e = rnd.nextInt(9);
    int f = rnd.nextInt(9);
    int g = rnd.nextInt(9);
    int h = rnd.nextInt(9);
    int i = rnd.nextInt(9);

    return '5$b$c - $d$e$f$g$h$i';
  }

  Map createListItem(int index) {
    Map item = new Map();
    Random rnd = new Random();

    item['id'] = index;
    item['imageNumber'] = rnd.nextInt(229);
    item['rating'] = rnd.nextInt(5) + 1;
    item['product'] = getRandomProduct();
    item['tag'] = getRandomTag();
    item['phone'] = getRandomPhone();

    return item;
  }

  ListCollection createDataProvider({int dpLen: 10, String labelMain: 'Option:'}) {
    ListCollection dataProvider = new ListCollection();
    int i;

    for (i=0; i<dpLen; i++) {
      dataProvider + createListItem(i);
    }

    return dataProvider;
  }
}

