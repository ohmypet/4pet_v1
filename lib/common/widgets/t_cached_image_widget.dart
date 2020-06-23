part of petisland.common.widgets;

class TBaseCachedImageWidget extends StatelessWidget {
  @protected
  static final BaseCacheManager cachedManager =
      DI.get<BaseCacheManager>(DIKeys.cache_image);

  final double width;
  final double height;
  final Decoration decoration;
  final String url;
  final ImageWidgetBuilder imageBuilder;

  /// Widget displayed while the target [petImage] is loading.
  final PlaceholderWidgetBuilder placeholder;

  /// Widget displayed while the target [petImage] failed loading.
  final LoadingErrorWidgetBuilder errorWidget;

  const TBaseCachedImageWidget({
    @required this.url,
    @required this.imageBuilder,
    Key key,
    this.width,
    this.height,
    this.decoration,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return this.url?.isNotEmpty == true
        ? CachedNetworkImage(
            width: width,
            height: height,
            cacheManager: cachedManager,
            imageUrl: this.url,
            imageBuilder: imageBuilder,
            placeholder: placeholder ?? (_, __) => _buildPlaceHolder(),
            errorWidget: errorWidget ?? (_, __, ___) => _buildError(),
          )
        : errorWidget != null ? errorWidget(context, null, 'url is null') : _buildError();
  }

  Widget _buildPlaceHolder() {
    return TImageLoading(
      child: Container(
        height: height,
        width: width,
        decoration: decoration,
        color: decoration == null ? TColors.white : null,
      ),
    );
  }

  Widget _buildError() {
    return Container(
      height: height,
      width: width,
      decoration: decoration,
      color: decoration == null ? TColors.black.withAlpha(40) : null,
    );
  }
}

class TImageLoading extends StatelessWidget {
  final Widget child;

  const TImageLoading({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: child,
    );
  }
}

class TShimmerLoading extends StatelessWidget {
  final BoxShape shape;
  TShimmerLoading() : shape = BoxShape.rectangle;
  TShimmerLoading.circle() : shape = BoxShape.circle;

  @override
  Widget build(BuildContext context) {
    return TImageLoading(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: shape == BoxShape.rectangle ? BorderRadius.circular(5.0) : null,
          shape: shape,
          color: TColors.black,
        ),
      ),
    );
  }
}

class TCacheImageWidget extends StatelessWidget {
  final double width;
  final double height;
  final String url;

  //default border radius = 4
  final BorderRadius borderRadius;
  final Color defaultBackgroundColor;
  final BoxShape shape;

  const TCacheImageWidget({
    @required this.url,
    Key key,
    this.width,
    this.height,
    this.borderRadius,
    this.defaultBackgroundColor = TColors.duck_egg_blue,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BoxShape shape = this.shape ?? BoxShape.rectangle;
    BorderRadius borderRadius;
    if (shape == BoxShape.rectangle)
      borderRadius = this.borderRadius ?? BorderRadius.circular(4);
    return TBaseCachedImageWidget(
      url: url,
      imageBuilder: (_, ImageProvider imageProvider) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            borderRadius: borderRadius,
            color: defaultBackgroundColor,
            shape: shape,
          ),
        );
      },
      placeholder: (_, __) {
        return TImageLoading(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              shape: shape,
              color: TColors.white,
            ),
          ),
        );
      },
      errorWidget: (_, __, ___) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: shape,
            borderRadius: borderRadius,
            color: defaultBackgroundColor,
          ),
        );
      },
    );
  }
}
