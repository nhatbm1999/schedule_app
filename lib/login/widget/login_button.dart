import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:schedule_app/login/bloc/login_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: 350,
                height: 60,
                child: ElevatedButton(
                  onPressed: state.status.isValidated ? () {
                    FocusScope.of(context).unfocus();
                    context.read<LoginBloc>().add(const LoginSubmitted());
                  } : null,
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: CommonTheme().mainColor),
                  child: Text(
                    'SIGN IN',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: CommonTheme().backgroundColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
      },
    );
  }
}
