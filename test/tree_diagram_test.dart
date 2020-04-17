import 'package:flutter_test/flutter_test.dart';
import 'package:binarytreeviewer/tree_diagram.dart';
import 'package:binarytreeviewer/tree_utils.dart';

void main() {
  var bigTree = '[-64,12,18,-4,-53,null,76,null,-51,null,null,-93,3,null,-31,47,null,3,53,-81,33,4,null,-51,-44,-60,11,null,null,null,null,78,null,-35,-64,26,-81,-31,27,60,74,null,null,8,-38,47,12,-24,null,-59,-49,-11,-51,67,null,null,null,null,null,null,null,-67,null,-37,-19,10,-55,72,null,null,null,-70,17,-4,null,null,null,null,null,null,null,3,80,44,-88,-91,null,48,-90,-30,null,null,90,-34,37,null,null,73,-38,-31,-85,-31,-96,null,null,-18,67,34,72,null,-17,-77,null,56,-65,-88,-53,null,null,null,-33,86,null,81,-42,null,null,98,-40,70,-26,24,null,null,null,null,92,72,-27,null,null,null,null,null,null,-67,null,null,null,null,null,null,null,-54,-66,-36,null,-72,null,null,43,null,null,null,-92,-1,-98,null,null,null,null,null,null,null,39,-84,null,null,null,null,null,null,null,null,null,null,null,null,null,-93,null,null,null,98]';

  group('Tree Diagram Tests', (){
    test('Build BST Happy Path', (){

      // Tests to see if our build BT algorithm builds a tree that matches in-order and pre-order
      var input = '[1,null,2,3,4]';
      var diagram = TreeDiagram(input);
      var root = diagram.buildBt();
      expect(TreeUtils.getPreorderSort(root)=='[1,2,3,4]', true);
      expect(TreeUtils.getInorderSort(root) == '[1,3,2,4]', true);
    });
    test('Build BST Happy Path Big Tree', (){
      // Tests to see if our build BT algorithm builds a tree that matches in-order and pre-order
      var bigTreePreorder = '[-64,12,-4,-51,-31,-81,33,-53,18,76,-93,47,4,78,3,3,-51,-35,8,-38,-67,-64,47,-37,3,73,-33,-38,86,-54,-66,80,-31,81,-36,-42,-72,-85,-19,44,-31,98,43,-40,-96,70,-92,-26,-1,-93,-98,-88,12,10,-91,-18,24,67,-55,48,34,92,72,72,-27,39,98,-90,-17,-44,26,-24,72,-30,-77,-81,-59,-49,-70,90,56,-65,-67,-84,17,-34,-88,-53,37,53,-60,-31,-11,-4,-51,27,67,11,60,74]';
      var bigTreeInorder =  '[-4,-51,-81,-31,33,12,-53,-64,18,78,4,47,-93,76,8,-35,-67,-38,-51,73,-33,3,-54,86,-66,-38,-37,-36,81,-31,-72,-42,80,-85,47,98,43,-31,-40,44,70,-92,-96,-93,-1,-26,-98,-19,-88,-64,24,-18,-91,67,10,12,34,92,48,72,72,-27,98,39,-55,-90,-17,3,-77,-30,72,-24,26,-44,-59,-81,-70,56,90,-84,-67,-65,-49,-88,-34,-53,17,37,3,-4,-11,-31,-51,-60,67,27,53,60,11,74]';
      var diagram = TreeDiagram(bigTree);
      var root = diagram.buildBt();
      expect(TreeUtils.getPreorderSort(root)==bigTreePreorder, true);
      expect(TreeUtils.getInorderSort(root) == bigTreeInorder, true);

    });
    test('get Pixel Width of tree', (){
      var input = '[1,null,2,3,4]';
      var diagram = TreeDiagram(input);
      diagram.buildBt();

      diagram.getNodeSizes();
      expect(diagram.width > 0,true);
      expect(diagram.offset >= 0, true);

    });
    test('get Pixel Height of Big tree', (){

      var diagram = TreeDiagram(bigTree);
      diagram.buildBt();
      diagram.getNodeSizes();
      expect(diagram.height > 0, true);
      expect(diagram.margin > 0, true);
    });

  });
}