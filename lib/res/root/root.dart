

import 'package:oil_bussiness/view_model/bloc/user_data_bloc/user_data_bloc/user_data_bloc.dart';

import '../paths/paths.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LoadingBloc()),
          BlocProvider(create: (_) => UserDataBloc()),
        ],
        child: MaterialApp(
          title: 'Oil Business',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SplashView(),
        )
    );
  }
}