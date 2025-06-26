// // // // // import 'package:flutter/material.dart';
// // // // // import '../models/place.dart';
// // // // // import '../utils/colors.dart';
// // // // //
// // // // // class PlaceDetailPage extends StatelessWidget {
// // // // //   final Place place;
// // // // //
// // // // //   const PlaceDetailPage({required this.place});
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       backgroundColor: AppColors.softGray,
// // // // //       appBar: AppBar(
// // // // //         backgroundColor: AppColors.primaryBrown,
// // // // //         title: Text(
// // // // //           place.name,
// // // // //           style: TextStyle(
// // // // //             fontFamily: 'Cinzel', // Make sure this font is declared in pubspec.yaml
// // // // //             fontSize: 20,
// // // // //             fontWeight: FontWeight.bold,
// // // // //             color: Colors.white, // White text color
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //       body: SingleChildScrollView(
// // // // //         child: Column(
// // // // //           children: [
// // // // //             Image.asset(
// // // // //               place.image,
// // // // //               width: double.infinity,
// // // // //               height: 250,
// // // // //               fit: BoxFit.cover,
// // // // //             ),
// // // // //             Padding(
// // // // //               padding: const EdgeInsets.all(20.0),
// // // // //               child: Column(
// // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                 children: [
// // // // //                   Text(
// // // // //                     place.name,
// // // // //                     style: TextStyle(
// // // // //                       fontSize: 24,
// // // // //                       fontWeight: FontWeight.bold,
// // // // //                       color: AppColors.textDark,
// // // // //                     ),
// // // // //                   ),
// // // // //                   SizedBox(height: 10),
// // // // //                   Row(
// // // // //                     children: [
// // // // //                       Icon(Icons.star, color: AppColors.goldAccent),
// // // // //                       SizedBox(width: 5),
// // // // //                       Text(
// // // // //                         place.rating.toString(),
// // // // //                         style: TextStyle(color: AppColors.textLight),
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                   SizedBox(height: 20),
// // // // //                   Text(
// // // // //                     place.description,
// // // // //                     style: TextStyle(fontSize: 16, color: AppColors.textDark),
// // // // //                   ),
// // // // //                   SizedBox(height: 20),
// // // // //                   Wrap(
// // // // //                     spacing: 10,
// // // // //                     children: place.tags
// // // // //                         .map((tag) => Chip(
// // // // //                       label: Text(tag),
// // // // //                       backgroundColor:
// // // // //                       AppColors.primaryBrown.withOpacity(0.1),
// // // // //                     ))
// // // // //                         .toList(),
// // // // //                   ),
// // // // //                   SizedBox(height: 30),
// // // // //
// // // // //                   // Buttons Row
// // // // //                   Row(
// // // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                     children: [
// // // // //                       Expanded(
// // // // //                         child: ElevatedButton.icon(
// // // // //                           onPressed: () {
// // // // //                             // TODO: Start AR Experience
// // // // //                           },
// // // // //                           icon: Icon(Icons.view_in_ar),
// // // // //                           label: Text("AR Experience"),
// // // // //                           style: ElevatedButton.styleFrom(
// // // // //                             backgroundColor: AppColors.primaryBrown,
// // // // //                             foregroundColor: Colors.white,
// // // // //                             padding: EdgeInsets.symmetric(vertical: 14),
// // // // //                           ),
// // // // //                         ),
// // // // //                       ),
// // // // //                       SizedBox(width: 10),
// // // // //                       Expanded(
// // // // //                         child: ElevatedButton.icon(
// // // // //                           onPressed: () {
// // // // //                             // TODO: Play Audio Guide
// // // // //                           },
// // // // //                           icon: Icon(Icons.play_circle),
// // // // //                           label: Text("Audio Guide"),
// // // // //                           style: ElevatedButton.styleFrom(
// // // // //                             backgroundColor: AppColors.primaryBrown,
// // // // //                             foregroundColor: Colors.white,
// // // // //                             padding: EdgeInsets.symmetric(vertical: 14),
// // // // //                           ),
// // // // //                         ),
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
// // // //
// // // // import 'package:flutter/material.dart';
// // // // import 'package:audioplayers/audioplayers.dart';
// // // // import '../models/place.dart';
// // // // import '../utils/colors.dart';
// // // //
// // // // class PlaceDetailPage extends StatefulWidget {
// // // //   final Place place;
// // // //
// // // //   const PlaceDetailPage({required this.place});
// // // //
// // // //   @override
// // // //   _PlaceDetailPageState createState() => _PlaceDetailPageState();
// // // // }
// // // //
// // // // class _PlaceDetailPageState extends State<PlaceDetailPage> {
// // // //   final AudioPlayer _audioPlayer = AudioPlayer();
// // // //   bool _isPlaying = false;
// // // //   bool _isLoading = false;
// // // //   Duration _duration = Duration.zero;
// // // //   Duration _position = Duration.zero;
// // // //
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _setupAudioPlayer();
// // // //   }
// // // //
// // // //   void _setupAudioPlayer() {
// // // //     // Listen to player state changes
// // // //     _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
// // // //       if (mounted) {
// // // //         setState(() {
// // // //           _isPlaying = state == PlayerState.playing;
// // // //           _isLoading = state == PlayerState.buffering;
// // // //         });
// // // //       }
// // // //     });
// // // //
// // // //     // Listen to duration changes
// // // //     _audioPlayer.onDurationChanged.listen((Duration duration) {
// // // //       if (mounted) {
// // // //         setState(() {
// // // //           _duration = duration;
// // // //         });
// // // //       }
// // // //     });
// // // //
// // // //     // Listen to position changes
// // // //     _audioPlayer.onPositionChanged.listen((Duration position) {
// // // //       if (mounted) {
// // // //         setState(() {
// // // //           _position = position;
// // // //         });
// // // //       }
// // // //     });
// // // //
// // // //     // Listen to completion
// // // //     _audioPlayer.onPlayerComplete.listen((_) {
// // // //       if (mounted) {
// // // //         setState(() {
// // // //           _isPlaying = false;
// // // //           _position = Duration.zero;
// // // //         });
// // // //       }
// // // //     });
// // // //   }
// // // //
// // // //   Future<void> _playPauseAudio() async {
// // // //     try {
// // // //       if (_isPlaying) {
// // // //         await _audioPlayer.pause();
// // // //       } else {
// // // //         await _audioPlayer.play(AssetSource('Nyatapola.wav'));
// // // //       }
// // // //     } catch (e) {
// // // //       // Handle error - show snackbar
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(
// // // //           content: Text('Error playing audio: ${e.toString()}'),
// // // //           backgroundColor: Colors.red,
// // // //         ),
// // // //       );
// // // //     }
// // // //   }
// // // //
// // // //   Future<void> _stopAudio() async {
// // // //     await _audioPlayer.stop();
// // // //     setState(() {
// // // //       _position = Duration.zero;
// // // //     });
// // // //   }
// // // //
// // // //   String _formatDuration(Duration duration) {
// // // //     String twoDigits(int n) => n.toString().padLeft(2, '0');
// // // //     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
// // // //     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
// // // //     return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
// // // //   }
// // // //
// // // //   @override
// // // //   void dispose() {
// // // //     _audioPlayer.dispose();
// // // //     super.dispose();
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: AppColors.softGray,
// // // //       appBar: AppBar(
// // // //         backgroundColor: AppColors.primaryBrown,
// // // //         title: Text(
// // // //           widget.place.name,
// // // //           style: TextStyle(
// // // //             fontFamily: 'Cinzel', // Make sure this font is declared in pubspec.yaml
// // // //             fontSize: 20,
// // // //             fontWeight: FontWeight.bold,
// // // //             color: Colors.white, // White text color
// // // //           ),
// // // //         ),
// // // //       ),
// // // //       body: SingleChildScrollView(
// // // //         child: Column(
// // // //           children: [
// // // //             Image.asset(
// // // //               widget.place.image,
// // // //               width: double.infinity,
// // // //               height: 250,
// // // //               fit: BoxFit.cover,
// // // //             ),
// // // //             Padding(
// // // //               padding: const EdgeInsets.all(20.0),
// // // //               child: Column(
// // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                 children: [
// // // //                   Text(
// // // //                     widget.place.name,
// // // //                     style: TextStyle(
// // // //                       fontSize: 24,
// // // //                       fontWeight: FontWeight.bold,
// // // //                       color: AppColors.textDark,
// // // //                     ),
// // // //                   ),
// // // //                   SizedBox(height: 10),
// // // //                   Row(
// // // //                     children: [
// // // //                       Icon(Icons.star, color: AppColors.goldAccent),
// // // //                       SizedBox(width: 5),
// // // //                       Text(
// // // //                         widget.place.rating.toString(),
// // // //                         style: TextStyle(color: AppColors.textLight),
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                   SizedBox(height: 20),
// // // //                   Text(
// // // //                     widget.place.description,
// // // //                     style: TextStyle(fontSize: 16, color: AppColors.textDark),
// // // //                   ),
// // // //                   SizedBox(height: 20),
// // // //                   Wrap(
// // // //                     spacing: 10,
// // // //                     children: widget.place.tags
// // // //                         .map((tag) => Chip(
// // // //                       label: Text(tag),
// // // //                       backgroundColor:
// // // //                       AppColors.primaryBrown.withOpacity(0.1),
// // // //                     ))
// // // //                         .toList(),
// // // //                   ),
// // // //                   SizedBox(height: 30),
// // // //
// // // //                   // Audio Player Controls (if audio is playing)
// // // //                   if (_isPlaying || _position.inSeconds > 0)
// // // //                     Container(
// // // //                       padding: EdgeInsets.all(16),
// // // //                       margin: EdgeInsets.only(bottom: 20),
// // // //                       decoration: BoxDecoration(
// // // //                         color: AppColors.primaryBrown.withOpacity(0.1),
// // // //                         borderRadius: BorderRadius.circular(12),
// // // //                         border: Border.all(
// // // //                           color: AppColors.primaryBrown.withOpacity(0.3),
// // // //                         ),
// // // //                       ),
// // // //                       child: Column(
// // // //                         children: [
// // // //                           Row(
// // // //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                             children: [
// // // //                               Text(
// // // //                                 _formatDuration(_position),
// // // //                                 style: TextStyle(
// // // //                                   color: AppColors.textDark,
// // // //                                   fontSize: 12,
// // // //                                 ),
// // // //                               ),
// // // //                               Text(
// // // //                                 _formatDuration(_duration),
// // // //                                 style: TextStyle(
// // // //                                   color: AppColors.textDark,
// // // //                                   fontSize: 12,
// // // //                                 ),
// // // //                               ),
// // // //                             ],
// // // //                           ),
// // // //                           SizedBox(height: 8),
// // // //                           SliderTheme(
// // // //                             data: SliderTheme.of(context).copyWith(
// // // //                               activeTrackColor: AppColors.primaryBrown,
// // // //                               inactiveTrackColor: AppColors.primaryBrown.withOpacity(0.3),
// // // //                               thumbColor: AppColors.primaryBrown,
// // // //                               overlayColor: AppColors.primaryBrown.withOpacity(0.2),
// // // //                             ),
// // // //                             child: Slider(
// // // //                               value: _position.inSeconds.toDouble(),
// // // //                               max: _duration.inSeconds.toDouble(),
// // // //                               onChanged: (value) async {
// // // //                                 final position = Duration(seconds: value.toInt());
// // // //                                 await _audioPlayer.seek(position);
// // // //                               },
// // // //                             ),
// // // //                           ),
// // // //                           SizedBox(height: 8),
// // // //                           Row(
// // // //                             mainAxisAlignment: MainAxisAlignment.center,
// // // //                             children: [
// // // //                               IconButton(
// // // //                                 onPressed: _stopAudio,
// // // //                                 icon: Icon(Icons.stop),
// // // //                                 color: AppColors.primaryBrown,
// // // //                               ),
// // // //                               SizedBox(width: 20),
// // // //                               IconButton(
// // // //                                 onPressed: _isLoading ? null : _playPauseAudio,
// // // //                                 icon: _isLoading
// // // //                                     ? SizedBox(
// // // //                                   width: 24,
// // // //                                   height: 24,
// // // //                                   child: CircularProgressIndicator(
// // // //                                     strokeWidth: 2,
// // // //                                     valueColor: AlwaysStoppedAnimation<Color>(
// // // //                                       AppColors.primaryBrown,
// // // //                                     ),
// // // //                                   ),
// // // //                                 )
// // // //                                     : Icon(
// // // //                                   _isPlaying ? Icons.pause : Icons.play_arrow,
// // // //                                 ),
// // // //                                 color: AppColors.primaryBrown,
// // // //                                 iconSize: 32,
// // // //                               ),
// // // //                             ],
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //
// // // //                   // Buttons Row
// // // //                   Row(
// // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                     children: [
// // // //                       Expanded(
// // // //                         child: ElevatedButton.icon(
// // // //                           onPressed: () {
// // // //                             // TODO: Start AR Experience
// // // //                           },
// // // //                           icon: Icon(Icons.view_in_ar),
// // // //                           label: Text("AR Experience"),
// // // //                           style: ElevatedButton.styleFrom(
// // // //                             backgroundColor: AppColors.primaryBrown,
// // // //                             foregroundColor: Colors.white,
// // // //                             padding: EdgeInsets.symmetric(vertical: 14),
// // // //                           ),
// // // //                         ),
// // // //                       ),
// // // //                       SizedBox(width: 10),
// // // //                       Expanded(
// // // //                         child: ElevatedButton.icon(
// // // //                           onPressed: _isLoading ? null : _playPauseAudio,
// // // //                           icon: _isLoading
// // // //                               ? SizedBox(
// // // //                             width: 16,
// // // //                             height: 16,
// // // //                             child: CircularProgressIndicator(
// // // //                               strokeWidth: 2,
// // // //                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// // // //                             ),
// // // //                           )
// // // //                               : Icon(_isPlaying ? Icons.pause : Icons.play_circle),
// // // //                           label: Text(_isPlaying ? "Pause Guide" : "Audio Guide"),
// // // //                           style: ElevatedButton.styleFrom(
// // // //                             backgroundColor: AppColors.primaryBrown,
// // // //                             foregroundColor: Colors.white,
// // // //                             padding: EdgeInsets.symmetric(vertical: 14),
// // // //                           ),
// // // //                         ),
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:audioplayers/audioplayers.dart';
// // // import '../models/place.dart';
// // // import '../utils/colors.dart';
// // //
// // // class PlaceDetailPage extends StatefulWidget {
// // //   final Place place;
// // //
// // //   const PlaceDetailPage({required this.place});
// // //
// // //   @override
// // //   _PlaceDetailPageState createState() => _PlaceDetailPageState();
// // // }
// // //
// // // class _PlaceDetailPageState extends State<PlaceDetailPage> {
// // //   final AudioPlayer _audioPlayer = AudioPlayer();
// // //   bool _isPlaying = false;
// // //   bool _isLoading = false;
// // //   Duration _duration = Duration.zero;
// // //   Duration _position = Duration.zero;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _setupAudioPlayer();
// // //   }
// // //
// // //   void _setupAudioPlayer() {
// // //     // Listen to player state changes
// // //     _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
// // //       if (mounted) {
// // //         setState(() {
// // //           _isPlaying = state == PlayerState.playing;
// // //           _isLoading = false; // We'll handle loading state differently
// // //         });
// // //       }
// // //     });
// // //
// // //     // Listen to duration changes
// // //     _audioPlayer.onDurationChanged.listen((Duration duration) {
// // //       if (mounted) {
// // //         setState(() {
// // //           _duration = duration;
// // //         });
// // //       }
// // //     });
// // //
// // //     // Listen to position changes
// // //     _audioPlayer.onPositionChanged.listen((Duration position) {
// // //       if (mounted) {
// // //         setState(() {
// // //           _position = position;
// // //         });
// // //       }
// // //     });
// // //
// // //     // Listen to completion
// // //     _audioPlayer.onPlayerComplete.listen((_) {
// // //       if (mounted) {
// // //         setState(() {
// // //           _isPlaying = false;
// // //           _position = Duration.zero;
// // //         });
// // //       }
// // //     });
// // //   }
// // //
// // //   Future<void> _playPauseAudio() async {
// // //     try {
// // //       if (_isPlaying) {
// // //         await _audioPlayer.pause();
// // //       } else {
// // //         setState(() {
// // //           _isLoading = true;
// // //         });
// // //         await _audioPlayer.play(AssetSource('Nyatapola.wav'));
// // //         setState(() {
// // //           _isLoading = false;
// // //         });
// // //       }
// // //     } catch (e) {
// // //       setState(() {
// // //         _isLoading = false;
// // //       });
// // //       // Handle error - show snackbar
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(
// // //           content: Text('Error playing audio: ${e.toString()}'),
// // //           backgroundColor: Colors.red,
// // //         ),
// // //       );
// // //     }
// // //   }
// // //
// // //   Future<void> _stopAudio() async {
// // //     await _audioPlayer.stop();
// // //     setState(() {
// // //       _position = Duration.zero;
// // //     });
// // //   }
// // //
// // //   String _formatDuration(Duration duration) {
// // //     String twoDigits(int n) => n.toString().padLeft(2, '0');
// // //     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
// // //     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
// // //     return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
// // //   }
// // //
// // //   @override
// // //   void dispose() {
// // //     _audioPlayer.dispose();
// // //     super.dispose();
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: AppColors.softGray,
// // //       appBar: AppBar(
// // //         backgroundColor: AppColors.primaryBrown,
// // //         title: Text(
// // //           widget.place.name,
// // //           style: TextStyle(
// // //             fontFamily: 'Cinzel', // Make sure this font is declared in pubspec.yaml
// // //             fontSize: 20,
// // //             fontWeight: FontWeight.bold,
// // //             color: Colors.white, // White text color
// // //           ),
// // //         ),
// // //       ),
// // //       body: SingleChildScrollView(
// // //         child: Column(
// // //           children: [
// // //             Image.asset(
// // //               widget.place.image,
// // //               width: double.infinity,
// // //               height: 250,
// // //               fit: BoxFit.cover,
// // //             ),
// // //             Padding(
// // //               padding: const EdgeInsets.all(20.0),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(
// // //                     widget.place.name,
// // //                     style: TextStyle(
// // //                       fontSize: 24,
// // //                       fontWeight: FontWeight.bold,
// // //                       color: AppColors.textDark,
// // //                     ),
// // //                   ),
// // //                   SizedBox(height: 10),
// // //                   Row(
// // //                     children: [
// // //                       Icon(Icons.star, color: AppColors.goldAccent),
// // //                       SizedBox(width: 5),
// // //                       Text(
// // //                         widget.place.rating.toString(),
// // //                         style: TextStyle(color: AppColors.textLight),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   SizedBox(height: 20),
// // //                   Text(
// // //                     widget.place.description,
// // //                     style: TextStyle(fontSize: 16, color: AppColors.textDark),
// // //                   ),
// // //                   SizedBox(height: 20),
// // //                   Wrap(
// // //                     spacing: 10,
// // //                     children: widget.place.tags
// // //                         .map((tag) => Chip(
// // //                       label: Text(tag),
// // //                       backgroundColor:
// // //                       AppColors.primaryBrown.withOpacity(0.1),
// // //                     ))
// // //                         .toList(),
// // //                   ),
// // //                   SizedBox(height: 30),
// // //
// // //                   // Audio Player Controls (if audio is playing)
// // //                   if (_isPlaying || _position.inSeconds > 0)
// // //                     Container(
// // //                       padding: EdgeInsets.all(16),
// // //                       margin: EdgeInsets.only(bottom: 20),
// // //                       decoration: BoxDecoration(
// // //                         color: AppColors.primaryBrown.withOpacity(0.1),
// // //                         borderRadius: BorderRadius.circular(12),
// // //                         border: Border.all(
// // //                           color: AppColors.primaryBrown.withOpacity(0.3),
// // //                         ),
// // //                       ),
// // //                       child: Column(
// // //                         children: [
// // //                           Row(
// // //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                             children: [
// // //                               Text(
// // //                                 _formatDuration(_position),
// // //                                 style: TextStyle(
// // //                                   color: AppColors.textDark,
// // //                                   fontSize: 12,
// // //                                 ),
// // //                               ),
// // //                               Text(
// // //                                 _formatDuration(_duration),
// // //                                 style: TextStyle(
// // //                                   color: AppColors.textDark,
// // //                                   fontSize: 12,
// // //                                 ),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                           SizedBox(height: 8),
// // //                           SliderTheme(
// // //                             data: SliderTheme.of(context).copyWith(
// // //                               activeTrackColor: AppColors.primaryBrown,
// // //                               inactiveTrackColor: AppColors.primaryBrown.withOpacity(0.3),
// // //                               thumbColor: AppColors.primaryBrown,
// // //                               overlayColor: AppColors.primaryBrown.withOpacity(0.2),
// // //                             ),
// // //                             child: Slider(
// // //                               value: _position.inSeconds.toDouble(),
// // //                               max: _duration.inSeconds.toDouble(),
// // //                               onChanged: (value) async {
// // //                                 final position = Duration(seconds: value.toInt());
// // //                                 await _audioPlayer.seek(position);
// // //                               },
// // //                             ),
// // //                           ),
// // //                           SizedBox(height: 8),
// // //                           Row(
// // //                             mainAxisAlignment: MainAxisAlignment.center,
// // //                             children: [
// // //                               IconButton(
// // //                                 onPressed: _stopAudio,
// // //                                 icon: Icon(Icons.stop),
// // //                                 color: AppColors.primaryBrown,
// // //                               ),
// // //                               SizedBox(width: 20),
// // //                               IconButton(
// // //                                 onPressed: _isLoading ? null : _playPauseAudio,
// // //                                 icon: _isLoading
// // //                                     ? SizedBox(
// // //                                   width: 24,
// // //                                   height: 24,
// // //                                   child: CircularProgressIndicator(
// // //                                     strokeWidth: 2,
// // //                                     valueColor: AlwaysStoppedAnimation<Color>(
// // //                                       AppColors.primaryBrown,
// // //                                     ),
// // //                                   ),
// // //                                 )
// // //                                     : Icon(
// // //                                   _isPlaying ? Icons.pause : Icons.play_arrow,
// // //                                 ),
// // //                                 color: AppColors.primaryBrown,
// // //                                 iconSize: 32,
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //
// // //                   // Buttons Row
// // //                   Row(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                     children: [
// // //                       Expanded(
// // //                         child: ElevatedButton.icon(
// // //                           onPressed: () {
// // //                             // TODO: Start AR Experience
// // //                           },
// // //                           icon: Icon(Icons.view_in_ar),
// // //                           label: Text("AR Experience"),
// // //                           style: ElevatedButton.styleFrom(
// // //                             backgroundColor: AppColors.primaryBrown,
// // //                             foregroundColor: Colors.white,
// // //                             padding: EdgeInsets.symmetric(vertical: 14),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                       SizedBox(width: 10),
// // //                       Expanded(
// // //                         child: ElevatedButton.icon(
// // //                           onPressed: _isLoading ? null : _playPauseAudio,
// // //                           icon: _isLoading
// // //                               ? SizedBox(
// // //                             width: 16,
// // //                             height: 16,
// // //                             child: CircularProgressIndicator(
// // //                               strokeWidth: 2,
// // //                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// // //                             ),
// // //                           )
// // //                               : Icon(_isPlaying ? Icons.pause : Icons.play_circle),
// // //                           label: Text(_isPlaying ? "Pause Guide" : "Audio Guide"),
// // //                           style: ElevatedButton.styleFrom(
// // //                             backgroundColor: AppColors.primaryBrown,
// // //                             foregroundColor: Colors.white,
// // //                             padding: EdgeInsets.symmetric(vertical: 14),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // import 'package:flutter/material.dart';
// // import 'package:audioplayers/audioplayers.dart';
// // import '../models/place.dart';
// // import '../utils/colors.dart';
// //
// // class PlaceDetailPage extends StatefulWidget {
// //   final Place place;
// //
// //   const PlaceDetailPage({required this.place});
// //
// //   @override
// //   _PlaceDetailPageState createState() => _PlaceDetailPageState();
// // }
// //
// // class _PlaceDetailPageState extends State<PlaceDetailPage> {
// //   final AudioPlayer _audioPlayer = AudioPlayer();
// //   bool _isPlaying = false;
// //   bool _isLoading = false;
// //   Duration _duration = Duration.zero;
// //   Duration _position = Duration.zero;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _setupAudioPlayer();
// //   }
// //
// //   void _setupAudioPlayer() {
// //     // Listen to player state changes
// //     _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
// //       if (mounted) {
// //         setState(() {
// //           _isPlaying = state == PlayerState.playing;
// //           _isLoading = false; // We'll handle loading state differently
// //         });
// //       }
// //     });
// //
// //     // Listen to duration changes
// //     _audioPlayer.onDurationChanged.listen((Duration duration) {
// //       if (mounted) {
// //         setState(() {
// //           _duration = duration;
// //         });
// //       }
// //     });
// //
// //     // Listen to position changes
// //     _audioPlayer.onPositionChanged.listen((Duration position) {
// //       if (mounted) {
// //         setState(() {
// //           _position = position;
// //         });
// //       }
// //     });
// //
// //     // Listen to completion
// //     _audioPlayer.onPlayerComplete.listen((_) {
// //       if (mounted) {
// //         setState(() {
// //           _isPlaying = false;
// //           _position = Duration.zero;
// //         });
// //       }
// //     });
// //   }
// //
// //   Future<void> _playPauseAudio() async {
// //     try {
// //       if (_isPlaying) {
// //         await _audioPlayer.pause();
// //       } else {
// //         setState(() {
// //           _isLoading = true;
// //         });
// //         await _audioPlayer.play(AssetSource('Nyatapola.wav'));
// //         setState(() {
// //           _isLoading = false;
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         _isLoading = false;
// //       });
// //       // Handle error - show snackbar
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Error playing audio: ${e.toString()}'),
// //           backgroundColor: Colors.red,
// //         ),
// //       );
// //     }
// //   }
// //
// //   Future<void> _stopAudio() async {
// //     await _audioPlayer.stop();
// //     setState(() {
// //       _position = Duration.zero;
// //     });
// //   }
// //
// //   String _formatDuration(Duration duration) {
// //     String twoDigits(int n) => n.toString().padLeft(2, '0');
// //     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
// //     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
// //     return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
// //   }
// //
// //   @override
// //   void dispose() {
// //     _audioPlayer.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.softGray,
// //       appBar: AppBar(
// //         backgroundColor: AppColors.primaryBrown,
// //         title: Text(
// //           widget.place.name,
// //           style: TextStyle(
// //             fontFamily: 'Cinzel', // Make sure this font is declared in pubspec.yaml
// //             fontSize: 20,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white, // White text color
// //           ),
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             Image.asset(
// //               widget.place.image,
// //               width: double.infinity,
// //               height: 250,
// //               fit: BoxFit.cover,
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(20.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     widget.place.name,
// //                     style: TextStyle(
// //                       fontSize: 24,
// //                       fontWeight: FontWeight.bold,
// //                       color: AppColors.textDark,
// //                     ),
// //                   ),
// //                   SizedBox(height: 10),
// //                   Row(
// //                     children: [
// //                       Icon(Icons.star, color: AppColors.goldAccent),
// //                       SizedBox(width: 5),
// //                       Text(
// //                         widget.place.rating.toString(),
// //                         style: TextStyle(color: AppColors.textLight),
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: 20),
// //                   Text(
// //                     widget.place.description,
// //                     style: TextStyle(fontSize: 16, color: AppColors.textDark),
// //                   ),
// //                   SizedBox(height: 20),
// //                   Wrap(
// //                     spacing: 10,
// //                     children: widget.place.tags
// //                         .map((tag) => Chip(
// //                       label: Text(tag),
// //                       backgroundColor:
// //                       AppColors.primaryBrown.withOpacity(0.1),
// //                     ))
// //                         .toList(),
// //                   ),
// //                   SizedBox(height: 30),
// //
// //                   // Audio Player Controls (if audio is playing)
// //                   if (_isPlaying || _position.inSeconds > 0)
// //                     Center(
// //                       child: Container(
// //                         width: MediaQuery.of(context).size.width * 0.8,
// //                         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
// //                         margin: EdgeInsets.only(bottom: 20),
// //                         decoration: BoxDecoration(
// //                           color: Colors.white,
// //                           borderRadius: BorderRadius.circular(16),
// //                           boxShadow: [
// //                             BoxShadow(
// //                               color: AppColors.primaryBrown.withOpacity(0.1),
// //                               blurRadius: 8,
// //                               offset: Offset(0, 2),
// //                             ),
// //                           ],
// //                           border: Border.all(
// //                             color: AppColors.primaryBrown.withOpacity(0.2),
// //                             width: 1,
// //                           ),
// //                         ),
// //                         child: Column(
// //                           mainAxisSize: MainAxisSize.min,
// //                           children: [
// //                             // Time display and controls row
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 Text(
// //                                   _formatDuration(_position),
// //                                   style: TextStyle(
// //                                     color: AppColors.textDark,
// //                                     fontSize: 11,
// //                                     fontWeight: FontWeight.w500,
// //                                   ),
// //                                 ),
// //                                 Row(
// //                                   mainAxisSize: MainAxisSize.min,
// //                                   children: [
// //                                     Container(
// //                                       decoration: BoxDecoration(
// //                                         color: AppColors.primaryBrown.withOpacity(0.1),
// //                                         shape: BoxShape.circle,
// //                                       ),
// //                                       child: IconButton(
// //                                         onPressed: _stopAudio,
// //                                         icon: Icon(Icons.stop, size: 18),
// //                                         color: AppColors.primaryBrown,
// //                                         padding: EdgeInsets.all(8),
// //                                         constraints: BoxConstraints(
// //                                           minWidth: 32,
// //                                           minHeight: 32,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     SizedBox(width: 8),
// //                                     Container(
// //                                       decoration: BoxDecoration(
// //                                         color: AppColors.primaryBrown,
// //                                         shape: BoxShape.circle,
// //                                       ),
// //                                       child: IconButton(
// //                                         onPressed: _isLoading ? null : _playPauseAudio,
// //                                         icon: _isLoading
// //                                             ? SizedBox(
// //                                           width: 18,
// //                                           height: 18,
// //                                           child: CircularProgressIndicator(
// //                                             strokeWidth: 2,
// //                                             valueColor: AlwaysStoppedAnimation<Color>(
// //                                               Colors.white,
// //                                             ),
// //                                           ),
// //                                         )
// //                                             : Icon(
// //                                           _isPlaying ? Icons.pause : Icons.play_arrow,
// //                                           size: 20,
// //                                         ),
// //                                         color: Colors.white,
// //                                         padding: EdgeInsets.all(8),
// //                                         constraints: BoxConstraints(
// //                                           minWidth: 36,
// //                                           minHeight: 36,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 Text(
// //                                   _formatDuration(_duration),
// //                                   style: TextStyle(
// //                                     color: AppColors.textDark,
// //                                     fontSize: 11,
// //                                     fontWeight: FontWeight.w500,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             SizedBox(height: 8),
// //                             // Progress slider
// //                             SliderTheme(
// //                               data: SliderTheme.of(context).copyWith(
// //                                 activeTrackColor: AppColors.primaryBrown,
// //                                 inactiveTrackColor: AppColors.primaryBrown.withOpacity(0.2),
// //                                 thumbColor: AppColors.primaryBrown,
// //                                 overlayColor: AppColors.primaryBrown.withOpacity(0.1),
// //                                 trackHeight: 3,
// //                                 thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
// //                               ),
// //                               child: Slider(
// //                                 value: _position.inSeconds.toDouble(),
// //                                 max: _duration.inSeconds.toDouble(),
// //                                 onChanged: (value) async {
// //                                   final position = Duration(seconds: value.toInt());
// //                                   await _audioPlayer.seek(position);
// //                                 },
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //
// //                   // Buttons Row
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Expanded(
// //                         child: ElevatedButton.icon(
// //                           onPressed: () {
// //                             // TODO: Start AR Experience
// //                           },
// //                           icon: Icon(Icons.view_in_ar),
// //                           label: Text("AR Experience"),
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: AppColors.primaryBrown,
// //                             foregroundColor: Colors.white,
// //                             padding: EdgeInsets.symmetric(vertical: 14),
// //                           ),
// //                         ),
// //                       ),
// //                       SizedBox(width: 10),
// //                       Expanded(
// //                         child: ElevatedButton.icon(
// //                           onPressed: _isLoading ? null : _playPauseAudio,
// //                           icon: _isLoading
// //                               ? SizedBox(
// //                             width: 16,
// //                             height: 16,
// //                             child: CircularProgressIndicator(
// //                               strokeWidth: 2,
// //                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
// //                             ),
// //                           )
// //                               : Icon(_isPlaying ? Icons.pause : Icons.play_circle),
// //                           label: Text(_isPlaying ? "Pause Guide" : "Audio Guide"),
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: AppColors.primaryBrown,
// //                             foregroundColor: Colors.white,
// //                             padding: EdgeInsets.symmetric(vertical: 14),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import '../models/place.dart';
// import '../utils/colors.dart';
//
// class PlaceDetailPage extends StatefulWidget {
//   final Place place;
//
//   const PlaceDetailPage({required this.place});
//
//   @override
//   _PlaceDetailPageState createState() => _PlaceDetailPageState();
// }
//
// class _PlaceDetailPageState extends State<PlaceDetailPage> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   bool _isPlaying = false;
//   bool _isLoading = false;
//   Duration _duration = Duration.zero;
//   Duration _position = Duration.zero;
//
//   @override
//   void initState() {
//     super.initState();
//     _setupAudioPlayer();
//   }
//
//   void _setupAudioPlayer() {
//     // Listen to player state changes
//     _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
//       if (mounted) {
//         setState(() {
//           _isPlaying = state == PlayerState.playing;
//           _isLoading = false; // We'll handle loading state differently
//         });
//       }
//     });
//
//     // Listen to duration changes
//     _audioPlayer.onDurationChanged.listen((Duration duration) {
//       if (mounted) {
//         setState(() {
//           _duration = duration;
//         });
//       }
//     });
//
//     // Listen to position changes
//     _audioPlayer.onPositionChanged.listen((Duration position) {
//       if (mounted) {
//         setState(() {
//           _position = position;
//         });
//       }
//     });
//
//     // Listen to completion
//     _audioPlayer.onPlayerComplete.listen((_) {
//       if (mounted) {
//         setState(() {
//           _isPlaying = false;
//           _position = Duration.zero;
//         });
//       }
//     });
//   }
//
//   Future<void> _playPauseAudio() async {
//     try {
//       if (_isPlaying) {
//         await _audioPlayer.pause();
//       } else {
//         setState(() {
//           _isLoading = true;
//         });
//         await _audioPlayer.play(AssetSource('Nyatapola.wav'));
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       // Handle error - show snackbar
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error playing audio: ${e.toString()}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//   Future<void> _stopAudio() async {
//     await _audioPlayer.stop();
//     setState(() {
//       _position = Duration.zero;
//     });
//   }
//
//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
//   }
//
//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.softGray,
//       appBar: AppBar(
//         backgroundColor: AppColors.primaryBrown,
//         title: Text(
//           widget.place.name,
//           style: TextStyle(
//             fontFamily: 'Cinzel', // Make sure this font is declared in pubspec.yaml
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.white, // White text color
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Image.asset(
//               widget.place.image,
//               width: double.infinity,
//               height: 250,
//               fit: BoxFit.cover,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.place.name,
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.textDark,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Icon(Icons.star, color: AppColors.goldAccent),
//                       SizedBox(width: 5),
//                       Text(
//                         widget.place.rating.toString(),
//                         style: TextStyle(color: AppColors.textLight),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     widget.place.description,
//                     style: TextStyle(fontSize: 16, color: AppColors.textDark),
//                   ),
//                   SizedBox(height: 20),
//                   Wrap(
//                     spacing: 10,
//                     children: widget.place.tags
//                         .map((tag) => Chip(
//                       label: Text(tag),
//                       backgroundColor:
//                       AppColors.primaryBrown.withOpacity(0.1),
//                     ))
//                         .toList(),
//                   ),
//                   SizedBox(height: 30),
//
//
//
//                   // Buttons Row
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: ElevatedButton.icon(
//                           onPressed: () {
//                             // TODO: Start AR Experience
//                           },
//                           icon: Icon(Icons.view_in_ar),
//                           label: Text("AR Experience"),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primaryBrown,
//                             foregroundColor: Colors.white,
//                             padding: EdgeInsets.symmetric(vertical: 14),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: ElevatedButton.icon(
//                           onPressed: _isLoading ? null : _playPauseAudio,
//                           icon: _isLoading
//                               ? SizedBox(
//                             width: 16,
//                             height: 16,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           )
//                               : Icon(_isPlaying ? Icons.pause : Icons.play_circle),
//                           label: Text(_isPlaying ? "Pause Guide" : "Audio Guide"),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primaryBrown,
//                             foregroundColor: Colors.white,
//                             padding: EdgeInsets.symmetric(vertical: 14),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/place.dart';
import '../utils/colors.dart';

class PlaceDetailPage extends StatefulWidget {
  final Place place;

  const PlaceDetailPage({required this.place});

  @override
  _PlaceDetailPageState createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isLoading = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();
  }

  void _setupAudioPlayer() {
    // Listen to player state changes
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
          _isLoading = false; // We'll handle loading state differently
        });
      }
    });

    // Listen to duration changes
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      if (mounted) {
        setState(() {
          _duration = duration;
        });
      }
    });

    // Listen to position changes
    _audioPlayer.onPositionChanged.listen((Duration position) {
      if (mounted) {
        setState(() {
          _position = position;
        });
      }
    });

    // Listen to completion
    _audioPlayer.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _position = Duration.zero;
        });
      }
    });
  }

  Future<void> _playPauseAudio() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        setState(() {
          _isLoading = true;
        });
        await _audioPlayer.play(AssetSource('Nyatapola.wav'));
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error - show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error playing audio: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _position = Duration.zero;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softGray,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBrown,
        title: Text(
          widget.place.name,
          style: TextStyle(
            fontFamily: 'Cinzel', // Make sure this font is declared in pubspec.yaml
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // White text color
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              widget.place.image,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.place.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.star, color: AppColors.goldAccent),
                      SizedBox(width: 5),
                      Text(
                        widget.place.rating.toString(),
                        style: TextStyle(color: AppColors.textLight),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.place.description,
                    style: TextStyle(fontSize: 16, color: AppColors.textDark),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    children: widget.place.tags
                        .map((tag) => Chip(
                      label: Text(tag),
                      backgroundColor:
                      AppColors.primaryBrown.withOpacity(0.1),
                    ))
                        .toList(),
                  ),
                  SizedBox(height: 30),



                  // Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Show AR Experience message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.view_in_ar,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text('Starting AR Experience...'),
                                  ],
                                ),
                                backgroundColor: AppColors.primaryBrown,
                                duration: Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.view_in_ar),
                          label: Text("AR Experience"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBrown,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _isLoading ? null : _playPauseAudio,
                          icon: _isLoading
                              ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                              : Icon(_isPlaying ? Icons.pause : Icons.play_circle),
                          label: Text(_isPlaying ? "Pause Guide" : "Audio Guide"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBrown,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}