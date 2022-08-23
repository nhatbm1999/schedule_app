import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:schedule_app/register/bloc/register_bloc.dart';
import 'package:schedule_app/register/repository/register_repository.dart';
import 'package:schedule_app/register/widget/register_button.dart';
import 'package:schedule_app/register/widget/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
              create: (context) {
                return RegisterBloc(
                    registerRepository:
                        RegisterRepository(httpClient: context.read<Dio>()));
              },
              child: const RegisterPage(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            barrierDismissible: false,
            title: 'Register successfully!',
            text: 'Click OK to return to login page',
            onConfirmBtnTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            }
          );
        }
        if (state.status.isSubmissionFailure) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            barrierDismissible: false,
            title: 'Register Failed!',
            text: 'Something Wrong...',
            onConfirmBtnTap: () {
              Navigator.pop(context);
            }
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: CommonTheme().mainColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SIGN UP',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: CommonTheme().mainColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //const UserNameInput(),
                      const RegisterForm(),
                      const SizedBox(
                        height: 20,
                      ),
                      // const AvatarPicker(),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      const RegisterButton(),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have account ?',
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(
                            width: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: CommonTheme().mainColor,
                                      fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
