library dartflex.layout;

import 'dart:html';
import 'package:dartflex/components/components.dart';

part "horizontal_layout.dart";
part "vertical_layout.dart";

abstract class ILayout {
  
  void doLayout(int width, int height, List<UIWrapper> elements) {}
  
}

