import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef void BoolCallback(bool val);
typedef void BoolCallbackVideo(bool val);

class CallUI extends StatelessWidget {
  final BoolCallback audiocallback;
  final BoolCallbackVideo boolCallbackVideo;
  final VoidCallback joinMeeting;

  CallUI(
      {required this.audiocallback,
      required this.boolCallbackVideo,
      required this.joinMeeting});

  bool isAudioMuted = false;
  bool isVideoMuted = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            const Spacer(flex: 59),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: const Icon(Icons.arrow_back_ios_outlined),
                      //Import any icon, which you want
                      color: Colors.black.withOpacity(0.3),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
              margin: const EdgeInsets.fromLTRB(32, 0, 32, 0),
            ),
            const Spacer(flex: 1),
            // SvgPicture.string(
            //   SVGAssets.meetImage,
            //   width: MediaQuery.of(context).size.width,
            //   fit: BoxFit.fitWidth,
            // ),
            const Spacer(flex: 65),
            Container(
              child: const Text(
                "Join the Meet",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              margin: const EdgeInsets.fromLTRB(32, 0, 32, 0),
            ),
            const Spacer(flex: 65),
            Container(
              width: 350,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xfff3f3f3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                maxLines: 1,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    suffixIcon: const Icon(Icons.person, color: Colors.black),
                    hintText: "Name"),
              ),
            ),
            const Spacer(flex: 58),
            Container(
              width: 350,
              child: const Text(
                "Meet Guidelines -\n1) For privacy reasons you may change your name if you want.\n2) By default your audio & video are muted.",
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff898989),
                ),
              ),
            ),
            const Spacer(flex: 58),
            Row(
              children: [
                const Spacer(flex: 32),
                GestureDetector(
                  onTap: () {
                    audiocallback(!isAudioMuted);
                    // _onAudioMutedChanged(!isAudioMuted);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        color: isAudioMuted
                            ? const Color(0xffD64467)
                            : const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.06),
                              offset: const Offset(0, 4)),
                        ]),
                    width: 72,
                    height: 72,
                    child: Icon(
                      isAudioMuted ? Icons.mic_off_sharp : Icons.mic_none_sharp,
                      color: isAudioMuted ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const Spacer(flex: 16),
                GestureDetector(
                  onTap: () {
                    boolCallbackVideo(!isVideoMuted);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        color: isVideoMuted
                            ? const Color(0xffD64467)
                            : const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.06),
                              offset: const Offset(0, 4)),
                        ]),
                    width: 72,
                    height: 72,
                    child: Icon(
                      isVideoMuted ? Icons.videocam_off_sharp : Icons.videocam,
                      color: isVideoMuted ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const Spacer(flex: 16),
                GestureDetector(
                  onTap: joinMeeting,
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          color: const Color(0xffAA66CC),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.06),
                                offset: const Offset(0, 4)),
                          ]),
                      width: 174,
                      height: 72,
                      child: const Center(
                        child: const Text(
                          "JOIN MEET",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
                const Spacer(flex: 32),
              ],
            ),
            const Spacer(flex: 38),
          ],
        ),
      ),
    );
  }
}
