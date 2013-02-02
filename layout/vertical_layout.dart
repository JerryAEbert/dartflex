part of dartflex.layout;

class VerticalLayout implements ILayout {
  
  int _gap = 10;
  
  int get gap => _gap;
  
  VerticalLayout() {}
  
  void doLayout(int width, int height, List<UIWrapper> elements) {
    UIWrapper element;
    int percHeight = height;
    int offset = 0;
    int len = elements.length;
    int w, h, i, sx;
    int staticElmLen = 0;
    
    for (i=0; i<len; i++) {
      element = elements[i];
      
      if (
          (element.percentHeight == 0.0) &&
          (element.height > 0)
      ) {
        percHeight -= element.height;
        
        staticElmLen++;
      }
    }
    
    sx = len - staticElmLen;
    
    percHeight -= staticElmLen * _gap;
    
    for (i=0; i<len; i++) {
      element = elements[i];
      
      element.control.style.position = 'absolute';
      element.control.style.left = '0px';
      element.control.style.top = offset.toString().concat('px');
      
      if (element.percentWidth > 0.0) {
        w = (width * element.percentWidth * .01).toInt();
      } else if (element.width > 0) {
        w = element.width;
      }
      
      if (element.percentHeight > 0.0) {
        h = (element.percentHeight * .01 * (percHeight - _gap * (sx - 1)) / sx).toInt();
      } else if (element.height > 0) {
        h = element.height;
      }
      
      w = (w == null) ? 0 : w;
      h = (h == null) ? 0 : h;
      
      element.control.style.width = w.toString().concat('px');
      element.control.style.height = h.toString().concat('px');
      
      element.width = w;
      element.height = h;
      
      offset += h + _gap;
    }
  }
  
}

