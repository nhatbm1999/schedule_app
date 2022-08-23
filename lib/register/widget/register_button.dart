import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:schedule_app/register/bloc/register_bloc.dart';
import 'package:formz/formz.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: 350,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<RegisterBloc>().add(RegisterSubmit());
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: CommonTheme().mainColor),
                  child: Text(
                    'SIGN UP',
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
