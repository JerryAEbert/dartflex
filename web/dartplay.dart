import 'dart:html';
import 'dart:math';
import 'dart:uri';
import 'lib/dartflex/collections/collections.dart';
import 'lib/dartflex/components/components.dart';
import 'lib/dartflex/core/core.dart';
import 'lib/dartflex/events/events.dart';
import 'lib/dartflex/layout/layout.dart';
import 'lib/demo/demo.dart';

void main() {
  dataGridSetup();
  //initContainer01();
  //initContainer02();
  
  /*
  
  label.graphics.context.beginPath();
  
  label.graphics.context.fillStyle = '#ff9900';
  
  label.graphics.context.moveTo(0, 0);
  label.graphics.context.lineTo(50, 0);
  label.graphics.context.lineTo(50, 50);
  label.graphics.context.lineTo(0, 50);
  label.graphics.context.lineTo(0, 0);
  
  label.graphics.context.fill();
  
  label.graphics.context.closePath();*/
  
  //DivElement aaa; aaa.style.overflowWrap
}

void dataGridSetup() {
  DataGrid grid = new DataGrid()
  ..percentWidth = 100.0
  ..percentHeight = 100.0
  ..headerHeight = 30
  ..rowHeight = 30
  ..columnSpacing = 0
  ..rowSpacing = 0
  ..dataProvider = createDataProvider(dpLen: 5000)
  ..columns = new ListCollection(
    source: [
      new DataGridColumn()
      ..width = 60
      ..headerData = { 'label' : 'id', 'property' : 'id' }
      ..headerItemRendererFactory = new ClassFactory(constructorMethod: HeaderItemRenderer.construct)
      ..columnItemRendererFactory = new ClassFactory(constructorMethod: IdItemRenderer.construct),
      
      new DataGridColumn()
      ..width = 60
      ..headerData = { 'label' : '', 'property' : 'imageNumber' }
      ..headerItemRendererFactory = new ClassFactory(constructorMethod: HeaderItemRenderer.construct)
      ..columnItemRendererFactory = new ClassFactory(constructorMethod: ImageItemRenderer.construct),
      
      new DataGridColumn()
      ..width = 220
      ..headerData = { 'label' : 'full name', 'property' : 'fullname' }
      ..headerItemRendererFactory = new ClassFactory(constructorMethod: HeaderItemRenderer.construct)
      ..columnItemRendererFactory = new ClassFactory(constructorMethod: NameItemRenderer.construct),
      
      new DataGridColumn()
      ..width = 170
      ..headerData = { 'label' : 'job', 'property' : 'job' }
      ..headerItemRendererFactory = new ClassFactory(constructorMethod: HeaderItemRenderer.construct)
      ..columnItemRendererFactory = new ClassFactory(constructorMethod: JobItemRenderer.construct),
      
      new DataGridColumn()
      ..width = 154
      ..headerData = { 'label' : 'phone nr', 'property' : 'phone' }
      ..headerItemRendererFactory = new ClassFactory(constructorMethod: HeaderItemRenderer.construct)
      ..columnItemRendererFactory = new ClassFactory(constructorMethod: PhoneItemRenderer.construct),
      
      new DataGridColumn()
      ..width = 220
      ..headerData = { 'label' : 'manager', 'property' : 'manager' }
      ..headerItemRendererFactory = new ClassFactory(constructorMethod: HeaderItemRenderer.construct)
      ..columnItemRendererFactory = new ClassFactory(constructorMethod: ManagerItemRenderer.construct),
      
      new DataGridColumn()
      ..minWidth = 160
      ..percentWidth = 100.0
      ..headerData = { 'label' : 'rating', 'property' : 'rating' }
      ..headerItemRendererFactory = new ClassFactory(constructorMethod: HeaderItemRenderer.construct)
      ..columnItemRendererFactory = new ClassFactory(constructorMethod: RatingItemRenderer.construct)
    ]
  );
  
  /*_listRenderer = new ListRenderer(orientation: 'vertical')
  //..itemRendererFactory = new ClassFactory('dartflex.components', 'ItemRenderer')
  ..itemRendererFactory = new ClassFactory(constructorMethod: DemoItemRenderer.construct)
  ..width = 400
  ..percentHeight = 100.0
  ..rowHeight = 50
  ..dataProvider = createDataProvider(dpLen: 5000, labelMain: 'Employee nr.');*/
  //window.setImmediate(callback)
  HGroup container01 = new HGroup(elementId: '#target')
  ..width = 600
  ..percentHeight = 100.0
  ..add(grid);
}

