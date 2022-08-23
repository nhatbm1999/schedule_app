import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_app/common/theme/common_theme.dart';
import 'package:schedule_app/register/bloc/register_bloc.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              onChanged: (name) => context
                  .read<RegisterBloc>()
                  .add(RegisterNameChanged(name: name)),
              decoration: InputDecoration(
                hintText: 'Name',
                errorText: state.name.invalid ? 'Invalid Name' : null,
                helperText: 'Type the name you want to display in this app',
                helperStyle: TextStyle(color: CommonTheme().primaryColor),
                hintStyle: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: CommonTheme().primaryColor),
                prefixIcon: Icon(
                  Icons.person,
                  color: CommonTheme().primaryColor,
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
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(
                      color: CommonTheme().errorColor,
                    )),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(
                      color: CommonTheme().errorColor,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              autofocus: false,
              onChanged: (email) {
                context
                    .read<RegisterBloc>()
                    .add(RegisterEmailChanged(email: email));
              },
              decoration: InputDecoration(
                hintText: 'Email',
                errorText: state.email.invalid && state.email.value.isNotEmpty
                    ? 'Invalid Email'
                    : null,
                hintStyle: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: CommonTheme().primaryColor),
                prefixIcon: Icon(
                  Icons.email,
                  color: CommonTheme().primaryColor,
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
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(
                      color: CommonTheme().errorColor,
                    )),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(
                      color: CommonTheme().errorColor,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              autofocus: false,
              onChanged: (phone) {
                context
                    .read<RegisterBloc>()
                    .add(RegisterPhoneNumberChanged(phone));
              },
              decoration: InputDecoration(
                hintText: 'Phone Number',
                errorText:
                    state.phoneNumber.invalid && state.phoneNumber.value.isNotEmpty ? 'Invalid Phone Number' : null,
                hintStyle: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: CommonTheme().primaryColor),
                prefixIcon: Icon(
                  Icons.phone,
                  color: CommonTheme().primaryColor,
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
                    errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(
                      color: CommonTheme().errorColor,
                    )),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(
                      color: CommonTheme().errorColor,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              autofocus: false,
              obscureText: true,
              onChanged: (password) {
                context
                    .read<RegisterBloc>()
                    .add(RegisterPasswordChanged(password));
              },
              decoration: InputDecoration(
                hintText: 'Password',
                errorText:
                    state.password.value.isNotEmpty && state.password.invalid
                        ? ' Password is invalid'
                        : null,
                hintStyle: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: CommonTheme().primaryColor),
                prefixIcon: Icon(
                  Icons.lock,
                  color: CommonTheme().primaryColor,
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
                    errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(
                      color: CommonTheme().errorColor,
                    )),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(
                      color: CommonTheme().errorColor,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (confirm) {
                context.read<RegisterBloc>().add(RegisterPasswordConfirmChanged(
                    input: state.password.value, confirm: confirm));
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Confirm password',
                errorText: state.confirm != state.password.value &&
                        state.confirm.isNotEmpty
                    ? 'Password not match'
                    : null,
                hintStyle: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: CommonTheme().primaryColor),
                prefixIcon: Icon(
                  Icons.lock_sharp,
                  color: CommonTheme().primaryColor,
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
                    errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(
                      color: CommonTheme().errorColor,
                    )),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(
                      color: CommonTheme().errorColor,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
