import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:news_app_with_states/data/data_source/dio_service.dart';
import 'package:news_app_with_states/data/models/news_model.dart';
import '../widgets/news_card.dart';
import 'news_detail_screen.dart';

enum NewsStatus { initial, loading, success, empty, error }

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  NewsStatus _status = NewsStatus.initial;
  List<NewsModel> _newsList = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchNews('egypt');
  }

  Future<void> _fetchNews(String query) async {
    setState(() {
      _status = NewsStatus.loading;
    });

    try {
      final news = await DioService().getNews(searchedItem: query);

      setState(() {
        if (news.isEmpty) {
          _status = NewsStatus.empty;
        } else {
          _status = NewsStatus.success;
          _newsList = news;
        }
      });
    } catch (e) {
      setState(() {
        _status = NewsStatus.error;
        _errorMessage = 'Failed to fetch news';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Briefly'),
        actions: [
          SizedBox(
            width: 220,
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                //context.read<NewsListCubit>().getNews(searchedItem: value);
                _fetchNews(value);
              },
              decoration: const InputDecoration(
                hintText: 'Search news...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _fetchNews(_searchController.text);
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (_status) {
            case NewsStatus.initial:
              return const Center(child: Text('Welcome! Search for news.'));
            case NewsStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case NewsStatus.empty:
              return const Center(child: Text('No news found'));
            case NewsStatus.error:
              return Center(child: Text(_errorMessage));
            case NewsStatus.success:
              return ListView.builder(
                itemCount: _newsList.length,
                itemBuilder: (context, index) {
                  final item = _newsList[index];
                  return NewsCard(
                    id: item.id,
                    title: item.title,
                    description: item.description,
                    imageUrl: item.imageUrl,
                    source: item.source,
                    publishedAt: DateTime.parse(item.publishedAt),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NewsDetailScreen(article: item),
                        ),
                      );
                    },
                  );
                },
              );
          }
        },
      ),
      // body: BlocBuilder<NewsListCubit, NewsListState>(
      //   builder: (context, state) {
      //     if (state is NewsListLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     }

      //     if (state is NewsListEmpty) {
      //       return const Center(child: Text('No news found'));
      //     }

      //     if (state is NewsListError) {
      //       return Center(child: Text(state.message));
      //     }

      //     if (state is NewsListSuccess) {
      //       return ListView.builder(
      //         itemCount: state.news.length,
      //         itemBuilder: (context, index) {
      //           final item = state.news[index];
      //           return NewsCard(
      //             id: item.id,
      //             title: item.title,
      //             description: item.description,
      //             imageUrl: item.imageUrl,
      //             source: item.source,
      //             publishedAt: DateTime.parse(item.publishedAt),
      //             onTap: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (_) => NewsDetailScreen(article: item),
      //                 ),
      //               );
      //             },
      //           );
      //         },
      //       );
      //     }

      //     return const SizedBox();
      //   },
      // ),
    );
  }
}
