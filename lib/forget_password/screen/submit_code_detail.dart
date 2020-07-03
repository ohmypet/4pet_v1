import 'package:flutter/material.dart';
import 'package:flutter_template/common/common.dart';
import 'package:flutter_template/common/widgets/widgets.dart';
import 'package:flutter_template/login/widget/widget.dart';

class SubmitCodeDetail extends StatefulWidget {
  final void Function() onSubmit;
  final void Function() onTapResend;
  final void Function(String) onChange;
  SubmitCodeDetail({this.onSubmit, this.onChange, this.onTapResend, Key key})
      : super(key: key);

  @override
  _SubmitCodeDetailState createState() => _SubmitCodeDetailState();
}

class _SubmitCodeDetailState extends State<SubmitCodeDetail> {
  TextEditingController codeController;
  FocusNode codeFocusNode;
  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
    codeFocusNode = FocusNode()..requestFocus();
  }

  @override
  void dispose() {
    codeController.dispose();
    codeFocusNode.dispose();
    super.dispose();
  }

  ThemeData get theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        UserInputWidget(
          codeController,
          focusNode: codeFocusNode,
          onChange: widget.onChange ?? null,
          hintText: TConstants.hint_code,
          onSubmit: widget.onSubmit ?? null,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              TConstants.text_resend_code,
              style:
                  theme.textTheme.bodyText2.copyWith(color: theme.accentColor),
            ),
            GestureDetector(
              onTap: widget.onTapResend ?? null,
              child: Text(
                'RESEND',
                style: theme.textTheme.bodyText2
                    .copyWith(color: theme.primaryColor),
              ),
            )
          ],
        ),
        PetIslandButtonWidget(
          text: TConstants.text_submit_code,
          onTap: widget.onSubmit ?? null,
        ),
      ],
    );
  }
}
