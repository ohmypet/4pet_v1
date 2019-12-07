part of petisland.common.resources;

abstract class TShadows {
  static const List<BoxShadow> defaultShadow = const <BoxShadow>[
    const BoxShadow(
      color: TColors.black10,
      spreadRadius: 2,
      blurRadius: 6,
      offset: const Offset(0, 4),
    )
  ];
}
