library dartflex.layout;

import 'dart:html';
import 'package:dartflex/components/components.dart';

part "horizontal_layout.dart";
part "vertical_layout.dart";

abstract class ILayout {
  
  bool get useVirtualLayout;
  set useVirtualLayout(bool value);
  
  int get gap;
  set gap(int value);
  
  bool get constrainToBounds;
  set constrainToBounds(bool value);
  
  void doLayout(int width, int height, int pageItemSize, int pageOffset, int pageSize, List<UIWrapper> elements);
  
}

