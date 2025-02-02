import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:tiktok_clone/features/videos/view_models/upload_video_view_model.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  final XFile video;
  final bool isPicked;

  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isPicked,
  });

  @override
  VideoPreviewScreenState createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;

  bool _savedVideo = false;

  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _saveToGallery() async {
    if (_savedVideo) return;

    String newFilePath;

    if (widget.video.path.endsWith(".temp")) {
      newFilePath = await _convertTempFileToVideo(widget.video.path);
    } else {
      newFilePath = widget.video.path;
    }

    final result = await ImageGallerySaverPlus.saveFile(newFilePath);

    if (result["isSuccess"] == true) {
      _savedVideo = true;
      setState(() {});
    }
  }

  Future<String> _convertTempFileToVideo(String tempFilePath) async {
    final tempFile = File(tempFilePath);
    final fileContent = await tempFile.readAsBytes();
    final newFilePath = tempFilePath.replaceFirst('.temp', '.mp4');
    final newFile = File(newFilePath);

    await newFile.writeAsBytes(fileContent);
    return newFilePath;
  }

  void _onUploadPressed() {
    ref.read(uploadVideoProvider.notifier).uploadVideo(
          File(widget.video.path),
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Preview video"),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: FaIcon(_savedVideo
                  ? FontAwesomeIcons.check
                  : FontAwesomeIcons.download),
            ),
          IconButton(
            onPressed: ref.watch(uploadVideoProvider).isLoading
                ? () {}
                : _onUploadPressed,
            icon: ref.watch(uploadVideoProvider).isLoading
                ? const CircularProgressIndicator()
                : const FaIcon(FontAwesomeIcons.cloudArrowUp),
          ),
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : null,
    );
  }
// TODO: 프리뷰 화면에서 제목, 설명 적고 같이 업로드
}
