import 'package:clean_architecture/feature/domain/entities/person_entity.dart';
import 'package:clean_architecture/feature/presentation/bloc/search/search_bloc.dart';
import 'package:clean_architecture/feature/presentation/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSearchDelegate extends SearchDelegate {
  // CustomSearchDelegate({super.searchFieldLabel = });

  final _suggestions = ['Rick', 'Morty'];
  final scrollController = ScrollController();

  @override
  String? get searchFieldLabel => "Search for characters...";

  @override
  TextStyle? get searchFieldStyle => const TextStyle(color: Colors.white);

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<SearchBloc>();
        }
      }
    });
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: const Icon(Icons.clear),
        color: Colors.white,
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
      color: Colors.white,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    debugPrint("Inside custom search delegate and search query is $query");

    BlocProvider.of<SearchBloc>(context, listen: false).add(
      SearchPersonsEvent(query),
    );
    _suggestions.add(query);

    setupScrollController(context);
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchLoadedState) {
          final persons = state.persons;
          if (persons.isEmpty) {
            return _showErrorText("No characters with that name found");
          }
          debugPrint(persons.length.toString());
          return SizedBox(
            child: ListView.builder(
              controller: scrollController,
              itemCount: persons.isNotEmpty ? persons.length : 0,
              itemBuilder: (context, index) {
                PersonEntity result = persons[index];
                return SearchResult(personResult: result);
              },
            ),
          );
        } else if (state is SearchErrorState) {
          return _showErrorText(state.message);
        } else {
          return const Center(
            child: Icon(Icons.now_wallpaper),
          );
        }
      },
    );
  }

  Widget _showErrorText(String errorMessage) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }
    return ListView.separated(
      padding: const EdgeInsets.all(15),
      itemBuilder: (context, index) {
        return Text(
          _suggestions[index],
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: _suggestions.length,
    );
  }
}
