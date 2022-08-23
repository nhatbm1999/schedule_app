import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app/authentication/repository/authentication_repository.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:schedule_app/gen/assets.gen.dart';
import 'package:schedule_app/login/bloc/login_bloc.dart';
import 'package:schedule_app/login/widget/login_button.dart';
import 'package:schedule_app/login/widget/login_form.dart';
import 'package:schedule_app/register/view/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const LoginPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SingleChildScrollView(
       child: Center(
         child: BlocProvider(
           create: (context) => LoginBloc(
             authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context)
           ),
           child: Padding(
             padding: const EdgeInsets.only(top: 100),
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 30),
               child: Column(
                 children: [
                   Assets.image.scheduleLogo.image(width: 200, height: 200),
                   const SizedBox(
                      height: 20,
                    ),
                    const LoginForm(),
                    const SizedBox(height: 20,),
                    const LoginButton(),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Don't have an account ?",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      child: Text(
                        'SIGN UP NOW',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: CommonTheme().mainColor,
                                fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(RegisterPage.route());
                      },
                    )
                 ],
               ),
             ),
           ),
         ),
       ),
     ),
    );
  }
}