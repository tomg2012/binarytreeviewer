
import 'package:binarytreeviewer/ui_constants.dart';
import 'package:flutter/cupertino.dart';
import 'dart:collection';
import 'dart:ui' as u;
import 'package:binarytreeviewer/tree_diagram.dart';
import 'tree_utils.dart';
import 'package:flutter/material.dart';


class TreeBuilder extends CustomPainter {
  double _width = 0;
  /// Returns the [width] of the diagram in pixels.
  double get width{
    return _width;
  }
  double _height = 0;
  /// Returns the [height] of the diagram in pixels.
  double get height{
    return _height;
  }
  TreeDiagram diagram;

  String _treeInput;
  /// Returns [String] format of binary tree.
  String get treeInput{
    return _treeInput;
  }
  /// Validates and sets the [input] for the tree
  /// Uses format [root,L,R,LL,LR,RL,RR...]
  /// 'null' indicates null node. Example: [1,2,null,3,4]
  set treeInput(String input){
    List<String> inputList;
    try{
      inputList = TreeUtils.stringToList(input);
    }catch(e){
      inputList = null;
    }
    if(TreeUtils.validateInput(inputList)) _treeInput = input;

  }

  /// Initializes the tree diagram and renders it.
  Future<void> initPaint() async {
    if (_treeInput != null) {
      diagram = TreeDiagram(_treeInput);

      _width = diagram.width + diagram.marginX;
      _height = diagram.height + diagram.marginY;
    }
  }
  @override
  void paint(Canvas canvas, Size size) async{
    canvas.save();
    canvas.scale(1);
    paintTree(canvas, diagram);
    canvas.restore();

  }
  void paintTree(Canvas canvas, TreeDiagram diagram, {double scale }){

    var root = diagram.root;

    scale = (scale == null) ?  1.0 : scale;
    if(root == null) return;


    var nodeQ = Queue();
    nodeQ.add(root);

    while(nodeQ.isNotEmpty){
      var paint = Paint();
      paint.color = NodePaintProperty.lineColor;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = NodePaintProperty.strokeWidth;
      var qCount = nodeQ.length;
      var x = 0.0;
      var y = 0.0;
      for(var i=0; i<qCount; i++){

        TreeNode node = nodeQ.removeFirst();
        if(node.left != null) nodeQ.add(node.left);
        if(node.right != null) nodeQ.add(node.right);

        x = node.x;
        y = node.y;

        if(node.left != null){
          var xL =  node.left.x;
          var yL =  node.left.y;
          canvas.drawLine(Offset(x,y), Offset(xL,yL), paint);
        }
        if(node.right != null){
          var xR =  node.right.x;
          var yR =  node.right.y;
          canvas.drawLine(Offset(x,y), Offset(xR,yR), paint);
        }

        paintNode(canvas, '${node.val}', x,y);
      }
    }


  }
  /// Draws a node on [canvas] showing [value] at [x] and [y] coordinates.
  void paintNode(Canvas canvas, String value, double x, double y){
    var circleFill = Paint();

    circleFill.color = NodePaintProperty.circleFill;
    circleFill.style = PaintingStyle.fill;
    var circleStroke = Paint();

    circleStroke.color = NodePaintProperty.lineColor;
    circleStroke.style = PaintingStyle.stroke;
    circleStroke.strokeWidth = NodePaintProperty.strokeWidth;




    var center = Offset(x, y);
    var textCenter = Offset(x-50.0,y-15.0);
    final rect = Rect.fromCenter(center: center, width: 75.0, height: 75.0);


    // TODO: Draw your path
    canvas.drawOval(rect, circleFill);
    canvas.drawOval(rect, circleStroke);

    // draw text
    final paragraphStyle = u.ParagraphStyle(textAlign: TextAlign.center);
    final textStyle = u.TextStyle(color: Colors.black, fontSize: 30.0);
    final paragraphBuilder = u.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(value);
    final paragraph = paragraphBuilder.build()
      ..layout(u.ParagraphConstraints(width:100 ));
    canvas.drawParagraph(paragraph, textCenter);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}