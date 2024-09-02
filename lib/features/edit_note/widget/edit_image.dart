import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note/core/widget/Custom_Text.dart';
import 'package:note/core/widget/photoview.dart';
import 'package:note/features/edit_note/logic/editcubit/edit_note_cubit.dart';

class EditImage extends StatelessWidget {
  final int noteid;
  final int folderid;
  const EditImage({super.key, required this.noteid, required this.folderid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 10.h, right: 10.h, left: 10.h, bottom: 10.h),
      child: BlocConsumer<EditNoteCubit, EditNoteState>(
        listener: (context, state) {
          // if (state is  imagesucess) {
          //   state.allimages;
          // }
        },
        builder: (context, state) {
          return Stack(
            children: [
              GridView.builder(
                itemCount: context.read<EditNoteCubit>().allimage.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => PhotoPge(
                            ImagePath:
                                context.read<EditNoteCubit>().allimage[index]),
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(8.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: FileImage(File(
                              context.read<EditNoteCubit>().allimage[index])),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 30.h,
                          width: 30.w,
                          //   margin: const EdgeInsets.only(right: 5, bottom: 3),

                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 158, 158, 158),
                            borderRadius: BorderRadius.circular(5.h),
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: Center(
                                        child: Custom_Text(
                                            text: "Delete Photo ",
                                            fontsize: 20,
                                            fontcolor: const Color(0xff4C0E03),
                                            fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      content: Custom_Text(
                                          text:
                                              "Are U Sure To delete this Photo ?",
                                          fontsize: 13,
                                          fontcolor: const Color.fromARGB(
                                              255, 93, 93, 93),
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
                                                padding:
                                                    const EdgeInsets.all(7),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: const Color(
                                                        0xffD6D6D6)),
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
                                                    .read<EditNoteCubit>()
                                                    .deleteimage(index);
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(7),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: const Color(
                                                        0xff4B5EFC)),
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
                              icon: Icon(
                                FontAwesomeIcons.xmark,
                                size: 25.h,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 11.h,
                left: MediaQuery.of(context).size.width * 0.19,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<EditNoteCubit>()
                            .AddImage(ImageSource.camera, noteid, folderid);
                      },
                      child: Custom_Text(
                          text: "Camera",
                          fontsize: 14,
                          fontcolor: Colors.black,
                          fontWeight: FontWeight.w800,
                         ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context
                              .read<EditNoteCubit>()
                              .getmultiimage(noteid, folderid);
                        },
                        child: Custom_Text(
                            text: "Gallery",
                            fontsize: 14,
                            fontcolor: Colors.black,
                            fontWeight: FontWeight.w800,
                            )),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
