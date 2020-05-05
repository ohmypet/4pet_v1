import 'package:flutter/material.dart';
import 'package:flutter_template/common/state/state.dart';
import 'package:flutter_template/new_profile/widget/tsliver_appbar.dart';

class NewProfileScreen extends StatefulWidget {
  @override
  _NewProfileScreenState createState() => _NewProfileScreenState();
}

class _NewProfileScreenState extends TState<NewProfileScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: false,
            floating: false,
            delegate: TSliverAppBar(maxExtent: 200),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) => ListTile(
                title: Text('Index: $index'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
