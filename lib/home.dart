import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:binarytreeviewer/ui_constants.dart';
import 'tree_builder.dart';
import 'tree_input_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TreeBuilder _treeBuilder;
  @override
  void initState(){
    _treeBuilder = TreeBuilder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(

            appBar: AppBar(
              textTheme: mainTextTheme,
              title: Text('BTVisualizer'),
              actions: <Widget>[
                IconButton(
                  key: Key('dataInputButton'),
                  onPressed: () async{
                    await Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>TreeInputPage(treeBuilder: _treeBuilder)))
                    .then((_) async {
                          await _treeBuilder.initPaint();
                          setState(() {  });
                    });
                  },
                  icon: Icon( Icons.input, color: Colors.white),
                ),
              ],
            ),
            body: Stack(
              children: <Widget>[
                (_treeBuilder.width != 0 && _treeBuilder.height != 0)
                    ? Zoom(
                    key: Key('canvasDisplay'),
                    width:_treeBuilder.width,
                    height: _treeBuilder.height,
                    initZoom: 0.0,
                    child:CustomPaint(
                        painter: _treeBuilder
                    )
                ):
                Container(),
              ],
            )

      );

  }

}
