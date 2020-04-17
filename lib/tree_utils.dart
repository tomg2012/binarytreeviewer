class TreeNode{
  final dynamic val;
  TreeNode left;
  TreeNode right;
  int row = 0;
  int column = 0;
  double x = 0.0;
  double y = 0.0;
  TreeNode(this.val);
}
class TreeUtils{
  /// Validates an input string is correctly formatted for parsing a tree
  /// Throws [EmptyInputException] and [MalformedInputException]
  static String validateString(String input) {
    var errorMessage = '';
    try{
      stringToList(input);
    }catch(e){
     errorMessage = e.errorMessage();
    }
    return errorMessage;
  }
  /// Converts [input] into a [List].
  static List<String> stringToList(String input){
    List<String> output;
    output = [];

    var i= 0;

    var temp = '';
    if(input.isEmpty || input=='[]') throw EmptyInputException();
    if(input[0] != '[' || input[input.length-1] != ']') {
      throw MalformedInputException();
    }

   while(i<input.length){

     if(input[i] == '[' ){
       //pass
     }else if(input[i]==','|| input[i] == ']'){
       output.add(temp);
       temp = '';
     }else{
       temp = '$temp${input[i]}';
     }

     i++;
    }

    return output;
  }
  /// Validates that a tree can be built with [input].
  static bool validateInput(List input){

    if(input == null) return false;
    if(input.length==1) return true;

    var i=0;
    var prevItems = 1;
    var allItems = 0;
    var validItems = 0;
    var expectedItems = 1;
    while(i<input.length){

      if(i < (input.length - expectedItems)) {
        for (var j = 0; j < prevItems; j++) {
          allItems++;
          if (input[i] != 'null') {
            validItems++;
          }
          i++;
        }

        if (allItems != expectedItems) return false;
        expectedItems = validItems * 2;
        prevItems = expectedItems;
        allItems = 0;
        validItems = 0;
      }else{
        i++;
      }
    }
    return true;
  }
  /// Counts the number of valid items per level
  static List<int> getLevelItems(List input){
    var output =  <int>[];
    output.add(1);
    if(input.length==1) return output;
    var i=0;
    var prevItems = 1;
    var validItems = 0;
    var expectedItems = 1;
    while(i<input.length){

      if(i < (input.length - expectedItems)) {
        for (var j = 0; j < prevItems; j++) {
          if (input[i] != 'null') {
            validItems++;
          }
          i++;
        }
        output.add(validItems);
        expectedItems = validItems * 2;
        prevItems = expectedItems;
        validItems = 0;
      }else{
        i++;
      }
    }
    return output;
  }
  /// Returns a [String] representation of the inorder sort of [root]
 static String getInorderSort(TreeNode root){
    if(root == null) return '';

    var inorder = '[';
    void inorderDfs(TreeNode node){
      if(node.left != null) inorderDfs(node.left);
      inorder = '$inorder${node.val},';
      if(node.right != null) inorderDfs(node.right);
    }
    inorderDfs(root);
    return '${inorder.substring(0,inorder.length-1)}]';
  }
  /// Returns the [String] representation of the preorder sort of [root]
  static String getPreorderSort(TreeNode root){
    if(root == null) return '';
    var preorder = '[';
    void preorderDfs(TreeNode node) {
      preorder = '$preorder${node.val},';
      if(node.left != null) preorderDfs(node.left);
      if(node.right != null) preorderDfs(node.right);
    }
    preorderDfs(root);
    return '${preorder.substring(0,preorder.length-1)}]';
  }
}

class MalformedInputException implements Exception{
  String errorMessage(){
    return 'ERROR: Malformed String input.';
  }

}
class EmptyInputException implements Exception{
  String errorMessage(){
    return 'ERROR: No Data';
  }
}