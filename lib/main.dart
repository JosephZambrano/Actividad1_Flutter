import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Actividad 1 - App Personal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
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

  // Lista de las diferentes secciones de la app
  final List<Widget> _widgetOptions = <Widget>[
    const ProfileSection(),
    const GallerySection(),
    const BlogSection(),
    const PetSection(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi App Personal'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Yo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: 'Galería',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Mascota',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// Wiget para mostrar una colección de imágenes
class ImageCollection extends StatelessWidget {
  final String title;
  final List<String> imageUrls;

  const ImageCollection({super.key, required this.title, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: imageUrls[index].startsWith('http')
                      ? Image.network(
                          imageUrls[index],
                          width: 250,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 250,
                              color: Colors.grey[200],
                              child: const Center(child: CircularProgressIndicator()),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 250,
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image, size: 50),
                          ),
                        )
                      : Image.asset(
                          imageUrls[index],
                          width: 250,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 250,
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image, size: 50),
                          ),
                        ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Sección "Yo" (Perfil)
class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(''),
          ),
          SShift(height: 20),
          Text('Joseph Zambrano', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('Ing. en Sistemas Inteligentes', style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }
}


class SShift extends StatelessWidget {
  final double height;
  const SShift({super.key, required this.height});
  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}

// Sección Galería
class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ImageCollection(
          title: 'Viajes Recientes',
          imageUrls: [
            '',
            '',
            '',
          ],
        ),
        ImageCollection(
          title: '',
          imageUrls: [
            '',
            '',
            '',
          ],
        ),
        ImageCollection(
          title: 'Pasatiempos',
          imageUrls: [
            '',
            '',
            '',
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

// Sección Blog (Placeholder)
class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(12),
          child: ListTile(
            leading: const Icon(Icons.book, size: 40, color: Colors.blue),
            title: Text('${index + 1}'),
            subtitle: const Text(''),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        );
      },
    );
  }
}

// Sección Mascota
class PetSection extends StatelessWidget {
  const PetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ImageCollection(
          title: 'Dothy',
          imageUrls: [
            'assets/pets/dothy/dothy1.jpg',
            'assets/pets/dothy/dothy2.jpg',
          ],
        ),
        ImageCollection(
          title: 'Kira',
          imageUrls: [
            'assets/pets/kira/kira1.jpg',
            'assets/pets/kira/kira2.jpg',
            'assets/pets/kira/kira3.jpg',
          ],
        ),
        ImageCollection(
          title: 'Chocolate',
          imageUrls: [
            'assets/pets/chocolate/choc1.jpg',
            'assets/pets/chocolate/choc2.jpg',
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
