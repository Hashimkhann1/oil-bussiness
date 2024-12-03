
import '../../res/paths/paths.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {

    SplashViewModel().splashTime(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyText(title: "Pos App",fontSize: 60,fontWeight: FontWeight.w900,color: AppColor.white.withOpacity(0.9),),
            CircularProgressIndicator(color: AppColor.white.withOpacity(0.9),)
          ],
        ),
      ),
    );
  }
}
