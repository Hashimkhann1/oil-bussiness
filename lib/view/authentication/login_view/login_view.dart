import '../../../res/paths/paths.dart';


class LoginView extends StatelessWidget {
  LoginView({super.key});

  /// form key
  final _formKey = GlobalKey<FormState>();
  final AuthenticationViewModel _authenticationViewModel = AuthenticationViewModel();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Container(
          width: width * 0.96,
          height: height * 0.44,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: AppColor.black.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 10)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.01,
              ),

              /// jan Ghani Name
              const MyText(
                title: "POS App",
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
              SizedBox(
                height: height * 0.08,
              ),

              /// form
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: emailController,
                        hintText: "Email",
                        width: 390,
                        height: height * 0.05,
                        fontSize: 17,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter email";
                          } else if (!val.contains('@gmail.com')) {
                            return "Enter valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      AppTextField(
                        controller: passwordController,
                        obscureText: true,
                        hintText: "password",
                        width:390,
                        height: height * 0.05,
                        fontSize: 17,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Password";
                          } else if (val.length < 7) {
                            return "Password must be grater than 7 characters";
                          }
                          return null;
                        },
                      )
                    ],
                  )),
              SizedBox(
                height: height * 0.02,
              ),

              /// sign in  button
              BlocBuilder<LoadingBloc , LoadingBlocState>(builder: (context , state) {
                return AppTextButton(
                  title: "Log In",
                  textColor: AppColor.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  backgroundColor: AppColor.primaryColor,
                  width: 170,
                  height: 50,
                  borderRadius: 22,
                  isLoading: state.isLoading,
                  onTap: () {
                    if(_formKey.currentState!.validate()){
                      _authenticationViewModel.signIn(context, emailController.text.toString(), passwordController.text.toString());
                    }
                  },
                );
              }),

              const Spacer(),
              Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupView()));
                      },
                      child: const MyText(
                        title: "Don't have an account",
                        fontSize: 16,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
