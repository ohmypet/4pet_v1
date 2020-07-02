import 'package:flutter/material.dart';
import 'package:flutter_template/common/common.dart';
import 'package:flutter_template/login/widget/widget.dart';

class SubmitCodeDetail extends StatefulWidget {
  final void Function() onSubmit;
  final void Function(String) onChange;
  SubmitCodeDetail({this.onSubmit, this.onChange, Key key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserInputWidget(
          codeController,
          focusNode: codeFocusNode,
          onChange: widget.onChange ?? null,
          hintText: TConstants.hint_code,
          onSubmit: widget.onSubmit ?? null,
          textAlign: TextAlign.center,
          keyboardType:TextInputType.number,
        ),
        PetIslandButtonWidget(
          text: TConstants.text_submit_code,
          onTap: widget.onSubmit ?? null,
        ),
      ],
    );
  }
}
