import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note/core/widget/Custom_Text.dart';
import 'package:note/features/edit_note/logic/editcubit/edit_note_cubit.dart';
import 'package:note/features/edit_note/ui/editNote_screen.dart';
import 'package:note/features/home/home_screen.dart';
import 'package:note/features/home/logic/homecubit/home_cubit.dart';

class searchnotes extends SearchDelegate {
  final List allnotes;
  final List allfolders;

  searchnotes({required this.allnotes, required this.allfolders});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(
            Icons.close,
            size: 35,
            color: Colors.black,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
          // Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 35,
          color: Colors.black,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("ds");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List filterfolder = allfolders
        .where(
          (element1) => (element1['foldername'])!
              .toLowerCase()
              .contains(query.toLowerCase()),
        )
        .toList();
    List filternotes = allnotes
        .where(
          (element1) =>
              (element1['title'])!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Custom_Text(
                text: "Folders",
                fontsize: 30,
                fontcolor: const Color(0xff4C0E03),
                fontWeight: FontWeight.w600,
              ),
              //  height: 200,
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    query == "" ? allfolders.length : filterfolder.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => HomeCubit(),
                                  child: HomeScreen(
                                      foldername: query == ""
                                          ? allfolders[index]['foldername']
                                          : filterfolder[index]['foldername'],
                                      folderid: query == ""
                                          ? allfolders[index]['folderid']
                                          : filterfolder[index]['folderid'],
                                      apparcolor: query == ""
                                          ? allfolders[index]['foldercolor']
                                          : filterfolder[index]['foldercolor']),
                                ),
                              ));
                        },
                        icon: Icon(FontAwesomeIcons.solidFolderClosed,
                            size: 30.h,
                            color: query == ""
                                ? Color(allfolders[index]['foldercolor'])
                                : Color(filterfolder[index]['foldercolor'])),
                      ),
                      Custom_Text(
                        maxlines: 1,
                        text: query == ""
                            ? allfolders[index]['foldername']
                            : filterfolder[index]['foldername'],
                        fontsize: 13,
                        fontcolor: const Color.fromARGB(255, 41, 6, 0),
                        fontWeight: FontWeight.w600,
                      ),
                    ]),
                  );
                },
              ),
              Custom_Text(
                text: "Notes",
                fontsize: 30,
                fontcolor: const Color(0xff4C0E03),
                fontWeight: FontWeight.w600,
              ),

              MasonryGridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                itemCount: query == "" ? allnotes.length : filternotes.length,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => EditNoteCubit(),
                            child: EditNote(
                              fave: query == ""
                                  ? bool.parse(allnotes[index]['favourite'])
                                  : bool.parse(filternotes[index]['favourite']),
                              // : filternotes[index]['favourite'],
                              noteid: query == ""
                                  ? allnotes[index]['noteid']
                                  : filternotes[index]['noteid'],
                              title: query == ""
                                  ? allnotes[index]['title']
                                  : filternotes[index]['title'],
                              textnote: query == ""
                                  ? allnotes[index]['text']
                                  : filternotes[index]['text'],
                              folderid: query == ""
                                  ? allnotes[index]['nfolderid']
                                  : filternotes[index]['nfolderid'],
                              pagenum: 1,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Custom_Text(
                              text: query == ""
                                  ? allnotes[index]['title']
                                  : filternotes[index]['title'],
                              fontsize: 18,
                              fontcolor: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            Custom_Text(
                              text: query == ""
                                  ? allnotes[index]['text']
                                  : filternotes[index]['text'],
                              fontsize: 17,
                              fontcolor: const Color.fromARGB(255, 88, 80, 80),
                              fontWeight: FontWeight.w400,
                              maxlines: 4,
                            ),
                            Icon(Icons.favorite,
                                size: 20,
                                color: query == ""
                                    ? bool.parse(allnotes[index]['favourite'])
                                        ? Colors.red
                                        : const Color.fromARGB(
                                            255, 109, 108, 108)
                                    : bool.parse(
                                        filternotes[index]['favourite'],
                                      )
                                        ? Colors.red
                                        : const Color.fromARGB(
                                            255, 109, 108, 108))
                          ]),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
