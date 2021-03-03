import 'package:bwa_flutix/bloc/page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/blocs.dart';
import 'ui/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => PageBloc(),
          ),
          BlocProvider(
            create: (_) => UserBloc(),
          ),
          BlocProvider(
            create: (_) => ThemeBloc(),
          ),
          BlocProvider(
            create: (_) => MovieBloc()..add(FetchMovies()),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (_, themeState) {
            return MaterialApp(
              theme: themeState.themeData,
              debugShowCheckedModeBanner: false,
              home: Wrapper(),
            );
          },
        ),
      ),
    );
  }
}
