import 'package:flutter/material.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  // 0 = Radio stations, 1 = Reciters
  int _selectedTab = 0;

  // TODO: replace with your real station list (name + stream URL)
  final List<String> _radioStations = const [
    'Radio Ibrahim Al-Akdar',
    'Radio Al-Qaria Yassen',
    'Radio Ahmed Al-trabulsi',
    'Radio Addokali Mohammad Alalim',
  ];

  // TODO: replace with your real reciters list (name + stream URL)
  final List<String> _reciters = const [
    'Ibrahim Al-Akdar',
    'Akram Alalaqmi',
    'Majed Al-Enezi',
    'Malik shaibat Alhamed',
  ];

  // Tracks which item index is currently "playing" (UI only for now).
  // Reset when switching between Radio / Reciters.
  int? _playingIndex;
  final Set<int> _mutedIndexes = {};

  List<String> get _currentList => _selectedTab == 0 ? _radioStations : _reciters;

  void _switchTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
      _playingIndex = null; // stop "playback" state when switching lists
    });
  }

  void _togglePlay(int index) {
    setState(() {
      _playingIndex = _playingIndex == index ? null : index;
      // TODO: hook up real audio playback here (e.g. just_audio / audioplayers)
      // if (_playingIndex == index) player.play(streamUrl) else player.stop();
    });
  }

  void _toggleMute(int index) {
    setState(() {
      if (_mutedIndexes.contains(index)) {
        _mutedIndexes.remove(index);
      } else {
        _mutedIndexes.add(index);
      }
      // TODO: hook up real mute/volume control on your audio player
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/radio_logo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          _buildToggle(),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _currentList.length,
              itemBuilder: (context, index) {
                final isPlaying = _playingIndex == index;
                final isMuted = _mutedIndexes.contains(index);
                return _RadioCard(
                  title: _currentList[index],
                  isPlaying: isPlaying,
                  isMuted: isMuted,
                  onPlayTap: () => _togglePlay(index),
                  onMuteTap: () => _toggleMute(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          // dark bar behind the toggle, matching the reference design
          color: const Color(0xFF2A211B),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Expanded(child: _toggleButton('Radio', 0)),
            Expanded(child: _toggleButton('Reciters', 1)),
          ],
        ),
      ),
    );
  }

  Widget _toggleButton(String label, int index) {
    final bool selected = _selectedTab == index;
    return GestureDetector(
      onTap: () => _switchTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          // selected tab gets a light/cream pill; unselected stays flat
          color: selected ? const Color(0xFFF3E3BE) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? const Color(0xFF2A211B) : Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _RadioCard extends StatelessWidget {
  final String title;
  final bool isPlaying;
  final bool isMuted;
  final VoidCallback onPlayTap;
  final VoidCallback onMuteTap;

  const _RadioCard({
    required this.title,
    required this.isPlaying,
    required this.isMuted,
    required this.onPlayTap,
    required this.onMuteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFD9B36C),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2A12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // decorative waveform placeholder — replace with a real
          // audio-waveform widget once playback is wired up
          if (isPlaying) _WaveformPlaceholder(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onPlayTap,
                icon: Icon(
                  isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                  color: const Color(0xFF3E2A12),
                  size: 32,
                ),
              ),
              IconButton(
                onPressed: onMuteTap,
                icon: Icon(
                  isMuted ? Icons.volume_off : Icons.volume_up,
                  color: const Color(0xFF3E2A12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WaveformPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: List.generate(24, (i) {
          final heights = [8.0, 16.0, 22.0, 12.0, 26.0, 10.0];
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              height: heights[i % heights.length],
              color: const Color(0xFF3E2A12),
            ),
          );
        }),
      ),
    );
  }
}