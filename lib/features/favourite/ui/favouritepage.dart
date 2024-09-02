import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note/core/widget/Custom_Text.dart';
import 'package:note/features/edit_note/logic/editcubit/edit_note_cubit.dart';
import 'package:note/features/edit_note/ui/editNote_screen.dart';
import 'package:note/features/home/logic/homecubit/home_cubit.dart';

class Favourtiepage extends StatefulWidget {
  const Favourtiepage({super.key});

  @override
  State<Favourtiepage> createState() => _FavourtiepageState();
}

class _FavourtiepageState extends State<Favourtiepage> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).readfavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(top: 40.h, left: 10.w, right: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 149, 140, 107),
                        borderRadius: BorderRadius.circular(20.h)),
                    child: Custom_Text(
                      text: "Favourite Notes ",
                      fontsize: 30,
                      fontcolor: const Color.fromARGB(255, 90, 15, 2),
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Expanded(
                    child: MasonryGridView.builder(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      itemCount: context.read<HomeCubit>().favdata.length,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              List data2 = context.read<HomeCubit>().favdata;
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
                                      folderid: data2[index]['nfolderid'],
                                      pagenum: 0,
                                    ),
                                  ),
                                ),
                              ).then((_) {
                                BlocProvider.of<HomeCubit>(context)
                                    .favdata
                                    .clear();
                                BlocProvider.of<HomeCubit>(context)
                                    .readfavourites();
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
                                                  .favdata[index]['title']),
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
                                                    fontcolor:
                                                        const Color.fromARGB(
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
                                                                const EdgeInsets
                                                                    .all(7),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: const Color(
                                                                    0xffD6D6D6)),
                                                            child: Custom_Text(
                                                              text: "No,Keep it",
                                                              fontsize: 15,
                                                              fontcolor:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                        MaterialButton(
                                                          onPressed: () {
                                                            context
                                                                .read<HomeCubit>()
                                                                .deltefavnote(
                                                                  context
                                                                          .read<
                                                                              HomeCubit>()
                                                                          .favdata[
                                                                      index]['noteid'],
                                                                );
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(7),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: const Color(
                                                                    0xff4B5EFC)),
                                                            child: Custom_Text(
                                                              text: "Yes,Delete",
                                                              fontsize: 15,
                                                              fontcolor:
                                                                  Colors.white,
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
                                            color: const Color.fromARGB(
                                                255, 137, 9, 0),
                                          ),
                                        )
                                      ],
                                    ),
                                    Custom_Text(
                                      text: context
                                          .read<HomeCubit>()
                                          .favdata[index]['text'],
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
                                              .favdata[index]['favourite'])
                                          ? Colors.red
                                          : const Color.fromARGB(
                                              255, 109, 108, 108),
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
