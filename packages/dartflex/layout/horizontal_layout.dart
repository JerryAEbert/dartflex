part of dartflex.layout;

class HorizontalLayout implements ILayout {
  
  //---------------------------------
  //
  // Public properties
  //
  //---------------------------------
  
  //---------------------------------
  // useVirtualLayout
  //---------------------------------
  
  bool _useVirtualLayout = false;
  
  bool get useVirtualLayout => _useVirtualLayout;
  set useVirtualLayout(bool value) {
    if (value != _useVirtualLayout) {
      _useVirtualLayout = value;
    }
  }
  
  //---------------------------------
  // gap
  //---------------------------------
  
  int _gap = 10;
  
  int get gap => _gap;
  set gap(int value) => _gap = value;

  //---------------------------------
  //
  // Constructor
  //
  //---------------------------------
  
  Horizontalayout() {}
  
  //---------------------------------
  //
  // Public methods
  //
  //---------------------------------
  
  void doLayout(int width, int height, int pageItemSize, int pageOffset, int pageSize, List<UIWrapper> elements) {
    UIWrapper element;
    int percWidth = width;
    int offset = 0;
    int len = elements.length;
    int w, h, i, sx;
    int staticElmLen = 0;
    
    for (i=0; i<len; i++) {
      element = elements[i];
      
      if (!element.includeInLayout) {
        staticElmLen++;
      } else if (
          (element.percentWidth == 0.0) &&
          (element.width > 0)
      ) {
        percWidth -= element.width;
        
        staticElmLen++;
      }
    }
    
    sx = len - staticElmLen;
    
    percWidth -= staticElmLen * _gap;
    
    for (i=0; i<len; i++) {
      element = elements[i];
      
      if (element.includeInLayout) {
        if (element.percentWidth > 0.0) {
          w = (element.percentWidth * .01 * (percWidth - _gap * (sx - 1)) / sx).toInt();
        } else if (element.width > 0) {
          w = element.width;
        }
        
        if (element.percentHeight > 0) {
          h = (height * element.percentHeight * .01).toInt();
        } else if (element.height > 0) {
          h = element.height;
        }
        
        w = (w == null) ? 0 : w;
        h = (h == null) ? 0 : h;
        
        element.control.style.position = 'absolute';
        element.control.style.left = offset.toString().concat('px');
        element.control.style.top = (height * .5 - h * .5).toString().concat('px');
        element.control.style.width = w.toString().concat('px');
        element.control.style.height = h.toString().concat('px');
        
        element.width = w;
        element.height = h;
        
        offset += w + _gap;
      }
      
      element.invalidateProperties();
    }
  }
  
}



