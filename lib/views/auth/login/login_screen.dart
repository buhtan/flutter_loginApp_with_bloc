import 'package:flutter/material.dart';
import 'package:flutter_app_with_bloc/blocs/auth/login/login_bloc.dart';
import 'package:flutter_app_with_bloc/blocs/auth/login/login_state.dart';
import 'package:flutter_app_with_bloc/views/auth/form_submission_status.dart';
import 'package:flutter_app_with_bloc/views/auth/login/widgets/form_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/auth/login/login_repository.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: BlocProvider(
        create: (context) =>
            LoginBloc(authRepo: context.read<LoginRepository>()),
        child: BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) =>
              previous.formStatus != current.formStatus,
          listener: (context, state) {
            final formStatus = state.formStatus;

            if (formStatus is SubmissionFailed) {
              _showSnackBar(context, formStatus.exception.toString());
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/yoga-girl.png"),
                  FormWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
