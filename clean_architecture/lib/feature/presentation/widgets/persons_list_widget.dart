import 'dart:async';

import 'package:clean_architecture/feature/domain/entities/person_entity.dart';
import 'package:clean_architecture/feature/presentation/bloc/person_list/person_list_cubit.dart';
import 'package:clean_architecture/feature/presentation/widgets/person_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonsList extends StatelessWidget {
  PersonsList({super.key});

  final ScrollController scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<PersonListCubit>().loadPerson();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    return BlocBuilder<PersonListCubit, PersonListState>(
      builder: (context, state) {
        List<PersonEntity> persons = [];
        bool isLoading = false;

        if (state is PersonListLoding && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PersonListLoding) {
          persons = state.oldPersonList;
          isLoading = true;
        } else if (state is PersonListLoaded) {
          persons = state.personList;
        } else if (state is PersonListError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          );
        }
        return ListView.separated(
          controller: scrollController,
          itemCount: persons.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < persons.length) {
              return PersonCard(
                person: persons[index],
              );
            } else {
              Timer(const Duration(microseconds: 50), () {
                scrollController.jumpTo(
                  scrollController.position.maxScrollExtent,
                );
              });
              return _loadingIndicator();
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Colors.grey[400]);
          },
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
