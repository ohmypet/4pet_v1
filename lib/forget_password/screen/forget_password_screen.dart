import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/state/state.dart';
import 'package:flutter_template/forget_password/bloc/forget_password_bloc.dart';
import 'package:flutter_template/forget_password/screen/submit_code_detail.dart';
import 'package:flutter_template/forget_password/screen/submit_email_detail.dart';
import 'package:flutter_template/forget_password/screen/submit_new_password_detail.dart';
import 'package:flutter_template/login/widget/widget.dart';
import 'package:petisland_core/petisland_core.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const name = '/ForgetPasswordScreen';
  ForgetPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends TState<ForgetPasswordScreen> {
  String appbarTitle = '';
  int currentIndex = 0;
  final ForgetPasswordBloc forgetBloc = ForgetPasswordBloc();
  PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
          bloc: forgetBloc,
          builder: (context, state) {
            appbarTitle = getTitleFromState(state) ?? appbarTitle;
            return Text(appbarTitle);
          },
        ),
      ),
      body: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
          bloc: forgetBloc,
          listener: handleBlocStateChange,
          builder: (context, state) {
            bool canSubmitEmail =
                forgetBloc.email.isNotEmpty && (forgetBloc.state is! ErrorStepOneState);
            bool canSubmitCode =
                forgetBloc.code.isNotEmpty && (forgetBloc.state is! ErrorStepTwoState);
            bool canSubmitPassword = forgetBloc.password.isNotEmpty &&
                forgetBloc.rePassword.isNotEmpty &&
                (forgetBloc.state is! ErrorStepThreeState);
            return Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: <Widget>[
                      Center(
                        child: SubmitEmailDetail(
                          onChange: (text) => forgetBloc.add(TypingEmail(text)),
                          onSubmit:
                              canSubmitEmail ? () => forgetBloc.add(SubmitEmail()) : null,
                        ),
                      ),
                      Center(
                        child: SubmitCodeDetail(
                          onChange: (text) => forgetBloc.add(TypingCode(text)),
                          onTapResend: ()=> canSubmitEmail ? () => forgetBloc.add(SubmitEmail()) : null,
                          onSubmit:
                              canSubmitCode ? () => forgetBloc.add(SubmitCode()) : null,
                        ),
                      ),
                      Center(
                        child: SubmitNewPasswordDetail(
                          onNewPasswordChange: (text) =>
                              forgetBloc.add(TypingNewPassword(text)),
                          onRePasswordChange: (text) =>
                              forgetBloc.add(TypingRePassword(text)),
                          onSubmit: canSubmitPassword
                              ? () => forgetBloc.add(SubmitNewPassword())
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (BuildContext context) {
                    return BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                      bloc: forgetBloc,
                      builder: (_, state) {
                        return state is Loading ? const LoadingWidget() : SizedBox();
                      },
                    );
                  },
                )
              ],
            );
          }),
    );
  }

  String getTitleFromState(ForgetPasswordState state) {
    String title;
    if (state is StepOneState || state is ErrorStepOneState) {
      title = 'Submit Email';
    }
    if (state is StepTwoState || state is ErrorStepTwoState) {
      title = 'Submit Code';
    }
    if (state is StepThreeState || state is ErrorStepThreeState) {
      title = 'Create New Password';
    }
    return title;
  }

  int getIndexFromState(ForgetPasswordState state) {
    int index = currentIndex;
    if (state is StepOneState || state is ErrorStepOneState) {
      index = 0;
    }
    if (state is StepTwoState || state is ErrorStepTwoState) {
      index = 1;
    }
    if (state is StepThreeState || state is ErrorStepThreeState) {
      index = 2;
    }
    return index;
  }

  void handleBlocStateChange(BuildContext context, ForgetPasswordState state) {
    try {
      scrollPageWhenStateChange(state);
      showErrorIfErorState(context, state);
      navigateToHomeWhenSuccess(context, state);
    } catch (ex, trace) {
      Log.error(ex);
      Log.error(trace);
    }
  }

  void scrollPageWhenStateChange(ForgetPasswordState state) {
    int newStep = getIndexFromState(state);
    bool needToScroll = newStep != currentIndex;
    if (needToScroll) {
      pageController.animateToPage(
        newStep,
        curve: Curves.bounceIn,
        duration: Duration(milliseconds: 400),
      );
    }
  }

  void showErrorIfErorState(BuildContext context, ForgetPasswordState state) {
    if (state is Error) {
      showErrorSnackBar(context: context, content: state.message);
    }
  }

  void navigateToHomeWhenSuccess(BuildContext context, ForgetPasswordState state) {
    if (state is SuccessForgetPasswordState) {
      Navigator.of(context).pop();
    }
  }
}
