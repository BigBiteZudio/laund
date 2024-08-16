import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessDetailsPagess extends StatefulWidget {
  const BusinessDetailsPagess({super.key});

  @override
  _BusinessDetailsPagessState createState() => _BusinessDetailsPagessState();
}

class _BusinessDetailsPagessState extends State<BusinessDetailsPagess> {
  bool isLiked = false;
  bool isDisliked = false;
  int selectedIndex = 0;
  List<Widget> tabs = [
    OverviewTab(),
    ReviewsTab(),
    ServicesTab(),
    PhotoVideo(),
  ];

  List<String> tabTitles = ["Overview", "Reviews", "Services", "Photos"];
  List<Map<String, dynamic>> businessHours = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Stellar Dry Clean & Premium Laundry',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.thumb_up : Icons.thumb_up_off_alt,
                      color: isLiked ? Colors.blue : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                        if (isLiked) {
                          isDisliked = false;
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      isDisliked ? Icons.thumb_down : Icons.thumb_down_off_alt,
                      color: isDisliked ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isDisliked = !isDisliked;
                        if (isDisliked) {
                          isLiked = false;
                        }
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: 3.7,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 24.0,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(width: 8),
                  const Text('3.7', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  const Text('17 ratings'),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Ramanathapuram, Coimbatore'),
              const SizedBox(height: 8),
              const Text('Laundry Services • 5 Years in Business'),
              const SizedBox(height: 8),
              const Text('97 enquiries answered'),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.access_time, color: Colors.green),
                  SizedBox(width: 4),
                  Text(
                    'Open Now: until 7:00 pm',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              const Divider(height: 32, thickness: 1),

              // Business Hours Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Business Hours',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, color: Colors.blue),
                    onPressed: () => _showBusinessHoursBottomSheet(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...businessHours.map((hours) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(hours['days']),
                      Text(hours['time']),
                    ],
                  ),
                );
              }).toList(),

              const Divider(height: 32, thickness: 1),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.phone, color: Colors.blue),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.directions, color: Colors.blue),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.blue),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Enquire Now'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
              const SizedBox(height: 16),

              // Custom Tab Bar
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(tabTitles.length, (index) {
                    return buildTabItem(index, tabTitles[index]);
                  }),
                ),
              ),
              const SizedBox(height: 16),
              tabs[selectedIndex],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabItem(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selectedIndex == index ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selectedIndex == index ? Colors.white : Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showBusinessHoursBottomSheet(BuildContext context) {
    String selectedDays = "";
    String selectedTime = "";

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Working Days',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: selectedDays,
                    isExpanded: true,
                    items: <String>[
                      'Monday - Friday',
                      'Monday - Saturday',
                      'Monday - Sunday',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDays = newValue ?? '';
                      });
                    },
                    hint: const Text('Select Days'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Select Timing',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'From',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            selectedTime = value + ' - ' + selectedTime.split(' - ')[1];
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'To',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            selectedTime = selectedTime.split(' - ')[0] + ' - ' + value;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          businessHours.add({
                            'days': selectedDays,
                            'time': selectedTime,
                          });
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Add'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class OverviewTab extends StatefulWidget {
  @override
  _OverviewTabState createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  final String address = "123 Main Street, Ramanathapuram, Coimbatore";
  final String googleMapsUrl =
      "https://www.google.com/maps/search/?api=1&query=123+Main+Street,+Ramanathapuram,+Coimbatore";

  // Selected date and time variables
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  // Business hours list
  List<Map<String, String>> businessHours = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? selectedStartTime : selectedEndTime,
    );
    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          selectedStartTime = pickedTime;
        } else {
          selectedEndTime = pickedTime;
        }
      });
    }
  }

  void _addBusinessHours() {
    final String day = DateFormat('EEEE').format(selectedDate);
    final String startTime = selectedStartTime.format(context);
    final String endTime = selectedEndTime.format(context);

    setState(() {
      businessHours.add({
        'day': day,
        'hours': '$startTime - $endTime',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Business Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce commodo libero ac justo facilisis ultricies.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Text(
            'Address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            address,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () async {
              if (await canLaunch(googleMapsUrl)) {
                await launch(googleMapsUrl);
              } else {
                throw 'Could not open the map.';
              }
            },
            icon: const Icon(Icons.map),
            label: const Text('Get Directions'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Select Business Hours',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: const Text('Select Date'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => _selectTime(context, true),
            child: const Text('Select Start Time'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => _selectTime(context, false),
            child: const Text('Select End Time'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _addBusinessHours,
            child: const Text('Add Business Hours'),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: businessHours.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(businessHours[index]['day']!),
                subtitle: Text(businessHours[index]['hours']!),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ReviewsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('John Doe'),
          subtitle: const Text('Great service, highly recommend!'),
          trailing: RatingBarIndicator(
            rating: 4.5,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
        ),
        ListTile(
          title: const Text('Jane Smith'),
          subtitle: const Text('Reasonable prices and friendly staff.'),
          trailing: RatingBarIndicator(
            rating: 4.0,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}

class ServicesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text('Dry Cleaning'),
          subtitle: Text('High-quality dry cleaning for your garments.'),
        ),
        ListTile(
          title: Text('Laundry'),
          subtitle: Text('Complete laundry services including wash and fold.'),
        ),
        ListTile(
          title: Text('Alterations'),
          subtitle: Text('Expert alterations and tailoring services.'),
        ),
      ],
    );
  }
}



class PhotoVideo extends StatefulWidget {
  @override
  _PhotoVideoState createState() => _PhotoVideoState();
}

class _PhotoVideoState extends State<PhotoVideo> {
  final List<File> _mediaFiles = [];
  final ImagePicker _picker = ImagePicker();
  File? _selectedMediaFile;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedMediaFile = File(pickedFile.path);
      _showPreviewDialog();
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedMediaFile = File(pickedFile.path);
      _showPreviewDialog();
    }
  }

  void _showPreviewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final isVideo = _selectedMediaFile!.path.endsWith('.mp4') || _selectedMediaFile!.path.endsWith('.mov');
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: 400,
            height: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // The header with title and close button
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Media Preview', style: TextStyle(fontSize: 18)),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                // The main content with preview of selected media
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isVideo
                          ? const Icon(Icons.video_library, size: 100)
                          : Image.file(
                        _selectedMediaFile!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _mediaFiles.add(_selectedMediaFile!);
                            Navigator.of(context).pop(); // Close the dialog
                          });
                        },
                        child: const Text('Upload'),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Only JPG, JPEG, PNG files are allowed for images. MP4, MOV files are allowed for videos.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _viewMedia(File mediaFile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullscreenMediaView(mediaFile: mediaFile),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Photos & Videos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            height: 50,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.add_photo_alternate_outlined),
              label: const Text('Add Photo'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.grey, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 50,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _pickVideo,
              icon: const Icon(Icons.video_call),
              label: const Text('Add Video'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.grey, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            itemCount: _mediaFiles.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              final mediaFile = _mediaFiles[index];
              final isVideo = mediaFile.path.endsWith('.mp4') || mediaFile.path.endsWith('.mov');

              return GestureDetector(
                onTap: () => _viewMedia(mediaFile),
                child: Stack(
                  children: [
                    Image.file(
                      mediaFile,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    if (isVideo)
                      const Center(
                        child: Icon(
                          Icons.play_circle_outline,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FullscreenMediaView extends StatefulWidget {
  final File mediaFile;

  const FullscreenMediaView({required this.mediaFile});

  @override
  _FullscreenMediaViewState createState() => _FullscreenMediaViewState();
}

class _FullscreenMediaViewState extends State<FullscreenMediaView> {
  late VideoPlayerController _controller;
  bool _isVideo = false;

  @override
  void initState() {
    super.initState();
    _isVideo = widget.mediaFile.path.endsWith('.mp4') || widget.mediaFile.path.endsWith('.mov');
    if (_isVideo) {
      _controller = VideoPlayerController.file(widget.mediaFile)
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
        });
    }
  }

  @override
  void dispose() {
    if (_isVideo) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: _isVideo
            ? _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : const CircularProgressIndicator()
            : Image.file(widget.mediaFile),
      ),
    );
  }
}


