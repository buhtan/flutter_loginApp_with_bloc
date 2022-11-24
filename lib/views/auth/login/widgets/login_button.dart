import 'package:flutter/material.dart';
import 'package:flutter_app_with_bloc/blocs/auth/login/login_bloc.dart';
import 'package:flutter_app_with_bloc/blocs/auth/login/login_event.dart';
import 'package:flutter_app_with_bloc/blocs/auth/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../form_submission_status.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key, required this.formKey}) : super(key: key);

  final dynamic formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                },
                child: const Text('Login'),
              );
      },
    );
  }
}
