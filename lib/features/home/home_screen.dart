import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note/core/widget/Custom_Text.dart';
import 'package:note/features/add_note/logic/addcubit/add_note_cubit.dart';
import 'package:note/features/edit_note/logic/editcubit/edit_note_cubit.dart';
import 'package:note/features/edit_note/ui/editNote_screen.dart';
import 'package:note/features/home/logic/homecubit/home_cubit.dart';

import '../add_note/AddNote.dart';

class HomeScreen extends StatefulWidget {
  final String foldername;
  final int folderid;
  final int apparcolor;
  const HomeScreen(
      {super.key,
      required this.folderid,
      required this.foldername,
      required this.apparcolor});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).readNotes(folderid: widget.folderid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // final NoID = await addNote();
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => AddNoteCubit1(),
                  child: //TabBar1(),
                      AddNoteScreen00(
                    folderid: widget.folderid,
                  ),
                ),
              ),
            )
                .then((_) {
              BlocProvider.of<HomeCubit>(context).newdata.clear();
              BlocProvider.of<HomeCubit>(context)
                  .readNotes(folderid: widget.folderid);
            });
          },
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 35.h,
          )),
      appBar: AppBar(
          leading: Container(
              margin: const EdgeInsets.only(left: 10, top: 3, bottom: 3),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    FontAwesomeIcons.angleLeft,
                    size: 30.h,
                  ))),
          title: Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Custom_Text(
              text: (widget.foldername),
              fontsize: 25,
              fontcolor: const Color(0xff4C0E03),
              fontWeight: FontWeight.w900,
            ),
          ),
          backgroundColor: Color(widget.apparcolor)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is Homereadsucess) {
              state.readalldata;
            }
          },
          builder: (context, state) {
            return Column(children: [
              Expanded(
                  child: MasonryGridView.builder(
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                itemCount: context.read<HomeCubit>().newdata.length,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                        onTap: () async {
                          List data2 = context.read<HomeCubit>().newdata;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => EditNoteCubit(),
                                child: EditNote(
                                  fave: bool.parse(
                                    data2[index]['favourite'],
                                  ),
                                  noteid: data2[index]['noteid'],
                                  title: data2[index]['title'],
                                  textnote: data2[index]['text'],
                                  folderid: widget.folderid,
                                  pagenum: 0,
                                ),
                              ),
                            ),
                          ).then((_) {
                            BlocProvider.of<HomeCubit>(context).newdata.clear();
                            BlocProvider.of<HomeCubit>(context)
                                .readNotes(folderid: widget.folderid);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Custom_Text(
                                        text: (context
                                            .read<HomeCubit>()
                                            .newdata[index]['title']),
                                        fontsize: 12,
                                        fontcolor: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        maxlines: 1),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: Center(
                                              child: Custom_Text(
                                                text: "Delete Note ",
                                                fontsize: 20,
                                                fontcolor:
                                                    const Color(0xff4C0E03),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            content: Custom_Text(
                                              text:
                                                  "Are U Sure To delete this Note ?",
                                              fontsize: 15,
                                              fontcolor: const Color.fromARGB(
                                                  255, 93, 93, 93),
                                              fontWeight: FontWeight.w500,
                                            ),
                                            actions: [
                                              Row(
                                                children: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              7),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: const Color(
                                                              0xffD6D6D6)),
                                                      child: Custom_Text(
                                                        text: "No,Keep it",
                                                        fontsize: 15,
                                                        fontcolor: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                    onPressed: () {
                                                      context
                                                          .read<HomeCubit>()
                                                          .deltenote(
                                                            context
                                                                    .read<
                                                                        HomeCubit>()
                                                                    .newdata[
                                                                index]['noteid'],
                                                          );
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              7),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: const Color(
                                                              0xff4B5EFC)),
                                                      child: Custom_Text(
                                                        text: "Yes,Delete",
                                                        fontsize: 15,
                                                        fontcolor: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.deleteLeft,
                                      size: 24.h,
                                      color:
                                          const Color.fromARGB(255, 137, 9, 0),
                                    ),
                                  )
                                ],
                              ),
                              Custom_Text(
                                text: context.read<HomeCubit>().newdata[index]
                                    ['text'],
                                fontsize: 17,
                                fontcolor:
                                    const Color.fromARGB(255, 88, 80, 80),
                                fontWeight: FontWeight.w400,
                                maxlines: 4,
                              ),
                              Icon(
                                Icons.favorite,
                                size: 20,
                                color: bool.parse(context
                                        .read<HomeCubit>()
                                        .newdata[index]['favourite'])
                                    ? Colors.red
                                    : const Color.fromARGB(255, 109, 108, 108),
                              )
                            ],
                          ),
                        )),
                  );
                },
              )),
            ]);
          },
        ),
      ),
    );
  }
}
