part of dartflex.layout;

class VerticalLayout implements ILayout {
  
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
  
  VerticalLayout() {}
  
  //---------------------------------
  //
  // Public methods
  //
  //---------------------------------
  
  void doLayout(int width, int height, int pageItemSize, int pageOffset, int pageSize, List<UIWrapper> elements) {
    UIWrapper element;
    int percHeight = height;
    int pageHeightFloored = (pageItemSize == 0) ? 0 : (pageOffset / pageItemSize).toInt() * pageItemSize;
    int offset = _useVirtualLayout ? pageHeightFloored : 0;
    int len = elements.length;
    int w, h, i, sx;
    int staticElmLen = 0;
    
    for (i=0; i<len; i++) {
      element = elements[i];
      
      if (!element.includeInLayout) {
        staticElmLen++;
      } else if (
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
      
      if (element.includeInLayout) {
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
        
        element.control.style.position = 'absolute';
        element.control.style.left = (width * .5 - w * .5).toString().concat('px');
        
        if (
            (pageSize == 0) || 
            ((offset + h) <= pageSize)
        ) {
          element.control.style.top = offset.toString().concat('px');
          element.control.style.width = w.toString().concat('px');
          element.control.style.height = h.toString().concat('px'); 
        } else {
          element.control.style.top = '0px';
          element.control.style.width = w.toString().concat('px');
          element.control.style.height = h.toString().concat('px');
        }
        
        element.width = w;
        element.height = h;
        
        offset += h + _gap;
      } else {
        element.control.style.position = 'absolute';
        element.control.style.left = '0px';
        element.control.style.top = '0px';
        element.control.style.width = element.width.toString().concat('px');
        element.control.style.height = element.height.toString().concat('px');
      }
      
      element.invalidateProperties();
    }
  }
  
}

