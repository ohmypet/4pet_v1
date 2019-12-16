library petisland.post.post_edit.widget;

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_template/common/common.dart';
import 'package:flutter_template/common/widgets/widgets.dart';
import 'package:flutter_template/login/widget/widget.dart';
import 'package:flutter_template/pet_feed/widget/post/post.dart';
import 'package:flutter_template/post/post_edit/bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petisland_core/petisland_core.dart';

part 'send_widget.dart';

part 'post_edit_body.dart';

part 'summary_info_widget.dart';

part 'title_post_input.dart';

part 'price_post_input.dart';

part 'desc_post_input.dart';

part 'image_post_input.dart';

part 'expand_widget.dart';

part 'location_post_input.dart';

part 'pet_category_input.dart';

part 'image_choose_popup.dart';

part 'image_post_widget.dart';

part 'add_image_post_widget.dart';

TextStyle _getTitleTextStyle(BuildContext context) {
  final theme = Theme.of(context);
  return theme.textTheme.display4.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: theme.accentColor.withAlpha(225),
  );
}

class _TitleWidget extends StatelessWidget {
  final String title;
  final bool isRequired;

  const _TitleWidget({Key key, @required this.title, this.isRequired = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: _getTitleTextStyle(context),
        ),
        isRequired
            ? TextSpan(
                text: ' *',
                style: _getTitleTextStyle(context).copyWith(color: TColors.red),
              )
            : TextSpan()
      ]),
    );
  }
}
