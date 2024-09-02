import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:note/core/widget/Custom_Text.dart';
import 'package:note/features/add_note/logic/addcubit/add_note_cubit.dart';

class Zrecord extends StatefulWidget {
  @override
  State<Zrecord> createState() => _ZrecordState();
}

class _ZrecordState extends State<Zrecord> {
  @override
  void initState() {
    context.read<AddNoteCubit1>().initrecorder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
      child: BlocConsumer<AddNoteCubit1, AddNoteState>(
        listener: (context, state) {
          if (state is RecordingInProgress) {
            state.duration;
          }
          if (state is recordsucess) {
            state.recordpath;
            state.playbackStates;
            state.audoplayers;
            state.audiodurations;
            state.audiotimes;
            state.timeprogrss;
            // context.read<AddNoteCubit1>().dr = 0;
          }
          if (state is audiodurationstate) {
            state.audioduration0;
          }
          if (state is timeprogrssstate) {
            state.timeprogrss0;
          }
          if (state is completestate) {
            state.player;
          } else if (state is player1) {
            state.player;
          }
          if (state is player2) {
            state.player;
          }
          if (state is player3) {
            state.player;
          }
          if (state is player4) {
            state.player;
          }
          if (state is recordpaused) {
            state.playstate;
          }
          if (state is recordresume) {
            state.playstate;
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: context.read<AddNoteCubit1>().recordpath.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Center(
                                child: Custom_Text(
                                  maxlines: 2,
                                  text: "Delete record ",
                                  fontsize: 20,
                                  fontcolor: const Color(0xff4C0E03),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              content: Custom_Text(
                                text: "Are U Sure To delete this Record ?",
                                fontsize: 13,
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
                                            .deleterecord(index);
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
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Custom_Text(
                                        text: context
                                            .read<AddNoteCubit1>()
                                            .recordnames[index],
                                        fontsize: 13,
                                        fontcolor: const Color(0xff4C0E03),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      Custom_Text(
                                        text: context
                                            .read<AddNoteCubit1>()
                                            .recorddate[index],
                                        fontsize: 14,
                                        fontcolor: const Color.fromARGB(
                                            255, 162, 161, 161),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      context
                                          .read<AddNoteCubit1>()
                                          .longplay(index);
                                    },
                                    icon: Icon(
                                      context
                                                  .read<AddNoteCubit1>()
                                                  .playbackStates[index] ==
                                              PlayerState.playing
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow,
                                      size: 50.h,
                                    ),
                                    color: const Color(0xff4C0E03),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Custom_Text(
                                  text: gettimestring(context
                                      .read<AddNoteCubit1>()
                                      .timeprogrss[index]),
                                  fontsize: 13,
                                  fontcolor: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                                const SizedBox(
                                  width: 1,
                                ),
                                Container(
                                  width: 250,
                                  child: Slider.adaptive(
                                    value: (context
                                                .read<AddNoteCubit1>()
                                                .timeprogrss[index] /
                                            1000)
                                        .floorToDouble(),
                                    min: 0,
                                    max: (context
                                                .read<AddNoteCubit1>()
                                                .audiodurations[index] /
                                            1000)
                                        .floorToDouble(),
                                    onChanged: (value) {
                                      context
                                          .read<AddNoteCubit1>()
                                          .seekto(value.toInt(), index);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 1,
                                ),
                                Custom_Text(
                                  text: gettimestring(context
                                      .read<AddNoteCubit1>()
                                      .audiotimes[index]),
                                  fontsize: 13,
                                  fontcolor: Colors.black,
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  Container(
                    height: 80.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                        color: const Color(0xff2E9A6D),
                        borderRadius: BorderRadius.circular(40.h)),
                    child: IconButton(
                      onPressed: () {
                        context.read<AddNoteCubit1>().recorder.isRecording
                            ? showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Custom_Text(
                                      text: "Name Of Record",
                                      fontsize: 20,
                                      fontcolor: Color(0xff4C0E03),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    content: Form(
                                      key: BlocProvider.of<AddNoteCubit1>(
                                              context)
                                          .recordnamekey,
                                      child: TextFormField(
                                        maxLength: 40,
                                        controller:
                                            BlocProvider.of<AddNoteCubit1>(
                                                    context)
                                                .recordnamecontroller,
                                        validator: (value) {
                                          if (value == "" || value == null) {
                                            return "Write record Name";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Save Record",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () {
                                          if (BlocProvider.of<AddNoteCubit1>(
                                                  context)
                                              .recordnamekey
                                              .currentState!
                                              .validate()) {
                                            BlocProvider.of<AddNoteCubit1>(
                                                    context)
                                                .stopRecording();
                                            BlocProvider.of<AddNoteCubit1>(
                                                    context)
                                                .recordnames
                                                .add(BlocProvider.of<
                                                        AddNoteCubit1>(context)
                                                    .recordnamecontroller
                                                    .text);
                                            BlocProvider.of<AddNoteCubit1>(
                                                    context)
                                                .recorddate
                                                .add(DateFormat('d:MM:yyyy')
                                                    .format(DateTime.now()));
                                            //  .add(DateTime.now().toString());
                                            Navigator.of(context).pop();
                                            BlocProvider.of<AddNoteCubit1>(
                                                    context)
                                                .recordnamecontroller
                                                .clear();
                                          }
                                        },
                                        color: Colors.green,
                                        child: const Text("Save"),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          BlocProvider.of<AddNoteCubit1>(
                                                  context)
                                              .stopwithoutsave();
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("No"),
                                      )
                                    ],
                                  );
                                },
                              )
                            : context.read<AddNoteCubit1>().startRecording();
                      },
                      icon: Icon(
                        context.read<AddNoteCubit1>().recorder.isRecording
                            ? FontAwesomeIcons.stop
                            : FontAwesomeIcons.microphone,
                        color: Colors.white,
                        size: 60.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 200, 184, 164),
                        borderRadius: BorderRadius.circular(10.h)),
                    child: Custom_Text(
                      text: gettimestring(context.read<AddNoteCubit1>().dr),
                      fontsize: 25,
                      fontcolor: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  String gettimestring(int milliseconds) {
    String minutes =
        '${(milliseconds / 60000).floor() < 10 ? 0 : ''} ${(milliseconds / 60000).floor()}';
    String seconds =
        "${(milliseconds / 1000).floor() % 60 < 10 ? 0 : ''} ${(milliseconds / 1000).floor() % 60} ";
    return '$minutes:$seconds';
  }
}
