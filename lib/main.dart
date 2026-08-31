import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ACTIVIDAD 1',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A237E),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = [
      const ProfileSection(),
      const PetSection(),
    ];

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              title: Text(
                'Actividad 1',
                style: GoogleFonts.orbitron(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white.withOpacity(0.05),
              elevation: 0,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Fondo Premium
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xDF0F2027),
                  Color(0xFF203A43),
                  Color(0xFF2C5374),
                ],
              ),
            ),
          ),
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent.withOpacity(0.1),
              ),
            ),
          ),
          SafeArea(
            child: IndexedStack(
              index: _selectedIndex,
              children: widgetOptions,
            ),
          ),
        ],
      ),
      bottomNavigationBar: GlassNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class GlassNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const GlassNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.person_outline, Icons.person, 'Yo', 0),
                _buildNavItem(Icons.pets_outlined, Icons.pets, 'Mascotas', 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, IconData activeIcon, String label, int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? activeIcon : icon,
            color: isSelected ? Colors.blueAccent : Colors.white70,
            size: 28,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blueAccent : Colors.white70,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// Modelo para una foto de mascota con descripción
class PetPhoto {
  final String path;
  final String description;

  PetPhoto({required this.path, this.description = ''});
}

class ImageCollection extends StatelessWidget {
  final String title;
  final List<PetPhoto> photos;

  const ImageCollection({super.key, required this.title, required this.photos});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Text(
            title.toUpperCase(),
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: Colors.blueAccent[100],
            ),
          ),
        ),
        SizedBox(
          height: 250, // Aumentado para dejar espacio a la descripción
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final photo = photos[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: _buildImage(photo.path),
                      ),
                    ),
                    if (photo.description.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: 280,
                          child: Text(
                            photo.description,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white70,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildImage(String url) {
    try {
      if (url.startsWith('http')) {
        return Image.network(url, fit: BoxFit.cover);
      } else if (url.startsWith('assets/')) {
        return Image.asset(url, fit: BoxFit.cover);
      } else {
        return Image.file(File(url), fit: BoxFit.cover);
      }
    } catch (e) {
      return Container(
        color: Colors.white10,
        child: const Icon(Icons.broken_image, color: Colors.white24, size: 50),
      );
    }
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 90,
              backgroundColor: Colors.black,
              backgroundImage: AssetImage('assets/img/yo/WhatsApp Image 2026-08-23 at 18.54.09.jpeg'),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'JOSEPH ZAMBRANO',
            style: GoogleFonts.montserrat(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
            ),
            child: Text(
              'Ing. en Sistemas Inteligentes',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.blueAccent[100],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PetSection extends StatefulWidget {
  const PetSection({super.key});

  @override
  State<PetSection> createState() => _PetSectionState();
}

class _PetSectionState extends State<PetSection> {
  final Map<String, List<PetPhoto>> _petCollections = {
    'Dothy': [
      PetPhoto(path: 'assets/pets/dothy/dothy1.jpg', description: 'Mirando por la ventana'),
      PetPhoto(path: 'assets/pets/dothy/dothy2.jpg', description: 'Siesta profunda')
    ],
    'Kira': [
      PetPhoto(path: 'assets/pets/kira/kira1.jpg', description: 'Jugando en el parque'),
      PetPhoto(path: 'assets/pets/kira/kira2.jpg', description: 'Mi mejor ángulo'),
      PetPhoto(path: 'assets/pets/kira/kira3.jpg', description: 'Esperando premios')
    ],
    'Chocolate': [
      PetPhoto(path: 'assets/pets/chocolate/choc1.jpg', description: 'Paseo dominical'),
      PetPhoto(path: 'assets/pets/chocolate/choc2.jpg', description: 'Haciendo travesuras')
    ],
  };

  final ImagePicker _picker = ImagePicker();

  Future<void> _addPhoto() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      // Paso 1: Seleccionar Mascota
      String? selectedPet = await showGeneralDialog<String>(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        pageBuilder: (context, anim1, anim2) => Container(),
        transitionBuilder: (context, anim1, anim2, child) {
          return Transform.scale(
            scale: anim1.value,
            child: Opacity(
              opacity: anim1.value,
              child: SimpleDialog(
                backgroundColor: const Color(0xFF203A43),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                title: Text('Selecciona Colección', style: GoogleFonts.poppins(color: Colors.white)),
                children: _petCollections.keys.map((String petName) {
                  return SimpleDialogOption(
                    onPressed: () => Navigator.pop(context, petName),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(petName, style: const TextStyle(color: Colors.white70, fontSize: 16)),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      );

      if (selectedPet == null) return;

      // Paso 2: Pedir Descripción
      final TextEditingController descController = TextEditingController();
      String? description = await showGeneralDialog<String>(
        context: context,
        barrierDismissible: false,
        barrierLabel: '',
        pageBuilder: (context, anim1, anim2) => Container(),
        transitionBuilder: (context, anim1, anim2, child) {
          return Transform.scale(
            scale: anim1.value,
            child: Opacity(
              opacity: anim1.value,
              child: AlertDialog(
                backgroundColor: const Color(0xFF203A43),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                title: Text('Añadir Descripción', style: GoogleFonts.poppins(color: Colors.white)),
                content: TextField(
                  controller: descController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Escribe algo sobre la foto...',
                    hintStyle: TextStyle(color: Colors.white38),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, descController.text),
                    child: const Text('GUARDAR', style: TextStyle(color: Colors.blueAccent)),
                  ),
                ],
              ),
            ),
          );
        },
      );

      if (description != null) {
        setState(() {
          _petCollections[selectedPet]!.add(PetPhoto(path: image.path, description: description));
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Has subido una nueva foto correctamente'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Parece que ocurrió un error'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.only(top: 20, bottom: 100),
        children: _petCollections.entries.map((entry) {
          return ImageCollection(
            title: entry.key,
            photos: entry.value,
          );
        }).toList(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton.extended(
          onPressed: _addPhoto,
          backgroundColor: Colors.blueAccent,
          icon: const Icon(Icons.add_a_photo, color: Colors.white),
          label: Text('AÑADIR MOMENTO', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }
}
