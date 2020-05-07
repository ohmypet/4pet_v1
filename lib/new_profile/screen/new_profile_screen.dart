import 'package:ddi/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/state/state.dart';
import 'package:flutter_template/new_profile/widget/tsliver_appbar.dart';
import 'package:flutter_template/pet_feed/widget/post/post.dart';
import 'package:flutter_template/petisland.dart';
import 'package:flutter_template/profile/bloc/my_post/my_post.dart';
import 'package:petisland_core/domain/domain.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewProfileScreen extends StatefulWidget {
  @override
  _NewProfileScreenState createState() => _NewProfileScreenState();
}

class _NewProfileScreenState extends TState<NewProfileScreen> {
  final MyPostBloc bloc = DI.get(MyPostBloc);
  final RefreshController controller = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverPersistentHeader(
              pinned: false,
              floating: true,
              delegate: TSliverAppBar(maxExtent: 200),
            )
          ];
        },
        body: CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(child: _buildUserInfo(), hasScrollBody: false),
            SliverFillRemaining(child: _buildActionBar()),
            SliverFillRemaining(
              child: BlocConsumer<MyPostBloc, MyPostState>(
                bloc: bloc,
                listener: _onListChanged,
                buildWhen: (_, state) => state is ReloadMyPost,
                builder: _buildUIState,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    bloc.reload();
  }

  Widget _buildActionBar() {
    return Container(color: TColors.scarlet_gum, height: 50);
  }

  Widget _buildTabs({List<Widget> tabs}) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Container(color: TColors.sky, height: 35),
        Flexible(child: tabs.first)
      ],
    );
  }

  Widget _buildUIState(BuildContext context, MyPostState state) {
    if (state is ReloadMyPost) {
      final items = state.items;
      return SmartRefresher(
        controller: controller,
        physics: ClampingScrollPhysics(),
        enablePullDown: true,
        primary: true,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.separated(
          primary: false,
          physics: ClampingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          itemCount: state.items.length,
          itemBuilder: (_, index) {
            final PanelDetail notification = items[index];
            return PostWidget(notification.postItem);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      );
    } else
      return SizedBox();
  }

  Widget _buildUserInfo() {
    return Flex(
      mainAxisSize: MainAxisSize.max,
      direction: Axis.vertical,
      children: <Widget>[
        Text(
            'Meo Meo log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }'),
        Text('Con Cho Con Meo'),
      ],
    );
  }

  void _onListChanged(BuildContext context, MyPostState state) {
    if (state is! ReloadMyPost) return;
    if (controller.isLoading) {
      controller.loadComplete();
    }
    if (controller.isRefresh) {
      controller.refreshCompleted();
    }
  }

  void _onLoading() {
    bloc.retrievePost();
  }

  void _onRefresh() {
    bloc.reload();
  }

  Widget _buildText() {
    return Text(
        'Meo Meo log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 }log_debug:: MyPostBloc: Transition { currentState: InitMyPostState, event: _ReloadUIEvent, nextState: ReloadMyPost-1 abcxyzabcxyzabcxyzabcxyzabcxyzabcxyzabcxyzabcxyzabcxyzabcxyzabcxyzabcxyz}');
  }
}
