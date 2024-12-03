import '../../../res/paths/paths.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});

  /// form key
  final _formKey = GlobalKey<FormState>();

  final AuthenticationViewModel _authenticationViewModel = AuthenticationViewModel();

  final storeNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Container(
          width: width * 0.96,
          height: height * 0.59,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: AppColor.primaryColor.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 10)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.01,
              ),

              /// janGhani Name
              const MyText(
                title: "POS App",
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
              SizedBox(
                height: height * 0.04,
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
                        height: 60,
                        fontSize: 17,
                        validator: (val){
                          if(val!.isEmpty){
                            return "Enter email";
                          }else if(!val.contains('@gmail.com')){
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
                        hintText: "Password",
                        width: 390,
                        height: 60,
                        fontSize: 17,
                        validator: (val){
                          if(val!.isEmpty){
                            return "Enter Password";
                          }else if(val.length < 7){
                            return "Password must be grater than 7 characters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      AppTextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        hintText: "Confirm password",
                        width: 390,
                        height: 60,
                        fontSize: 17,
                        validator: (val){
                          if(val!.isEmpty){
                            return "Enter Confirm Password";
                          }
                          else if(passwordController.text != val){
                            return "Confirm password not matched!";
                          }
                          return null;
                        },
                      )
                    ],
                  )),
              SizedBox(
                height: height * 0.03,
              ),

              /// sign in  button
              BlocBuilder<LoadingBloc , LoadingBlocState>(builder: (context , state){
                return AppTextButton(
                  title: "Sign Up",
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
                      print("Working >>>>>>>>>>>>>>");
                      _authenticationViewModel.signUp(context, emailController.text.toString(), passwordController.text.toString());
                    }
                  },
                );
              }),

              const Spacer(),
              Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const MyText(
                        title: "Already have an account",
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