import 'package:flutter/material.dart';
import 'package:flutter_template/petisland.dart';

class TSliverAppBar extends SliverPersistentHeaderDelegate {
  const TSliverAppBar({this.maxExtent = 200, this.minExtent = kToolbarHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final border = 30 - shrinkOffset / 7;
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          "https://github.com/tvc12.png",
          fit: BoxFit.cover,
        ),
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
        Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: (1 - shrinkOffset / maxExtent),
            child: GestureDetector(
              onTap: _onTap,
              child: Card(
                elevation: 5,
                child: SizedBox(
                  width: maxExtent / 2,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      child: Image.network(
                        'https://github.com/tvc12.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  final double maxExtent;

  @override
  final double minExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  void _onTap() {
    Log.info("_onTap:: ${DateTime.now()}");
  }
}
