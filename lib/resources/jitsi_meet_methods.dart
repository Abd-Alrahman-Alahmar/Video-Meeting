import 'package:flutter_9/resources/auth_methods.dart';
import 'package:flutter_9/resources/firestore_methods.dart';
//import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet_v1/feature_flag/feature_flag.dart';
//import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet_v1/jitsi_meet.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .SD_RESOLUTION; // Limit video resolution to 480p

      featureFlag.closeCaptionsEnabled = false;
      featureFlag.raiseHandEnabled = false;
      featureFlag.recordingEnabled = false;
      featureFlag.videoShareButtonEnabled = false;
      featureFlag.liveStreamingEnabled = false;
      featureFlag.calendarEnabled = false;
      featureFlag.iOSRecordingEnabled = false;
      featureFlag.tileViewEnabled = false;

      String name;
      if (username.isEmpty) {
        name = _authMethods.user.displayName!;
      } else {
        name = username;
      }
      var options = JitsiMeetingOptions(room: roomName)
        ..userDisplayName = name
        ..userEmail = _authMethods.user.email
        ..userAvatarURL = _authMethods.user.photoURL
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      _firestoreMethods.addToMeetingHistory(roomName);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print("error: $error");
    }
  }
}
