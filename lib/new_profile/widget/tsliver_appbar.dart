import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/common/common.dart';
import 'package:flutter_template/common/widgets/widgets.dart';
import 'package:petisland_core/petisland_core.dart';

class TSliverAppBar extends SliverPersistentHeaderDelegate {
  @override
  final double maxExtent;

  @override
  final double minExtent;

  final String avatarUrl;

  final String backgroundUrl;

  const TSliverAppBar(
      {this.maxExtent = 200,
      this.minExtent = kToolbarHeight,
      this.avatarUrl,
      this.backgroundUrl});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final border = 30 - shrinkOffset / 7;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(decoration: BoxDecoration(gradient: TGradients.avatarGradient),),
        _getAvatar(avatarUrl),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: maxExtent / 4,
            decoration: BoxDecoration(
              color: TColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(border),
                topRight: Radius.circular(border),
              ),
            ),
          ),
        ),
        Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Flexible(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Opacity(
                  opacity: (1 - shrinkOffset / maxExtent),
                  child: GestureDetector(
                    onTap: _onTap,
                    child: buildAvatar(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildAvatar() {
    final image = _getAvatar(avatarUrl);
    return FittedBox(
      child: Card(
        elevation: 1,
        child: SizedBox(
          width: maxExtent / 2,
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              child: image,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  Widget _getAvatar(String avatar) {
    return avatarUrl != null
        ? TCacheImageWidget(url: avatarUrl)
        : SvgPicture.asset(TAssets.user_avatar);
  }

  void _onTap() {
    Log.info('_onTap:: ${DateTime.now()}');
  }
}
