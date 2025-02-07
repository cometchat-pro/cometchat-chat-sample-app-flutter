import 'package:flutter/material.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class CometChatCallLogRecordings extends StatefulWidget {
  const CometChatCallLogRecordings({
    Key? key,
    required this.callLog,
  }) : super(key: key);

  ///[callLog] callLog object for CallLog recordings
  final CallLog callLog;

  @override
  State<CometChatCallLogRecordings> createState() =>
      _CometChatCallLogRecordingsState();
}

class _CometChatCallLogRecordingsState
    extends State<CometChatCallLogRecordings> {
  User? loggedInUser;

  List<bool> _isLoadingList = [];

  @override
  void initState() {
    super.initState();
    _initializeLoggedInUser();
    _initializeListLoading();
  }

  late CometChatColorPalette colorPalette;
  late CometChatTypography typography;
  late CometChatSpacing spacing;

  _initializeLoggedInUser() async {
    loggedInUser = await CometChat.getLoggedInUser();
    setState(() {});
  }

  _initializeListLoading() async {
    if (widget.callLog.recordings != null &&
        widget.callLog.recordings!.isNotEmpty) {
      _isLoadingList = List.filled(widget.callLog.recordings!.length, false);
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize typography, color palette, and spacing
    typography = CometChatThemeHelper.getTypography(context);
    colorPalette = CometChatThemeHelper.getColorPalette(context);
    spacing = CometChatThemeHelper.getSpacing(context);
  }

  @override
  Widget build(BuildContext context) {
    return (loggedInUser == null)
        ? const Scaffold()
        : (widget.callLog.recordings == null ||
                widget.callLog.recordings!.isEmpty)
            ? _emptyView(context)
            : ListView.builder(
                itemCount: widget.callLog.recordings!.length,
                itemBuilder: (context, index) {
                  final recordings = widget.callLog.recordings![index];
                  _isLoadingList = List.filled(
                      widget.callLog.recordings!.length,
                      false); // Initialize the loading state list
                  return ListTile(
                    enableFeedback: false,
                    horizontalTitleGap: 0,
                    minVerticalPadding: 0,
                    minLeadingWidth: 0,
                    minTileHeight: 0,
                    contentPadding: EdgeInsets.only(
                      top: spacing.padding3 ?? 12,
                      bottom: spacing.padding3 ?? 12,
                      left: spacing.padding4 ?? 16,
                      right: spacing.padding6 ?? 24,
                    ),
                    leading: const SizedBox(),
                    title: Text(
                      recordings.rid ?? "",
                      style: TextStyle(
                        color: colorPalette.textPrimary,
                        fontSize: typography.heading4?.medium?.fontSize,
                        fontWeight: typography.heading4?.medium?.fontWeight,
                        fontFamily: typography.heading4?.medium?.fontFamily,
                      ),
                    ),
                    subtitle: CometChatDate(
                      pattern: DateTimePattern.dayDateFormat,
                      customDateString: getDate(
                        widget.callLog.initiatedAt,
                      ),
                      padding: EdgeInsets.zero,
                      style: CometChatDateStyle(
                        backgroundColor: colorPalette.transparent,
                        textStyle: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: colorPalette.textSecondary,
                          fontSize: typography.body?.regular?.fontSize,
                          fontWeight: typography.body?.regular?.fontWeight,
                          fontFamily: typography.body?.regular?.fontFamily,
                        ),
                        border: Border.all(
                          width: 0,
                          color: colorPalette.transparent ?? Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    trailing: Padding(
                      padding: EdgeInsets.only(
                        left: spacing.padding3 ?? 12,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: spacing.padding5 ?? 20,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                if (recordings.recordingUrl != null &&
                                    recordings.recordingUrl!.isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoPlayer(
                                        backIcon: colorPalette.primary,
                                        fullScreenBackground:
                                            colorPalette.neutral50,
                                        videoUrl: recordings.recordingUrl!,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Icon(
                                Icons.play_arrow_outlined,
                                color: colorPalette.iconHighlight,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (recordings.recordingUrl != null &&
                                  recordings.recordingUrl!.isNotEmpty) {
                                downloadFile(context, recordings.recordingUrl!,
                                    recordings, index);
                              }
                            },
                            child: (_isLoadingList[index])
                                ? SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                      color: colorPalette.iconHighlight,
                                      strokeWidth: 3,
                                    ),
                                  )
                                : Icon(
                                    Icons.file_download_outlined,
                                    color: colorPalette.iconHighlight,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
  }

  // Empty Widget
  Widget _emptyView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.call,
            color: colorPalette.neutral300,
            size: 100,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: spacing.padding5 ?? 20,
              bottom: spacing.padding ?? 2,
            ),
            child: Text(
              "No Call Recordings",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorPalette.textPrimary,
                fontSize: typography.heading3?.bold?.fontSize,
                fontWeight: typography.heading3?.bold?.fontWeight,
                fontFamily: typography.heading3?.bold?.fontFamily,
              ),
            ),
          ),
          Text(
            "Record a call to see call recordings listed here.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorPalette.textSecondary,
              fontSize: typography.heading3?.regular?.fontSize,
              fontWeight: typography.heading3?.regular?.fontWeight,
              fontFamily: typography.heading3?.regular?.fontFamily,
            ),
          ),
        ],
      ),
    );
  }

  String getDate(
    int? epochTimestampInSeconds,
  ) {
    String formattedDate = "";
    if (epochTimestampInSeconds == null) {
      return formattedDate;
    }
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(epochTimestampInSeconds * 1000);

    return formattedDate = DateFormat('d MMMM, h:mm a').format(dateTime);
  }

  Future<void> downloadFile(
      context, String url, Recordings recording, int index) async {
    setState(() {
      _isLoadingList[index] = true; // Show loader for this specific recording
    });

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        // Get the temporary directory of the device
        final directory = await getTemporaryDirectory();
        final filePath =
            '${directory.path}/downloaded_video_${recording.rid}.mp4'; // Use a unique name

        // Write the file
        final file = File(filePath);
        await file.writeAsBytes(bytes);

        // Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Download completed for recording $index!")),
        );
      } else {
        // Show error snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Download failed: ${response.statusCode}")),
        );
      }
    } catch (e) {
      // Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        _isLoadingList[index] =
            false; // Hide loader for this specific recording
      });
    }
  }
}
