import 'package:binarytreeviewer/tree_builder.dart';
import 'package:binarytreeviewer/tree_utils.dart';
import 'package:binarytreeviewer/ui_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TreeInputPage extends StatefulWidget {
  TreeInputPage({
    @required this.treeBuilder
  });
  final TreeBuilder treeBuilder;
  @override
  _TreeInputPageState createState() => _TreeInputPageState(treeBuilder: treeBuilder);
}

class _TreeInputPageState extends State<TreeInputPage> {
  _TreeInputPageState({
      this.treeBuilder
  });

  TextEditingController treeInputController = TextEditingController();
  var errorMessage;
  var bodyMessage = 'Format: [Root,L,R,LL,LR,RL,RR,LLL,LLR,...]\n'
      'Example: [1,2,3,null,null,4,5]\n'
      'Creates binary tree:  1\n'
      '                     / \\\n'
      '                    2   3\n'
      '                   / \\\n'
      '                  4   5';


  TreeBuilder treeBuilder;
  @override
  void initState() {
    treeBuilder = (treeBuilder == null) ? TreeBuilder() : treeBuilder;
    super.initState();
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    treeInputController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        textTheme: mainTextTheme,

        title: Text('Data Input'),

        ),
        body: ListView(
          children: <Widget> [
        Padding(
          padding: EdgeInsets.all(8.0),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Input:', style: headerText,),

                TextField(

                  key: Key('treeInput'),
                  controller: treeInputController,
                  maxLines: 20,
                  minLines: 10,

                  decoration: InputDecoration(
                    hintStyle: bodyText,
                    hintText: bodyMessage,
                    errorText: errorMessage,
                    errorStyle: errorTextStyle,
                  ),
                ),
                RaisedButton(
                  key: Key('buildTreeButton'),
                  onPressed: (){
                    var input = treeInputController.text.trim();
                    if(input.isEmpty) errorMessage = 'Error: No Data';
                    errorMessage = TreeUtils.validateString(input);

                    if(errorMessage.isEmpty){
                      treeBuilder.treeInput = input;
                      Navigator.pop(context);
                    }

                    setState(() { });
                  },
                  child: Text('<Build Tree>', style: headerText,),
                )

              ],
            )

        )
    ]
        ),
    );
  }
}
