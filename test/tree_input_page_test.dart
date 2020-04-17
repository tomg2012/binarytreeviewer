import 'package:binarytreeviewer/tree_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


import 'package:binarytreeviewer/tree_input_page.dart';

void main() {
  testWidgets('Page Layout has textfield and button', (WidgetTester tester) async {
    // load the page and check if all the essential inputs are on the page
    await tester.pumpWidget(MaterialApp(home: TreeInputPage(treeBuilder: null,),));

    expect(find.byKey(Key('treeInput')), findsOneWidget);
    expect(find.byKey(Key('buildTreeButton')), findsOneWidget);


  });
  testWidgets('Tap the button with no input', (WidgetTester tester) async {
    // Tap the build tree button  with no input and check to see if the error
    // message appears
    var errorMessage = '';
    await tester.pumpWidget(MaterialApp(home: TreeInputPage(treeBuilder: null,),));

    expect(find.byKey(Key('buildTreeButton')), findsOneWidget);

    await tester.tap(find.byKey(Key('buildTreeButton')));
    await tester.pump();
    try{
      throw EmptyInputException();
    }catch(e){
      errorMessage = e.errorMessage();
    }

    expect(find.text(errorMessage), findsOneWidget);

  });
  testWidgets('Tap the button with malformed input', (WidgetTester tester) async {
    // Tap the build tree button  with malformed input and check to see if the error
    // message appears
    String errorMessage;

    await tester.pumpWidget(MaterialApp(home: TreeInputPage(treeBuilder: null,),));
    expect(find.byKey(Key('treeInput')), findsOneWidget);
    expect(find.byKey(Key('buildTreeButton')), findsOneWidget);
    // Tap the '+' icon and trigger a frame.
    await tester.enterText(find.byKey(Key('treeInput')), '[bad entry');
    await tester.pump();
    await tester.tap(find.byKey(Key('buildTreeButton')));
    await tester.pump();
    try{
      throw MalformedInputException();
    }catch(e){
      errorMessage = e.errorMessage();
    }
    expect(find.text(errorMessage), findsOneWidget);

  });
  testWidgets('Tap the button with proper input', (WidgetTester tester) async {
    // Tap the build tree button  with proper input, no error appears.

    await tester.pumpWidget(MaterialApp(home: TreeInputPage(treeBuilder: null,),));
    expect(find.byKey(Key('treeInput')), findsOneWidget);
    expect(find.byKey(Key('buildTreeButton')), findsOneWidget);
    // Tap the '+' icon and trigger a frame.
    await tester.enterText(find.byKey(Key('treeInput')), '[1,2,3]');
    await tester.pump();
    await tester.tap(find.byKey(Key('buildTreeButton')));
    await tester.pump();

    expect(find.text('ERROR'), findsNothing);

  });
}