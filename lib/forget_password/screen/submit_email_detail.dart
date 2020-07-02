import 'package:flutter/material.dart';
import 'package:flutter_template/common/common.dart';
import 'package:flutter_template/common/widgets/widgets.dart';
import 'package:flutter_template/login/widget/widget.dart';

class SubmitEmailDetail extends StatefulWidget {
  final void Function() onSubmit;
  final void Function(String) onChange;
  SubmitEmailDetail({this.onSubmit, this.onChange, Key key}) : super(key: key);

  @override
  _SubmitEmailDetailState createState() => _SubmitEmailDetailState();
}

class _SubmitEmailDetailState extends State<SubmitEmailDetail> {
  TextEditingController emailController;
  FocusNode emailFocusNode;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    emailFocusNode = FocusNode()..requestFocus();
  }

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        UserInputWidget(
          emailController,
          focusNode: emailFocusNode,
          onChange: widget.onChange ?? null,
          hintText: TConstants.hint_email,
          icon: Icon(Icons.mail, size: 22),
          onSubmit: widget.onSubmit ?? null,
        ),
        PetIslandButtonWidget(
          text: TConstants.text_submit_email,
          onTap: widget.onSubmit ?? null,
        ),
      ],
    );
  }
}
