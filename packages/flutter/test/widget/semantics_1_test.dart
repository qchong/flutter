// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../rendering/test_semantics_client.dart';

void main() {
  testWidgets('Semantics 1', (WidgetTester tester) async {
    TestSemanticsClient client = new TestSemanticsClient(tester.binding.pipelineOwner);

    // smoketest
    await tester.pumpWidget(
      new Container(
        child: new Semantics(
          label: 'test1',
          child: new Container()
        )
      )
    );
    expect(client.updates.length, equals(1));
    expect(client.updates[0].id, equals(0));
    expect(client.updates[0].actions, isEmpty);
    expect(client.updates[0].flags.hasCheckedState, isFalse);
    expect(client.updates[0].flags.isChecked, isFalse);
    expect(client.updates[0].strings.label, equals('test1'));
    expect(client.updates[0].geometry.transform, isNull);
    expect(client.updates[0].geometry.left, equals(0.0));
    expect(client.updates[0].geometry.top, equals(0.0));
    expect(client.updates[0].geometry.width, equals(800.0));
    expect(client.updates[0].geometry.height, equals(600.0));
    expect(client.updates[0].children.length, equals(0));
    client.updates.clear();

    // control for forking
    await tester.pumpWidget(
      new Column(
        children: <Widget>[
          new Container(
            height: 10.0,
            child: new Semantics(label: 'child1')
          ),
          new Container(
            height: 10.0,
            child: new IgnorePointer(
              ignoring: true,
              child: new Semantics(label: 'child2')
            )
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch
      )
    );
    expect(client.updates.length, equals(1));
    expect(client.updates[0].id, equals(0));
    expect(client.updates[0].actions, isEmpty);
    expect(client.updates[0].flags.hasCheckedState, isFalse);
    expect(client.updates[0].flags.isChecked, isFalse);
    expect(client.updates[0].strings.label, equals('child1'));
    expect(client.updates[0].geometry.transform, isNull);
    expect(client.updates[0].geometry.left, equals(0.0));
    expect(client.updates[0].geometry.top, equals(0.0));
    expect(client.updates[0].geometry.width, equals(800.0));
    expect(client.updates[0].geometry.height, equals(600.0));
    expect(client.updates[0].children.length, equals(0));
    client.updates.clear();

    // forking semantics
    await tester.pumpWidget(
      new Column(
        children: <Widget>[
          new Container(
            height: 10.0,
            child: new Semantics(label: 'child1')
          ),
          new Container(
            height: 10.0,
            child: new IgnorePointer(
              ignoring: false,
              child: new Semantics(label: 'child2')
            )
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch
      )
    );
    expect(client.updates.length, equals(1));
    expect(client.updates[0].id, equals(0));
    expect(client.updates[0].actions, isEmpty);
    expect(client.updates[0].flags.hasCheckedState, isFalse);
    expect(client.updates[0].flags.isChecked, isFalse);
    expect(client.updates[0].strings.label, equals(''));
    expect(client.updates[0].geometry.transform, isNull);
    expect(client.updates[0].geometry.left, equals(0.0));
    expect(client.updates[0].geometry.top, equals(0.0));
    expect(client.updates[0].geometry.width, equals(800.0));
    expect(client.updates[0].geometry.height, equals(600.0));
    expect(client.updates[0].children.length, equals(2));
    expect(client.updates[0].children[0].id, equals(1));
    expect(client.updates[0].children[0].actions, isEmpty);
    expect(client.updates[0].children[0].flags.hasCheckedState, isFalse);
    expect(client.updates[0].children[0].flags.isChecked, isFalse);
    expect(client.updates[0].children[0].strings.label, equals('child1'));
    expect(client.updates[0].children[0].geometry.transform, isNull);
    expect(client.updates[0].children[0].geometry.left, equals(0.0));
    expect(client.updates[0].children[0].geometry.top, equals(0.0));
    expect(client.updates[0].children[0].geometry.width, equals(800.0));
    expect(client.updates[0].children[0].geometry.height, equals(10.0));
    expect(client.updates[0].children[0].children.length, equals(0));
    expect(client.updates[0].children[1].id, equals(2));
    expect(client.updates[0].children[1].actions, isEmpty);
    expect(client.updates[0].children[1].flags.hasCheckedState, isFalse);
    expect(client.updates[0].children[1].flags.isChecked, isFalse);
    expect(client.updates[0].children[1].strings.label, equals('child2'));
    expect(client.updates[0].children[1].geometry.transform, equals(<double>[1.0,0.0,0.0,0.0, 0.0,1.0,0.0,0.0, 0.0,0.0,1.0,0.0, 0.0,10.0,0.0,1.0]));
    expect(client.updates[0].children[1].geometry.left, equals(0.0));
    expect(client.updates[0].children[1].geometry.top, equals(0.0));
    expect(client.updates[0].children[1].geometry.width, equals(800.0));
    expect(client.updates[0].children[1].geometry.height, equals(10.0));
    expect(client.updates[0].children[1].children.length, equals(0));
    client.updates.clear();

    // toggle a branch off
    await tester.pumpWidget(
      new Column(
        children: <Widget>[
          new Container(
            height: 10.0,
            child: new Semantics(label: 'child1')
          ),
          new Container(
            height: 10.0,
            child: new IgnorePointer(
              ignoring: true,
              child: new Semantics(label: 'child2')
            )
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch
      )
    );
    expect(client.updates.length, equals(1));
    expect(client.updates[0].id, equals(0));
    expect(client.updates[0].actions, isEmpty);
    expect(client.updates[0].flags.hasCheckedState, isFalse);
    expect(client.updates[0].flags.isChecked, isFalse);
    expect(client.updates[0].strings.label, equals('child1'));
    expect(client.updates[0].geometry.transform, isNull);
    expect(client.updates[0].geometry.left, equals(0.0));
    expect(client.updates[0].geometry.top, equals(0.0));
    expect(client.updates[0].geometry.width, equals(800.0));
    expect(client.updates[0].geometry.height, equals(600.0));
    expect(client.updates[0].children.length, equals(0));
    client.updates.clear();

    // toggle a branch back on
    await tester.pumpWidget(
      new Column(
        children: <Widget>[
          new Container(
            height: 10.0,
            child: new Semantics(label: 'child1')
          ),
          new Container(
            height: 10.0,
            child: new IgnorePointer(
              ignoring: false,
              child: new Semantics(label: 'child2')
            )
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch
      )
    );
    expect(client.updates.length, equals(1));
    expect(client.updates[0].id, equals(0));
    expect(client.updates[0].actions, isEmpty);
    expect(client.updates[0].flags.hasCheckedState, isFalse);
    expect(client.updates[0].flags.isChecked, isFalse);
    expect(client.updates[0].strings.label, equals(''));
    expect(client.updates[0].geometry.transform, isNull);
    expect(client.updates[0].geometry.left, equals(0.0));
    expect(client.updates[0].geometry.top, equals(0.0));
    expect(client.updates[0].geometry.width, equals(800.0));
    expect(client.updates[0].geometry.height, equals(600.0));
    expect(client.updates[0].children.length, equals(2));
    expect(client.updates[0].children[0].id, equals(3));
    expect(client.updates[0].children[0].actions, isEmpty);
    expect(client.updates[0].children[0].flags.hasCheckedState, isFalse);
    expect(client.updates[0].children[0].flags.isChecked, isFalse);
    expect(client.updates[0].children[0].strings.label, equals('child1'));
    expect(client.updates[0].children[0].geometry.transform, isNull);
    expect(client.updates[0].children[0].geometry.left, equals(0.0));
    expect(client.updates[0].children[0].geometry.top, equals(0.0));
    expect(client.updates[0].children[0].geometry.width, equals(800.0));
    expect(client.updates[0].children[0].geometry.height, equals(10.0));
    expect(client.updates[0].children[0].children.length, equals(0));
    expect(client.updates[0].children[1].id, equals(2));
    expect(client.updates[0].children[1].actions, isEmpty);
    expect(client.updates[0].children[1].flags.hasCheckedState, isFalse);
    expect(client.updates[0].children[1].flags.isChecked, isFalse);
    expect(client.updates[0].children[1].strings.label, equals('child2'));
    expect(client.updates[0].children[1].geometry.transform, equals(<double>[1.0,0.0,0.0,0.0, 0.0,1.0,0.0,0.0, 0.0,0.0,1.0,0.0, 0.0,10.0,0.0,1.0]));
    expect(client.updates[0].children[1].geometry.left, equals(0.0));
    expect(client.updates[0].children[1].geometry.top, equals(0.0));
    expect(client.updates[0].children[1].geometry.width, equals(800.0));
    expect(client.updates[0].children[1].geometry.height, equals(10.0));
    expect(client.updates[0].children[1].children.length, equals(0));
    client.updates.clear();
    client.dispose();
  });
}
