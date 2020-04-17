import 'dart:collection';
import 'tree_utils.dart';

class TreeDiagram {
  String _inputString;
  List<int> _levelItemCount;
  List<dynamic> _inputList;

  TreeNode _root;
  /// Returns [root]
  TreeNode get root{
    return _root;
  }

  final int _nodeSize = 100;
  final int _nodeSizeX = 45;

  int get margin{
    return _nodeSize;
  }

  int get marginX{
    return _nodeSize;
  }
  final int _nodeSizeY = 100;
  int get marginY{
    return _nodeSize;
  }

  Map<int,int> cols = {};
  int colsIndex = 0;
  int _maxCol = 0;

  int _offset = 0;
  /// Returns the left offset so x value is non-negative
  int get offset{
    return _offset.abs()*_nodeSizeX+marginX;
  }
  double _width = 0;
  /// Returns the width in pixels of the tree diagram.
  double get width {
    return _width;
  }
  double _height =0;
  double get height {
    return _height;
  }

  TreeDiagram(String inputString) {
    _inputString = inputString;
    _inputList = TreeUtils.stringToList(_inputString);
    _levelItemCount = TreeUtils.getLevelItems(_inputList);
    buildBt();
    getNodeSizes();

  }

  /// Builds Binary Tree from [root]
  ///
  ///   inputString format is [ R, L, R, LL, LR, RL, RR, LLL, ....]
  ///   Null items have no expected L or R items.
  TreeNode buildBt() {

    var level = 0;
    int expectedItems;
    var levelQ = Queue();// For nodes in one level
    var allQ = Queue();

    // create a Queue of tree nodes (unlinked)
    for(var k=0; k<_inputList.length; k++){
      allQ.add(TreeNode(_inputList[k]));
    }

    // remove the first and call it root
    _root = allQ.removeFirst();
    var node = _root;
    //
    levelQ.add(node);

    while (allQ.isNotEmpty) {
      expectedItems =
      (level >= _levelItemCount.length) ? 0 : _levelItemCount[level];

      for (var k = 0; k < expectedItems; k++) {
        node = levelQ.removeFirst();

        if(allQ.isNotEmpty) {
          TreeNode leftNode = allQ.removeFirst();
          node.left = (leftNode.val == 'null') ? null : leftNode;
          if (node.left != null) levelQ.add(node.left);

        }
        if(allQ.isNotEmpty) {
          TreeNode rightNode = allQ.removeFirst();
          node.right = (rightNode.val == 'null') ? null : rightNode;

          if (node.right != null) levelQ.add(node.right);

        }
      }
    }
    return _root;
  }



  ///  Calculates the x|y coordinate of each node in [root]
  void getNodeSizes(){
    _sizeDfs(_root,0, 0);
  }

  int _sizeDfs(TreeNode node, int row, int column){

    row++;
    node.row = row;

    node.y = row * _nodeSizeY.toDouble();

    if(node.y > _height) _height = node.y;

    // column is used for relative positioning based on child node returns

    // Base Case: Leaf
    if(node.left == null && node.right == null) {

      // set our max column to the current column if we haven't found our first
      // left leaf node.
      if(cols.isEmpty) _maxCol = column;

      // First left leaf node
      if(cols[column] == null) {
        cols[column] = colsIndex;
        colsIndex++;
      }


      node.x =  _offset + margin + (column * _nodeSize).toDouble();

      return column;
    }

    // Offset is used to keep track of how far left the tree goes
    // and positions the nodes relative to the edge of the screen.
    if(column < _offset) _offset = column;

//    node.y =  (row * _nodeSizeY).toDouble();



    if(node.left != null ) {
      // If we traverse too far to the left and get into our sibling's tree
      // set the node's column to be past the wall
      if(cols.isNotEmpty){
        column--;
        while(column < _maxCol){
          column = _maxCol+1;
        }
      }
       column = _sizeDfs(node.left, row, column)+1; // add an extra space
    }
    // We should have the correct column for this node, set the X coord
    node.x = _offset + margin + (column * _nodeSize).toDouble();


    // _maxPixels will be used for our centering and page size algorithms
    // Using web, there is a fudge factor of 4 not sure why.
    if(node.x > _width) _width = node.x + margin*4;
    if(cols.isEmpty){
      if(cols[column] == null) {
        cols[column] = colsIndex;
        colsIndex++;
      }
      column++;
    }
    if(node.right != null) {
      // Before traversing right, check if our next column has gone past the wall
      // if it has, set it to the current column.
      if(column+1 > _maxCol) _maxCol = column;
      column = _sizeDfs(node.right, row, column+1);

    }
    return column;
  }
}
