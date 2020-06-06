part of petisland.common.resources;

abstract class TShadows {
  static const List<BoxShadow> defaultShadow = const <BoxShadow>[
    const BoxShadow(
      color: TColors.black10,
      spreadRadius: 2,
      blurRadius: 6,
      offset: const Offset(1, 2),
    )
  ];

  static const List<BoxShadow> innerShadow = const <BoxShadow>[
    const BoxShadow(
      color: TColors.black20,
      spreadRadius: 2,
      blurRadius: 6,
      offset: const Offset(0, 2),
    )
    // const BoxShadow(
    //   color: TColors.black10,
    //   spreadRadius: 2,
    //   blurRadius: 6,
    //   offset: const Offset(0, 4),
    // )
  ];
}
