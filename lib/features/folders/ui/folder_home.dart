import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note/core/widget/Custom_Text.dart';
import 'package:note/features/contro/logic/cubit/control_cubit.dart';
import 'package:note/features/contro/ui/controlpage.dart';
import 'package:note/features/folders/logic/folder_cubit/folders_cubit.dart';
import 'package:note/features/folders/widget/searchdelegate.dart';
import 'package:note/features/home/home_screen.dart';
import 'package:note/features/home/logic/homecubit/home_cubit.dart';

class FolderHome extends StatefulWidget {
  FolderHome({super.key});
  @override
  State<FolderHome> createState() => _FolderHomeState();
}

class _FolderHomeState extends State<FolderHome> {
  Color Col0 = Colors.black;
  @override
  void initState() {
    BlocProvider.of<FoldersCubit>(context).Folders.clear();
    BlocProvider.of<FoldersCubit>(context).Foldercolor.clear();
    BlocProvider.of<FoldersCubit>(context).Folderid.clear();
    BlocProvider.of<FoldersCubit>(context).getallfolder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoldersCubit, FoldersState>(
      listener: (context1, state) {},
      builder: (context1, state) {
        return SafeArea(
          child: Scaffold(
            floatingActionButton: SizedBox(
              width: 60.w,
              height: 50.h,
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Custom_Text(
                          text: "New Folder",
                          fontsize: 20,
                          fontcolor: const Color(0xff4C0E03),
                          fontWeight: FontWeight.w600,
                        ),
                        content: SizedBox(
                          //  height: 200.h,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "PTSerif"),
                                  maxLength: 20,
                                  controller:
                                      context1.read<FoldersCubit>().foldername,
                                  decoration: InputDecoration(
                                    hintText: "Enter Name",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Custom_Text(
                                  text: "Folder Color",
                                  fontsize: 20,
                                  fontcolor: const Color(0xff4C0E03),
                                  fontWeight: FontWeight.w900,
                                ),
                                Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ColorPicker(
                                        pickerColor: Col0,
                                        enableAlpha: false,
                                        labelTypes: const [],
                                        //showLabel: false,
                                        onColorChanged: (value) =>
                                            Col0 = value))
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              context1
                                  .read<FoldersCubit>()
                                  .addfolder(col: Col0.value);
                              context1.read<FoldersCubit>().Folders.clear();
                              context1.read<FoldersCubit>().Foldercolor.clear();
                              context1.read<FoldersCubit>().Folderid.clear();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => ControlCubit(),
                                      child: controlscreen(),
                                    ),
                                  ),
                                  (route) => false);
                            },
                            color: Colors.black,
                            child: Custom_Text(
                              text: "Add",
                              fontsize: 20,
                              fontcolor: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
                backgroundColor: const Color(0xffF4EAC7),
                child: Icon(
                  FontAwesomeIcons.folderPlus,
                  size: 35.h,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 10.w,
                top: 40.h,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.h),
                          decoration: BoxDecoration(
                              color: const Color(0xffF4EAC7),
                              borderRadius: BorderRadius.circular(20.h)),
                          child: Custom_Text(
                            text: " Super Notes",
                            fontsize: 30,
                            fontcolor: const Color(0xff4C0E03),
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        // Search
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 203, 200, 200),
                              borderRadius: BorderRadius.circular(16.h)),
                          child: IconButton(
                              onPressed: () async {
                                await context1.read<FoldersCubit>().readtdata();
                                showSearch(
                                    context: context,
                                    delegate: searchnotes(
                                      allnotes: context1
                                          .read<FoldersCubit>()
                                          .allnotes,
                                      allfolders: context1
                                          .read<FoldersCubit>()
                                          .allFolders,
                                    ));
                              },
                              icon:
                                  const Icon(FontAwesomeIcons.magnifyingGlass)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(3.h),
                      decoration: BoxDecoration(
                          color: const Color(0xff232323),
                          borderRadius: BorderRadius.circular(20.h)),
                      child: Custom_Text(
                        text: "Folders",
                        fontsize: 28,
                        fontcolor: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: context1.read<FoldersCubit>().Folders.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20.h,
                            crossAxisSpacing: 10.h,
                            childAspectRatio: 1.3.h),
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider(
                                                  create: (context) =>
                                                      HomeCubit(),
                                                  child: HomeScreen(
                                                    foldername: context1
                                                        .read<FoldersCubit>()
                                                        .Folders[index],
                                                    folderid: context1
                                                        .read<FoldersCubit>()
                                                        .Folderid[index],
                                                    apparcolor: context1
                                                        .read<FoldersCubit>()
                                                        .Foldercolor[index],
                                                  ),
                                                ),
                                              ));
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.solidFolderClosed,
                                          size: 70.h,
                                          color: Color(context1
                                              .read<FoldersCubit>()
                                              .Foldercolor[index]),
                                        ),
                                      ),