/*void initContainer01() {
  VGroup divContainer = new VGroup(elementId: '#container01')
  ..percentWidth = 100.0
  ..percentHeight = 100.0;
  
  ComboBox box = new ComboBox()
  ..labelFunction = control_labelHandler
  ..width = 120
  ..height = 22
  ..dataProvider = createDataProvider();
  
  Button button = new Button()
  ..width = 100
  ..height = 22
  ..label = 'add item';
  
  button['click'] = (
      (FrameworkEvent event) {
        // on button click, add a new item directly to the dataProvider
        // the comboBox will auto-update
        ListItem item = createListItem(label: 'I\'m a new option! ', index: box.dataProvider.length);
        
        box.dataProvider + item;
        
        // alternatively, you could just type
        // box + item;
        // as well
      }
  );
  
  divContainer.add(button);
  divContainer.add(box);
}*/

/*void initContainerX() {
  VGroup container = new VGroup(elementId: '#container01')
    ..percentWidth = 100.0
    ..percentHeight = 100.0;
  
  HGroup topContainer = new HGroup()
    ..percentWidth = 100.0
    ..percentHeight = 100.0;
  HGroup middleContainer = new HGroup()
    ..percentWidth = 100.0
    ..height = 100;
  HGroup bottomContainer = new HGroup()
    ..percentWidth = 100.0
    ..height = 50;
  
  RichText label = new RichText()
    ..text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut justo ligula, suscipit id venenatis eu, dictum eu augue. Vestibulum et nibh arcu. Nullam gravida risus ac ipsum congue nec ullamcorper lorem iaculis. Vestibulum tellus sapien, interdum ut mollis eget, consequat a elit. Vestibulum eu libero ac leo aliquet blandit. Suspendisse eget erat vitae risus mattis bibendum. Integer diam nibh, egestas nec commodo quis, rutrum ut lacus. Duis pellentesque metus sit amet mauris facilisis sed aliquet sem ultrices. Suspendisse eget nisi nulla. Praesent rutrum, lorem at malesuada fringilla, est mi malesuada dui, eleifend cursus velit augue sed dolor. Nunc viverra risus a elit rutrum feugiat.'
    ..width = 100
    ..percentHeight = 100.0;
  Button button = new Button()
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..label = 'click me';
  ComboBox boxA = new ComboBox()
    ..labelFunction = control_labelHandler
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..dataProvider = createDataProvider();
  ComboBox boxB = new ComboBox()
    ..labelFunction = control_labelHandler
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..dataProvider = createDataProvider();
  ComboBox boxC = new ComboBox()
    ..labelFunction = control_labelHandler
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..dataProvider = createDataProvider();
  ComboBox boxD = new ComboBox()
    ..labelFunction = control_labelHandler
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..dataProvider = createDataProvider();
  ComboBox boxE = new ComboBox()
    ..labelFunction = control_labelHandler
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..dataProvider = createDataProvider();
  ComboBox boxF = new ComboBox()
    ..labelFunction = control_labelHandler
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..dataProvider = createDataProvider();
  
  ListRenderer listRenderer = new ListRenderer()
    //..itemRendererFactory = new ClassFactory('dartflex.components', 'ItemRenderer')
    ..itemRendererFactory = new ClassFactory(constructorMethod: DemoItemRenderer.construct)
    ..percentWidth = 100.0
    ..percentHeight = 100.0
    ..colPercentWidth = 100.0
    ..rowHeight = 30
    ..dataProvider = createDataProvider(dpLen: 100000)
    ..labelFunction = control_labelHandler;
  
  boxA['selectedItemChanged'] = ((FrameworkEvent event) => label.text = control_labelHandler(event.relatedObject));
  
  container.add(topContainer);
  container.add(middleContainer);
  container.add(bottomContainer);
  
  topContainer.add(boxA);
  topContainer.add(boxB);
  topContainer.add(button);
  
  bottomContainer.add(boxC);
  bottomContainer.add(label);
  bottomContainer.add(boxD);
  
  middleContainer.add(boxE);
  middleContainer.add(listRenderer);
  middleContainer.add(boxF);
}

ListRenderer _listRenderer;
RichText _innerHtmlDisplay;*/

