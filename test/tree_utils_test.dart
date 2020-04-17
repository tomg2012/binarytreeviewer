import 'package:flutter_test/flutter_test.dart';

import 'package:binarytreeviewer/tree_utils.dart';

void main() {
  String input;
  group('String to List tests', (){
    test('Happy Path Test',() {
      input = '[1,null,2,3,4]';
      List<dynamic> newArray = TreeUtils.stringToList(input);
      assert((newArray.length==5),true);
    });
    test('Empty String Test',() {

      input = '';
      var threwError = false;
      try {
        TreeUtils.stringToList(input);
      }catch(e){
        if(e.runtimeType == EmptyInputException) threwError = true;
      }

      assert(threwError,true);
    });
    test('Malformed String Test bad beginning',() {
      input = '1,2,3,4,null]';
      var threwError = false;
      try {
        TreeUtils.stringToList(input);
      }catch(e){
        if(e.runtimeType == MalformedInputException) threwError = true;
      }

      assert(threwError,true);
    });
    test('Malformed String Test bad End',() {
      input = '[1,2,3,4,nu';
      var threwError = false;
      try {
        TreeUtils.stringToList(input);
      }catch(e){
        if(e.runtimeType == MalformedInputException) threwError = true;
      }

      assert(threwError,true);
    });

    test('Happy Path Test',() {
      input = '[1,null,2,3,4]';
      List<dynamic> newArray = TreeUtils.stringToList(input);
      var isValid = TreeUtils.validateInput(newArray);

      assert(isValid,true);
    });
    test('Happy Path Test longer',() {
      input = '[1,2,3,4,5,6,null,null,null,7,8,9,10]';
      List<dynamic> newArray = TreeUtils.stringToList(input);
      var isValid = TreeUtils.validateInput(newArray);

      assert(isValid,true);
    });
    test('Last one should be null, not present and still work',() {
      input = '[1,2,3,4,5,6,null,null,null,7,8,9]';
      List<dynamic> newArray = TreeUtils.stringToList(input);
      var isValid = TreeUtils.validateInput(newArray);

      assert(isValid,true);
    });



  });

}