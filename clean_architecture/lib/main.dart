import 'package:clean_architecture/common/app_colors.dart';
import 'package:clean_architecture/feature/presentation/bloc/person_list/person_list_cubit.dart';
import 'package:clean_architecture/feature/presentation/bloc/search/search_bloc.dart';
import 'package:clean_architecture/feature/presentation/pages/home_page.dart';
import 'package:clean_architecture/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:clean_architecture/service_locator.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit>(
          create: (context) => sl<PersonListCubit>()..loadPerson(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => sl<SearchBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Rick and Morty',
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
