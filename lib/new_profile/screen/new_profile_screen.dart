import 'package:ddi/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_template/common/common.dart';
import 'package:flutter_template/common/state/state.dart';
import 'package:flutter_template/home_page/widget/widget.dart';
import 'package:flutter_template/new_profile/screen/edit_profile_screen.dart';
import 'package:flutter_template/new_profile/widget/tsliver_appbar.dart';
import 'package:flutter_template/pet_feed/widget/post/post.dart';
import 'package:flutter_template/profile/bloc/favorite_post/favorite_post.dart';
import 'package:flutter_template/profile/bloc/my_post/my_post.dart';
import 'package:petisland_core/domain/domain.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum MyProfileTab { MyPost, LikedPost }

class NewProfileScreen extends StatefulWidget {
  @override
  _NewProfileScreenState createState() => _NewProfileScreenState();
}

class _NewProfileScreenState extends TState<NewProfileScreen>
    with SingleTickerProviderStateMixin {
  final Account account = DI.get<AuthenticationBloc>(AuthenticationBloc).account;
  final MyPostBloc myPostbloc = DI.get(MyPostBloc);
  final FavoritePostBloc favoriteBloc = DI.get(FavoritePostBloc);

  final RefreshController controller = RefreshController();
  final tabs = [
    Text('My Post'),
    Text('Liked Post'),
  ];
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
              delegate: TSliverAppBar(
                maxExtent: 180,
                avatarUrl: account?.user?.avatar?.url,
              ),
            )
          ];
        },
        body: SmartRefresher(
          controller: controller,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(child: _buildUserInfo()),
              SliverFillRemaining(
                fillOverscroll: false,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    BottomBarSelector(
                      controller: tabController,
                      builder: iconBuilder,
                    ),
                    Flexible(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          BlocConsumer<MyPostBloc, MyPostState>(
                            bloc: myPostbloc,
                            listener: _onMyListChanged,
                            buildWhen: (_, state) => state is ReloadMyPost,
                            builder: _buildMyPostUIState,
                          ),
                          BlocConsumer<FavoritePostBloc, FavoritePostState>(
                            bloc: favoriteBloc,
                            listener: _onFavoriteListChanged,
                            buildWhen: (_, state) => state is ReloadFavoritePost,
                            builder: _buildFavoriteUIState,
                          )
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

  Widget iconBuilder(BuildContext context, int index, bool isSelected) {
    final theme = Theme.of(context);
    return DefaultTextStyle(
      style: theme.textTheme.headline6.copyWith(
        color: isSelected ? TColors.water_melon : TColors.black,
      ),
      child: tabs[index],
    );
  }

  @override
  void initState() {
    super.initState();
    myPostbloc.reload();
    favoriteBloc.reload();
    tabController = TabController(
      initialIndex: 0,
      vsync: this,
      length: 2,
    );
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

  Widget _buildFavoriteUIState(BuildContext context, FavoritePostState state) {
    if (state is ReloadFavoritePost) {
      final items = state.items;
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        itemCount: state.items.length,
        itemBuilder: (_, index) {
          final PanelDetail panel = items[index];
          return PostWidget(
            panel.postItem,
            key: UniqueKey(),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      );
    } else
      return SizedBox();
  }

  Widget _buildLocation(String locationName) {
    final theme = Theme.of(context);

    return Text(
      locationName,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.bodyText2.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _buildMyPostUIState(BuildContext context, MyPostState state) {
    if (state is ReloadMyPost) {
      final items = state.items;
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        itemCount: state.items.length,
        itemBuilder: (_, index) {
          final PanelDetail postDetail = items[index];
          return PostWidget(
            postDetail.postItem,
            key: UniqueKey(),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      );
    } else
      return SizedBox();
  }

  Widget _buildUserInfo() {
    final name = account.getName();
    final address = account?.user?.address;
    final theme = Theme.of(context);
    return Flex(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      direction: Axis.vertical,
      children: <Widget>[
        Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDisplayName(name),
            SizedBox(width: 2),
            GestureDetector(
              onTap: _onTapEdit,
              child: Icon(
                Icons.edit,
                color: theme.primaryColor,
                size: 16,
              ),
            ),
          ],
        ),
        address != null ? _buildLocation(address) : SizedBox(),
      ],
    );
  }

  void _onFavoriteListChanged(BuildContext context, FavoritePostState state) {
    if (state is! ReloadFavoritePost) return;
    if (controller.isLoading) {
      controller.loadComplete();
    }
    if (controller.isRefresh) {
      controller.refreshCompleted();
    }
  }

  void _onLoading() {
    if (tabController.index == MyProfileTab.LikedPost.index) {
      myPostbloc.retrievePost();
    } else {
      favoriteBloc.retrievePost();
    }
  }

  void _onMyListChanged(BuildContext context, MyPostState state) {
    if (state is! ReloadMyPost) return;
    if (controller.isLoading) {
      controller.loadComplete();
    }
    if (controller.isRefresh) {
      controller.refreshCompleted();
    }
  }

  void _onRefresh() {
    if (tabController.index == MyProfileTab.MyPost.index) {
      myPostbloc.reload();
    } else {
      favoriteBloc.reload();
    }
  }

  void _onTapEdit() {
    navigateToScreen(
      context: context,
      screen: EditProfileScreen(),
    );
  }
}
