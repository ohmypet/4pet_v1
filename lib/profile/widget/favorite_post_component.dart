import 'package:ddi/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/pet_feed/widget/post/post.dart';
import 'package:flutter_template/profile/bloc/bloc.dart';
import 'package:petisland_core/domain/domain.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FavoritePostComponent extends StatefulWidget {
  @override
  _FavoritePostComponentState createState() => _FavoritePostComponentState();
}

class _FavoritePostComponentState extends State<FavoritePostComponent> {
  final FavoritePostBloc bloc = DI.get(FavoritePostBloc);
  final RefreshController controller = RefreshController();

  void initState() {
    super.initState();
    bloc.reload();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocListener<FavoritePostBloc, FavoritePostState>(
        bloc: bloc,
        listener: _onListChanged,
        child: BlocBuilder<FavoritePostBloc, FavoritePostState>(
          bloc: bloc,
          condition: (_, state) => state is ReloadMyPost,
          builder: _buildUIState,
        ),
      );
  }


  Widget _buildUIState(BuildContext context, FavoritePostState state) {
    if (state is ReloadFavoritePost) {
      final items = state.items;
      return SmartRefresher(
        controller: controller,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
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

  void _onRefresh() {
    bloc.reload();
  }

  void _onLoading() {
    bloc.retrievePost();
  }

  void _onListChanged(BuildContext context, FavoritePostState state) {
    if (state is! ReloadFavoritePost) return;
    if (controller.isLoading) {
      controller.loadComplete();
    }
    if (controller.isRefresh) {
      controller.refreshCompleted();
    }
  }
}
