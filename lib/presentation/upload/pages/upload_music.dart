import 'package:flutter/material.dart';

class UploadMusicPage extends StatefulWidget {
  const UploadMusicPage({Key? key}) : super(key: key);

  @override
  State<UploadMusicPage> createState() => _UploadMusicPageState();
}

class _UploadMusicPageState extends State<UploadMusicPage> {
  final _formKey = GlobalKey<FormState>();
  String? _title, _artist, _album, _genre;
  String? _audioFile, _coverImage;

  void _pickAudio() async {
    // TODO: Implement file picker
    setState(() {
      _audioFile = 'audio_sample.mp3';
    });
  }

  void _pickImage() async {
    // TODO: Implement image picker
    setState(() {
      _coverImage = 'cover_sample.jpg';
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: Implement upload logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Music uploaded (placeholder)!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF232323),
        elevation: 0,
        title:
            const Text('Upload Music', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF181818),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Song Title'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter song title' : null,
                onSaved: (v) => _title = v,
              ),
              const SizedBox(height: 16),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Artist'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter artist' : null,
                onSaved: (v) => _artist = v,
              ),
              const SizedBox(height: 16),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Album'),
                onSaved: (v) => _album = v,
              ),
              const SizedBox(height: 16),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Genre'),
                onSaved: (v) => _genre = v,
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF43E97B),
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: _pickAudio,
                    icon: const Icon(Icons.audiotrack),
                    label: Text(
                        _audioFile == null ? 'Pick Audio File' : _audioFile!),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF38F9D7),
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: Text(_coverImage == null
                        ? 'Pick Cover Image'
                        : _coverImage!),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                  ),
                  onPressed: _submit,
                  child: const Text('Upload',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: const Color(0xFF232323),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF43E97B)),
      ),
    );
  }
}
