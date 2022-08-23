import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:schedule_app/login/bloc/login_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      builder: (context, state) {
        return Form(
          child: Column(
            children: [
              TextField(
                autofocus: false,
                style: TextStyle(color: CommonTheme().primaryColor),
                onChanged: (email) {
                  context
                      .read<LoginBloc>()
                      .add(LoginUserNameChanged(email: email));
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: CommonTheme().primaryColor),
                  prefixIcon: Icon(
                    Icons.email,
                    color: CommonTheme().mainColor,
                  ),
                  fillColor: CommonTheme().placeHolderColor,
                  filled: true,
                  contentPadding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(
                        color: CommonTheme().placeHolderColor,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(
                        color: CommonTheme().placeHolderColor,
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                autofocus: false,
                obscureText: true,
                style: TextStyle(color: CommonTheme().primaryColor),
                onChanged: (password) {
                  context
                      .read<LoginBloc>()
                      .add(LoginPasswordChanged(password: password));
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: CommonTheme().primaryColor),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: CommonTheme().mainColor,
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
                  fillColor: CommonTheme().placeHolderColor,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(
                        color: CommonTheme().placeHolderColor,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide(
                        color: CommonTheme().placeHolderColor,
                      )),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