/*void initContainer02() {
  _listRenderer = new ListRenderer(orientation: 'horizontal')
  //..itemRendererFactory = new ClassFactory('dartflex.components', 'ItemRenderer')
  ..itemRendererFactory = new ClassFactory(constructorMethod: DemoItemRenderer.construct)
  ..width = 400
  ..percentHeight = 100.0
  ..colWidth = 160
  ..dataProvider = createDataProvider(dpLen: 5000, labelMain: 'Employee nr.');
  
  _innerHtmlDisplay = new RichText()
  ..percentWidth = 100.0
  ..percentHeight = 100.0;
  
  HGroup container01 = new HGroup(elementId: '#container02')
  ..percentWidth = 100.0
  ..percentHeight = 100.0
  ..add(_listRenderer)
  ..add(_innerHtmlDisplay);
}



String control_labelHandler(ListItem item) {
  return item.label;
}

String getLoremIpsum() {
  return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consectetur sem vitae nibh vulputate a tempus neque feugiat. Nam pellentesque diam nec nunc eleifend ornare. In sapien nisl, luctus in laoreet at, laoreet in mauris. Nullam tempor leo a felis fringilla ut scelerisque mi mollis. In eu commodo arcu. Sed nec tincidunt lectus. Morbi consectetur laoreet tellus, nec aliquet felis congue a. Integer in sem sit amet nisl bibendum rhoncus. Praesent eget libero urna. Mauris et sodales sem. Curabitur vel nisi vel sapien interdum euismod. Integer malesuada, purus nec viverra dapibus, diam ligula scelerisque risus, in dictum nisl neque non diam. Fusce posuere urna a lectus aliquam malesuada.';
}*/

