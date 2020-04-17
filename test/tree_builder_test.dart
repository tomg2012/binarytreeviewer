import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:binarytreeviewer/tree_builder.dart';

void main() {
  var bigTree = '[-64,12,18,-4,-53,null,76,null,-51,null,null,-93,3,null,-31,'
      '47,null,3,53,-81,33,4,null,-51,-44,-60,11,null,null,null,null,78,null,'
      '-35,-64,26,-81,-31,27,60,74,null,null,8,-38,47,12,-24,null,-59,-49,-11,'
      '-51,67,null,null,null,null,null,null,null,-67,null,-37,-19,10,-55,72,null,'
      'null,null,-70,17,-4,null,null,null,null,null,null,null,3,80,44,-88,-91,'
      'null,48,-90,-30,null,null,90,-34,37,null,null,73,-38,-31,-85,-31,-96,null,'
      'null,-18,67,34,72,null,-17,-77,null,56,-65,-88,-53,null,null,null,-33,86,'
      'null,81,-42,null,null,98,-40,70,-26,24,null,null,null,null,92,72,-27,null,'
      'null,null,null,null,null,-67,null,null,null,null,null,null,null,-54,-66,'
      '-36,null,-72,null,null,43,null,null,null,-92,-1,-98,null,null,null,null,'
      'null,null,null,39,-84,null,null,null,null,null,null,null,null,null,null,'
      'null,null,null,-93,null,null,null,98]';

  test('TreeBuilder init canvas test happy path', () {
   var  inputString = '[1,null,2,3,4]';

   var treeBuilder = TreeBuilder();
   treeBuilder.treeInput = inputString;
   treeBuilder.initPaint();
   expect(treeBuilder.width > 0, true);

 });
 test('TreeBuilder init canvas test malformed', () {
   var  inputString = '[1,null,2,3,4';

   var treeBuilder = TreeBuilder();
   treeBuilder.treeInput = inputString;
   treeBuilder.initPaint();
   expect(treeBuilder.width > 0, false);

 });
 testWidgets('TreeBuilder renders as custom paint painter.', (WidgetTester tester) async {
   // load the page and check if all the essential inputs are on the page


   var treeBuilder = TreeBuilder();
   treeBuilder.treeInput = bigTree;
   await treeBuilder.initPaint();


   await tester.pumpWidget(
       MaterialApp(
         home:CustomPaint(painter: treeBuilder),
       )
   );
   expect(treeBuilder.treeInput != null, true);
   expect(treeBuilder.width > 0, true);
   expect(treeBuilder.height > 0, true);



 });

}
//  [1,2,3,4,5,6,7,8,9,0,q,w,e,r,t,y,u,i,o,p,a,s,d,f,g,h,j,k,l]