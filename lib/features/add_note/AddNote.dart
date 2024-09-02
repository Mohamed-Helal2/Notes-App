import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note/core/widget/Custom_Text.dart';
import 'package:note/features/add_note/logic/addcubit/add_note_cubit.dart';
import 'package:note/features/add_note/widget/0-note.dart';
import 'package:note/features/add_note/z_image.dart';
import 'package:note/features/add_note/z_record.dart';

import 'z_file.dart';

class AddNoteScreen00 extends StatelessWidget {
  final int folderid;

  const AddNoteScreen00({
    super.key,
    required this.folderid,
  });
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: BlocConsumer<AddNoteCubit1, AddNoteState>(
          listener: (context, state) {
            if (state is favouritestate) {
              if (state.fevo == true) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(seconds: 1),
                    content: Row(
                      children: [
                        Custom_Text(
                            text: "Added to Favourtie",
                            fontsize: 16,
                            fontcolor: Colors.white,
                            fontWeight: FontWeight.w500),
                        SizedBox(
                          width: 10.w,
                        ),
                        const Icon(
                          Icons.favorite,
                          size: 30,
                          color: Colors.red,
                        )
                      ],
                    )));
              } else if (state.fevo == false) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(seconds: 1),
                    content: Custom_Text(
                        text: "remove from Favourtie",
                        fontsize: 16,
                        fontcolor: Colors.white,
                        fontWeight: FontWeight.w500)));
              }
            }
            if (state is Textnotesucess) {
              Navigator.of(context).pop();
            } else if (state is Textnotefailure) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Center(
                    child: Custom_Text(
                      text: " Add Title ",
                      fontsize: 20,
                      fontcolor: const Color(0xff4C0E03),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.blue,
                      child: Custom_Text(
                        text: "Ok",
                        fontsize: 20,
                        fontcolor: const Color(0xff4C0E03),
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              // const Color(0XFFF1E6E0),
              appBar: AppBar(
                leading: Container(
                    margin: const EdgeInsets.only(left: 10, top: 4, bottom: 3),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            FontAwesomeIcons.angleLeft,
                            size: 35.h,
                            color: Colors.black,
                          )),
                    )),
                title: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Custom_Text(
                    text: ("Add Notes"),
                    fontsize: 25,
                    fontcolor: const Color(0xff4C0E03),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                //backgroundColor: Color(this.appbarcolor),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<AddNoteCubit1>().changefavourite();
                    },
                    icon: Icon(
                      Icons.favorite,
                      size: 30,
                      color: context.read<AddNoteCubit1>().fav
                          ? Colors.red
                          : const Color.fromARGB(255, 109, 108, 108),
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 90.w,
                    margin: EdgeInsets.only(right: 20.h),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 29, 46, 36),
                      borderRadius: BorderRadius.circular(13.h),
                    ),
                    child: Center(
                      child: InkWell(
                          onTap: () async {
                            context
                                .read<AddNoteCubit1>()
                                .addNote(folderid: folderid);
                          },
                          child: Custom_Text(
                            text: "Save",
                            fontsize: 20,
                            fontcolor: Colors.white,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(90.h),
                  child: TabBar(
                    indicatorWeight: 4,
                    dividerColor: const Color(0xff141D22),
                    //splashBorderRadius: BorderRadius.circular(20),
                    // dividerHeight: 1,
                    tabs: [
                      Container(
                        width: 60.w,
                        margin: EdgeInsets.only(bottom: 5.h),
                        decoration: BoxDecoration(
                            color: const Color(0xff668A74),
                            borderRadius: BorderRadius.circular(15)),
                        child: Tab(
                            icon: const Icon(
                              FontAwesomeIcons.pencil,
                            ),
                            child: Custom_Text(
                              text: "Note",
                              fontsize: 15,
                              fontcolor: Colors.white,
                              fontWeight: FontWeight.w800,
                            )),
                      ),
                      Container(
                        width: 60.w,
                        margin: EdgeInsets.only(bottom: 5.h),
                        decoration: BoxDecoration(
                            color: const Color(0xff668A74),
                            borderRadius: BorderRadius.circular(15)),
                        child: Tab(
                            icon: const Icon(
                              FontAwesomeIcons.image,
                            ),
                            child: Custom_Text(
                              text: "Images",
                              fontsize: 15,
                              fontcolor: Colors.white,
                              fontWeight: FontWeight.w800,
                            )),
                      ),
                      Container(
                        width: 60.w,
                        margin: EdgeInsets.only(bottom: 5.h),
                        decoration: BoxDecoration(
                            color: const Color(0xff668A74),
                            borderRadius: BorderRadius.circular(15)),
                        child: Tab(
                            icon: const Icon(
                              FontAwesomeIcons.microphone,
                              color: Color.fromARGB(255, 113, 29, 23),
                            ),
                            child: Custom_Text(
                              text: "Record",
                              fontsize: 15,
                              fontcolor: Colors.white,
                              fontWeight: FontWeight.w800,
                            )),
                      ),
                      Container(
                        width: 60.w,
                        margin: EdgeInsets.only(bottom: 5.h),
                        decoration: BoxDecoration(
                            color: const Color(0xff668A74),
                            borderRadius: BorderRadius.circular(15)),
                        child: Tab(
                            icon: const Icon(
                              FontAwesomeIcons.solidFilePdf,
                              color: Color.fromARGB(109, 231, 0, 19),
                            ),
                            child: Custom_Text(
                              text: "Pdf",
                              fontsize: 15,
                              fontcolor: Colors.white,
                              fontWeight: FontWeight.w800,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  NoteWidge(
                    titleController:
                        context.read<AddNoteCubit1>().titleController,
                    noteController:
                        context.read<AddNoteCubit1>().noteController,
                  ),
                  Zimage(),
                  Zrecord(),
                  zfile()
                ],
              ),
            );
          },
        )

        // BlocListener<AddNoteCubit1, AddNoteState>(
        //   listener: (context, state) {

        //   },
        //   child:

        // )

        );
  }
}
