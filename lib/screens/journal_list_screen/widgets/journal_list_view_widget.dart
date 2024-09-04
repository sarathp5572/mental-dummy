import 'package:flutter/material.dart';
import 'package:mentalhelth/screens/home_screen/provider/home_provider.dart';
import 'package:mentalhelth/screens/journal_list_screen/provider/journal_list_provider.dart';
import 'package:mentalhelth/utils/core/image_constant.dart';
import 'package:mentalhelth/widgets/widget/shimmer.dart';
import 'package:provider/provider.dart';

import '../../journal_view_screen/journal_view_screen.dart';
import 'userprofilelist1_item_widget.dart';

class JournalListViewWidget extends StatefulWidget {
  const JournalListViewWidget({super.key});

  @override
  State<JournalListViewWidget> createState() => _JournalListViewWidgetState();
}

class _JournalListViewWidgetState extends State<JournalListViewWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // HomeProvider homeProvider = Provider.of<HomeProvider>(
    //   context,
    //   listen: false,
    // );
    // homeProvider.fetchJournals(initial: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_loadMoreData);
    });
    super.initState();
  }

  void _loadMoreData() {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      homeProvider.fetchJournals();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<JournalListProvider, HomeProvider>(
        builder: (context, journalListProvider, homeProvider, _) {
      return RefreshIndicator(
        onRefresh: () async {
          homeProvider.fetchJournals(initial: true);
        },
        child: Container(
          color: homeProvider.journalsModelList.isEmpty &&
                  !homeProvider.journalsModelLoading
              ? Colors.white
              : null,
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child:
              homeProvider.journalsModelList == null &&
                      !homeProvider.journalsModelLoading
                  ? Center(
                      child: Image.asset(
                        ImageConstant.noData,
                      ),
                    )
                  : homeProvider.journalsModelList.isEmpty &&
                          !homeProvider.journalsModelLoading
                      ? Center(
                          child: Image.asset(
                            ImageConstant.noData,
                          ),
                        )
                      :
              ListView.separated(
            controller: _scrollController,
            separatorBuilder: (
              context,
              index,
            ) {
              return const SizedBox(
                height: 3,
              );
            },
            itemCount: homeProvider.journalsModelList.length +
                (homeProvider.journalsModelLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < homeProvider.journalsModelList.length) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => JournalViewScreen(
                          journalId: homeProvider
                              .journalsModelList[index].journalId
                              .toString(),
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: UserProfileList1ItemWidget(
                    journalsModelList: homeProvider.journalsModelList[index],
                    index: index,
                  ),
                );
              } else if (homeProvider.journalsModelList.length == index) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (homeProvider.journalsModelLoading) {
                return Center(
                  child: shimmerList(
                    width: double.infinity,
                    height: size.height,
                    list: 10,
                    shimmerHeight: size.height * 0.07,
                  ),
                );
              } else if (homeProvider.journalsModelList.isEmpty) {
                return Center(
                  child: Image.asset(
                    ImageConstant.noData,
                  ),
                );
              } else {
                return Center(
                  child: Image.asset(
                    ImageConstant.noData,
                  ),
                );
              }
            },
          ),
        ),
      );
    });
  }
}
