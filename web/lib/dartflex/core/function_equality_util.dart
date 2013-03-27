part of dartflex;

class FunctionEqualityUtil {

  static bool equals(Function functionA, Function functionB) {
    if (!identical(1, 1.0)) {
      // dart VM does not currently support function equality checks
      return (functionA.toString() == functionB.toString());
    } else {
      // JS obviously does
      return (functionA == functionB);
    }
  }

}

