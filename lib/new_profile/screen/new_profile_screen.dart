import 'package:ddi/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/state/state.dart';
import 'package:flutter_template/home_page/widget/widget.dart';
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

class _NewProfileScreenState extends TState<NewProfileScreen>
    with SingleTickerProviderStateMixin {
  final MyPostBloc bloc = DI.get(MyPostBloc);
  final RefreshController controller = RefreshController();
  final tabs = [Text('My post'), Text('Liked post')];
  TabController tabController;

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
        body: SmartRefresher(
          controller: controller,
          physics: ClampingScrollPhysics(),
          primary: true,
          enablePullDown: true,
          enablePullUp: true,
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          child: CustomScrollView(
            primary: true,
            slivers: <Widget>[
              SliverToBoxAdapter(child: _buildUserInfo()),
              SliverFillRemaining(
                fillOverscroll: false,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    BottomBarSelector(
                      controller: tabController,
                      builder: iconBuilder,
                    ),
                    Flexible(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          BlocConsumer<MyPostBloc, MyPostState>(
                            bloc: bloc,
                            listener: _onListChanged,
                            buildWhen: (_, state) => state is ReloadMyPost,
                            builder: _buildUIState,
                          ),
                          Container(color: TColors.water_melon)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
    tabController = TabController(
      initialIndex: 0,
      vsync: this,
      length: 2,
    );
  }

  Widget _buildActionBar() {
    return Container(color: TColors.scarlet_gum);
  }

  Widget _buildDisplayName(String displayName) {
    final theme = Theme.of(context);
    return Text(
      displayName,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.headline1.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildLocation(String locationName) {
    final theme = Theme.of(context);

    return Text(locationName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyText2
            .copyWith(fontSize: 14, fontWeight: FontWeight.w300));
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
      return ListView.separated(
        primary: true,
        physics: ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        itemCount: state.items.length,
        itemBuilder: (_, index) {
          final PanelDetail postDetail = items[index];
          return PostWidget(postDetail.postItem);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      );
    } else
      return SizedBox();
  }

  Widget _buildUserInfo() {
    return Flex(
      mainAxisSize: MainAxisSize.min,
      direction: Axis.vertical,
      children: <Widget>[
        _buildDisplayName('Vi Chi Thien'),
        _buildLocation('Sông Ray, Đồng Nai'),
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

  Widget iconBuilder(BuildContext context, int index, bool isSelected) {
    final theme = Theme.of(context);
    return DefaultTextStyle(
      style: theme.textTheme.headline6.copyWith(
        color: isSelected ? TColors.water_melon : TColors.black,
      ),
      child: tabs[index],
    );
  }
}
