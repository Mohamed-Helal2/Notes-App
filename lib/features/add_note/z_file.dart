import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/core/widget/Custom_Text.dart';
import 'package:note/features/add_note/logic/addcubit/add_note_cubit.dart';
import 'package:note/features/add_note/pdfviewer.dart';

class zfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddNoteCubit1, AddNoteState>(
      listener: (context, state) {
        if (state is FileSucess) {
          state.alfiles;
          state.allnamed;
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            ListView.builder(
              itemCount: context.read<AddNoteCubit1>().pdfpath.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => pdfviewer(
                            path: context.read<AddNoteCubit1>().pdfpath[index],pdftitle: context.read<AddNoteCubit1>().pdfnames[index],),
                      ));
                    },
                    child: ListTile(
                      leading: const Icon(Icons.picture_as_pdf),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Center(
                                  child: Custom_Text(
                                      text: "Delete Pdf ",
                                      fontsize: 20,
                                      fontcolor: const Color(0xff4C0E03),
                                      fontWeight: FontWeight.w600,
                                      ),
                                ),
                                content: Custom_Text(
                                    text: "Are U Sure To delete this Pdf ?",
                                    fontsize: 15,
                                    fontcolor:
                                        const Color.fromARGB(255, 93, 93, 93),
                                    fontWeight: FontWeight.w500,
                                  ),
                                actions: [
                                  Row(
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xffD6D6D6)),
                                          child: Custom_Text(
                                              text: "No,Keep it",
                                              fontsize: 15,
                                              fontcolor: Colors.black,
                                              fontWeight: FontWeight.w600,
                                               ),
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          context
                                              .read<AddNoteCubit1>()
                                              .deletepdf(index);
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xff4B5EFC)),
                                          child: Custom_Text(
                                              text: "Yes,Delete",
                                              fontsize: 15,
                                              fontcolor: Colors.white,
                                              fontWeight: FontWeight.w600,
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
                        icon: const Icon(Icons.delete),
                      ),
                      title: Custom_Text(
                          text: context.read<AddNoteCubit1>().pdfnames[index],
                          fontsize: 15,
                          fontcolor: Colors.black,
                          fontWeight: FontWeight.w700,
                         ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              bottom: 10.h,
              right: 10.h,
              child: MaterialButton(
                onPressed: () async {
                  context.read<AddNoteCubit1>().pickFile1();
                },
                color: const Color(0xff232323),
                child: Custom_Text(
                    text: "Add Pdf ",
                    fontsize: 25,
                    fontcolor: Colors.white,
                    fontWeight: FontWeight.w800,
                   ),
              ),
            ),
          ],
        );
      },
    );
  }
}
