import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the controller with your video file (local asset or network)
//     _controller = VideoPlayerController.asset('assets/videos/book1.mp4')
//       ..initialize().then((_) {
//         // Ensure the first frame is shown
//         setState(() {});
//       });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     // Dispose of the controller when the widget is disposed
//     _controller.dispose();
//   }

//   void _playPause() {
//     setState(() {
//       if (_isPlaying) {
//         _controller.pause();
//       } else {
//         _controller.play();
//       }
//       _isPlaying = !_isPlaying;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(title: const Text('Video Player')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Display the video player if initialized
//             _controller.value.isInitialized
//                 ? AspectRatio(
//                     aspectRatio: _controller.value.aspectRatio,
//                     child: VideoPlayer(_controller),
//                   )
//                 : const CircularProgressIndicator(),
//             const SizedBox(height: 20),
//             // Play/Pause Button
//             IconButton(
//               icon: Icon(
//                 _isPlaying ? Icons.pause : Icons.play_arrow,
//                 size: 50,
//               ),
//               onPressed: _playPause,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(const MaterialApp(
//     home: HomePage(),
//   ));
// }

class HomePage extends StatefulWidget {
  const   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("d"),
    );
  }
}