                                      /// pop up menu
                                      PopupMenuButton(
                                        onOpened: () {
                                          context1
                                                  .read<FoldersCubit>()
                                                  .editfoldername
                                                  .text =
                                              context1
                                                  .read<FoldersCubit>()
                                                  .Folders[index];
                                          Col0 = Color(context1
                                              .read<FoldersCubit>()
                                              .Foldercolor[index]);
                                        },
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              value: "one",
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      title: Custom_Text(
                                                        text: "Edit Folder",
                                                        fontsize: 20,
                                                        fontcolor: const Color(
                                                            0xff4C0E03),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      content: SizedBox(
                                                        //  height: 200.h,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              TextField(
                                                                controller: context1
                                                                    .read<
                                                                        FoldersCubit>()
                                                                    .editfoldername,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      "Enter Name",
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15)),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              Custom_Text(
                                                                text:
                                                                    "Folder Color",
                                                                fontsize: 20,
                                                                fontcolor:
                                                                    const Color(
                                                                        0xff4C0E03),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                              ),
                                                              Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5),
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .black),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: ColorPicker(
                                                                      pickerColor: Col0,
                                                                      enableAlpha: false,

                                                                      //showLabel: false,
                                                                      onColorChanged: (value) => Col0 = value))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      actions: [
                                                        MaterialButton(
                                                          onPressed: () {
                                                            context1
                                                                .read<
                                                                    FoldersCubit>()
                                                                .editfolder(
                                                                    context1
                                                                        .read<
                                                                            FoldersCubit>()
                                                                        .Folderid[index],
                                                                    Col0.value,
                                                                    index);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          color: Colors.black,
                                                          child: Custom_Text(
                                                            text: "Save",
                                                            fontsize: 20,
                                                            fontcolor:
                                                                Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: const Text("Edit"),
                                            ),
                                            PopupMenuItem(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Center(
                                                        child: Custom_Text(
                                                          text: "Delete Folder",
                                                          fontsize: 18,
                                                          fontcolor:
                                                              Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      content: Custom_Text(
                                                        text:
                                                            "Are U Sure To delete this Folder ?",
                                                        fontsize: 15,
                                                        fontcolor: const Color
                                                            .fromARGB(
                                                            255, 93, 93, 93),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      actions: [
                                                        Row(
                                                          children: [
                                                            MaterialButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(7),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: const Color(
                                                                        0xffD6D6D6)),
                                                                child:
                                                                    Custom_Text(
                                                                  text:
                                                                      "No,Keep it",
                                                                  fontsize: 15,
                                                                  fontcolor:
                                                                      Colors
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                            MaterialButton(
                                                              onPressed: () {
                                                                context1
                                                                    .read<
                                                                        FoldersCubit>()
                                                                    .deletefolder(
                                                                        context1
                                                                            .read<FoldersCubit>()
                                                                            .Folderid[index],
                                                                        index);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(7),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: const Color(
                                                                        0xff4B5EFC)),
                                                                child:
                                                                    Custom_Text(
                                                                  text:
                                                                      "Yes,Delete",
                                                                  fontsize: 15,
                                                                  fontcolor:
                                                                      Colors
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
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
                                              child: const Text("Delete"),
                                            )
                                          ];
                                        },
                                        child: Icon(
                                            FontAwesomeIcons.ellipsisVertical,
                                            size: 17.h,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Container(
                                    child: Custom_Text(
                                      //  maxlines: 1,
                                      text: context1
                                          .read<FoldersCubit>()
                                          .Folders[index],
                                      fontsize: 17,
                                      fontcolor:
                                          const Color.fromARGB(255, 41, 6, 0),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