String getRandomName() {
  Random rnd = new Random();
  
  List<String> firstNames = [
    'Neil', 'Oleg', 'Arkadiusz', 'John', 'Terry', 'Alan', 'Marc', 'Jackson', 'Ian', 'William', 'Robert', 'Steve', 'Richard', 'Dave', 'Alec', 'Walter', 'George', 'Isac', 'Brian', 'Clyde', 'Eric', 'Frank', 'Humphrey', 'Louis', 'Norman', 'Oswald', 'Peter', 'Quinten', 'Vinny', 'Xavier',
    'Margareth', 'Anna', 'Bethany', 'Cynthia', 'Dana', 'Eloise', 'Frances', 'Gerry', 'Hannah', 'Indra', 'Jasmine', 'Kelcy', 'Louise', 'Mandy', 'Nicole', 'Natasha', 'Oscar', 'Patricia', 'Rita', 'Samantha', 'Tiffany', 'Ursula', 'Vanessa', 'Wendy', 'Zara',
    'Jacky', 'Christopher', 'Annabel', 'Bastian', 'Clyde', 'Desmond', 'Erika', 'Fabienne', 'Gunther', 'Halley', 'Issa', 'John', 'Morgan', 'Nils', 'Ona', 'Uma', 'Homer', 'Bob', 'Anatoly', 'Aurelie', 'Seymour', 'Tony', 'Randy',
    'Ashley', 'Adam', 'Benedict', 'Chester', 'Dough', 'Evram', 'Fritz', 'Gustav', 'Hendrik', 'Iris', 'Jacquelyn', 'Kendra', 'Lara', 'Morrigan', 'Nora', 'Ophelia', 'Parker', 'Roberta', 'Sandra', 'Tilley', 'Valeria', 'Willy', 'Xandra', 'Zico',
    'Ashton', 'Carlton', 'Dick', 'Everett', 'Fabrice', 'August', 'Dakota', 'Nigel', 'Paris', 'Angela', 'Adnan', 'Alois', 'Benjamin', 'Benny', 'Bea', 'Bonny', 'Belinda',
    'Cory', 'Christian', 'Cale', 'Carlyle', 'Finny', 'Francesca', 'Flavio', 'Fernando', 'Ferry',
    'Ginny', 'Gregory', 'Gaelle', 'Gerd', 'Gonda', 'Gary', 'Gomez', 'Gaetan', 'Genaro',
    'Hadley', 'Horace', 'Horatio', 'Hermes', 'Higgs', 'Hendrietta', 'Hugh', 'Halle', 'Hiatt', 'Hernando',
    'Indy', 'Janice', 'Jetta', 'Linda', 'Lorelai', 'Lindsay', 'Lucas', 'Lucio',
    'Matthew', 'Moses', 'Mohammed', 'Marcus'
  ];
  
  List<String> lastNames = [
   'Anderton', 'Burgundy', 'Carruthers', 'Dillan', 'Erickson', 'Fenton', 'Gyllenhaal', 'Humphries', 'Isaksson', 'Jones', 'Kensington', 'Lane', 'McNamara', 'Newton', 'O\'Riley', 'Peterson', 'Quint', 'Roy', 'Stephenson', 'Truman', 'Ulman', 'Van Dyke', 'Wellington', 'Zalman',
   'Abigail', 'Bryce', 'Cole', 'Delmond', 'Ellis', 'Foley', 'Gordon', 'Halifax', 'Illinois', 'Johnson', 'Kelly', 'Lampard', 'Masterson', 'Nightingale', 'Ordaz', 'Pettigrew', 'Richardson', 'Smith', 'Trafalgar', 'Unsworth', 'Vonnegut', 'Wrexham',
   'Argyle', 'Bolton', 'Castor', 'Darlington', 'Eaton', 'Fitzgerald', 'Gains', 'Ivanov', 'Jorgenssen', 'Klimowicz', 'Lovren', 'Middleton', 'Naysmith', 'Onassis', 'Parkinson', 'Ruthersford', 'Swindon', 'Tygart', 'Volante', 'Williams',
   'Arvendsen', 'Blackwell', 'Carter', 'Doncaster', 'Evergreen', 'Fazekas', 'Germaine', 'Jacobson', 'Kubrick', 'Lewandowski', 'Mendelson', 'Nilsson', 'Ocean', 'Plumber', 'Richter', 'Styles', 'Trifton', 'Watergate', 'Zorba',
   'Aggerton', 'Burke', 'Coleman', 'Denver', 'Finkelstein', 'Georges', 'Jacksonville', 'Kanaan', 'Lafferty', 'Michigan', 'Nordberg', 'O\'Hara', 'Parker', 'Rover', 'Tallys', 'Upson', 'Van Diemen', 'Zachman',
   'Austin', 'Belford', 'Cordoba', 'Doyle', 'Frost', 'Gaile', 'Hettysburg', 'Inverness', 'Jagan', 'Kendry', 'Morten', 'Nedry', 'Osmond', 'Pharkemeiser', 'Rickers', 'Timberland', 'Kirkland', 'Vaughn', 'Wilkes',
   'Agger', 'Belvedere', 'Chesterfield', 'Dalton', 'Fowles', 'Gorges', 'Haliburton', 'Icarus', 'Kuda', 'Lanister', 'McIntosh', 'Newell', 'Lloyd', 'Pasadena', 'Rock', 'Tasman', 'Ulysses', 'Varnes', 'Walther', 'Zamora',
   'Green', 'Black', 'White', 'Redgrove', 'Wyoming', 'Mansell'
   ];
  
  String first = firstNames[rnd.nextInt(firstNames.length)];
  String last = lastNames[rnd.nextInt(lastNames.length)];
  
  return '$first $last';
}

String getRandomJob() {
  Random rnd = new Random();
  
  List<String> jobs = [
    'manager', 'it expert', 'accountant', 'human resources', 'r & d', 'security', 'freelance',
    'unemployed', 'electrician', 'plumber', 'fireman', 'policeman', 'race car driver', 'stuntman',
    'actor', 'entertainer', 'pro football player', 'nurse', 'volunteer', 'consultant', 'lawyer',
    'artist', 'politician', 'retired', 'director'
  ];
  
  String job = jobs[rnd.nextInt(jobs.length)];
  
  return '$job';
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
  item['fullname'] = getRandomName();
  item['job'] = getRandomJob();
  item['phone'] = getRandomPhone();
  item['manager'] = getRandomName();
  
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
