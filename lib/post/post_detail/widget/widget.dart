library petisland.post.screen.widget;

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_template/common/common.dart';
import 'package:flutter_template/common/utils/utils.dart';
import 'package:flutter_template/common/widgets/widgets.dart';
import 'package:flutter_template/pet_feed/widget/widget.dart';
import 'package:flutter_template/post/post_detail/bloc/bloc.dart';
import 'package:petisland_core/domain/domain.dart';
import 'package:petisland_core/petisland_core.dart';

part 'comment/comment_default_widget.dart';
part 'comment/comment_description_widget.dart';
part 'comment/comment_input_bar_widget.dart';
part 'comment/comment_input_widget.dart';
part 'comment/comment_listing_widget.dart';
part 'comment/comment_widget.dart';
part 'post/image_slider_widget.dart';
part 'post/post_description_widget.dart';
part 'post/post_detail_app_bar.dart';
part 'post/post_detail_summary_widget.dart';
part 'report/report_option.dart';
part 'report/report_post_widget.dart';
