import 'package:flutter/material.dart';
import 'package:flutter_template/common/common.dart';
import 'package:flutter_template/login/widget/widget.dart';

class SubmitNewPasswordDetail extends StatefulWidget {
  final void Function() onSubmit;
  final void Function(String) onNewPasswordChange;
  final void Function(String) onRePasswordChange;
  SubmitNewPasswordDetail(
      {this.onSubmit,
      this.onNewPasswordChange,
      this.onRePasswordChange,
      Key key})
      : super(key: key);

  @override
  _SubmitNewPasswordDetailState createState() =>
      _SubmitNewPasswordDetailState();
}

class _SubmitNewPasswordDetailState extends State<SubmitNewPasswordDetail> {
  TextEditingController newPasswordController;
  TextEditingController rePasswordController;
  FocusNode newPasswordNode;
  FocusNode rePasswordNode;
  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    rePasswordController = TextEditingController();
    newPasswordNode = FocusNode()..requestFocus();
    rePasswordNode = FocusNode();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    rePasswordController.dispose();
    newPasswordNode.dispose();
    rePasswordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserInputWidget(
          newPasswordController,
          focusNode: newPasswordNode,
          onChange: widget.onNewPasswordChange ?? null,
          hintText: TConstants.hint_new_password,
          icon: Icon(Icons.lock_outline, size: 22),
          onSubmit: () => rePasswordNode.requestFocus(),
          isObscureText: true,
        ),
        UserInputWidget(
          rePasswordController,
          focusNode: rePasswordNode,
          onChange: widget.onRePasswordChange ?? null,
          hintText: TConstants.hint_re_password,
          isObscureText: true,
          icon: Icon(Icons.lock_outline, size: 22),
          onSubmit: widget.onSubmit ?? null,
        ),
        PetIslandButtonWidget(
          text: TConstants.text_submit_password,
          onTap: widget.onSubmit ?? null,
        ),
      ],
    );
  }
}
