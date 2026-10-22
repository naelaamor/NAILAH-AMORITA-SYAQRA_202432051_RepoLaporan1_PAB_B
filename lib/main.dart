import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// =====================================================
// MODEL DATA
// =====================================================

class Pet {
  final String name;
  final String type;
  final int age;
  final double weight;
  final bool vaccinated;
  final String favoriteFood;
  final String favoriteActivity;
  final String healthStatus;
  final Color color;

  const Pet({
    required this.name,
    required this.type,
    required this.age,
    required this.weight,
    required this.vaccinated,
    required this.favoriteFood,
    required this.favoriteActivity,
    required this.healthStatus,
    required this.color,
  });
}

// =====================================================
// MY APP
// =====================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pet Care & Profile',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8E7CC3),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8F2),
      ),
      home: const LayarUtama(),
    );
  }
}

// =====================================================
// LAYAR UTAMA
// =====================================================

class LayarUtama extends StatefulWidget {
  const LayarUtama({super.key});

  @override
  State<LayarUtama> createState() => _LayarUtamaState();
}

class _LayarUtamaState extends State<LayarUtama> {
  int _selectedIndex = 0;

  final List<Pet> _pets = [
    const Pet(
      name: 'Mochi',
      type: 'Persian Cat',
      age: 2,
      weight: 4.5,
      vaccinated: true,
      favoriteFood: 'Tuna & Chicken',
      favoriteActivity: 'Playing with toys',
      healthStatus: 'Healthy',
      color: Color(0xFFFFB6D2),
    ),
    const Pet(
      name: 'Coco',
      type: 'Golden Retriever',
      age: 3,
      weight: 22.0,
      vaccinated: true,
      favoriteFood: 'Chicken & Rice',
      favoriteActivity: 'Running outdoors',
      healthStatus: 'Healthy',
      color: Color(0xFFFFD68A),
    ),
    const Pet(
      name: 'Boba',
      type: 'Holland Lop',
      age: 1,
      weight: 1.8,
      vaccinated: false,
      favoriteFood: 'Carrot & Hay',
      favoriteActivity: 'Hopping around',
      healthStatus: 'Healthy',
      color: Color(0xFFC9B6FF),
    ),
    const Pet(
      name: 'Kiwi',
      type: 'Syrian Hamster',
      age: 1,
      weight: 0.15,
      vaccinated: false,
      favoriteFood: 'Seeds & Fruits',
      favoriteActivity: 'Running on wheel',
      healthStatus: 'Healthy',
      color: Color(0xFFAEDFF7),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        pets: _pets,
        onViewPets: () {
          setState(() {
            _selectedIndex = 1;
          });
        },
      ),
      MyPetsPage(
        pets: _pets,
        onPetAdded: (Pet pet) {
          setState(() {
            _pets.add(pet);
          });
        },
        onPetDeleted: (Pet pet) {
          setState(() {
            _pets.remove(pet);
          });
        },
      ),
      const CareTipsPage(),
      const AboutPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _getTitle(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFD8C4F1),
        foregroundColor: const Color(0xFF403152),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE6D9FF),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.pets_outlined),
            selectedIcon: Icon(Icons.pets),
            label: 'My Pets',
          ),
          NavigationDestination(
            icon: Icon(Icons.lightbulb_outline),
            selectedIcon: Icon(Icons.lightbulb),
            label: 'Tips',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 1:
        return 'My Pets';
      case 2:
        return 'Pet Care Tips';
      case 3:
        return 'About';
      default:
        return 'Pet Care & Profile';
    }
  }
}

// =====================================================
// HOME PAGE
// =====================================================

class HomePage extends StatelessWidget {
  final List<Pet> pets;
  final VoidCallback onViewPets;

  const HomePage({
    super.key,
    required this.pets,
    required this.onViewPets,
  });

  @override
  Widget build(BuildContext context) {
    final healthyPets =
        pets.where((pet) => pet.healthStatus == 'Healthy').length;

    final vaccinatedPets =
        pets.where((pet) => pet.vaccinated).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 900,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFE9D8FF),
                      Color(0xFFFFDCE8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.pets,
                        size: 48,
                        color: Color(0xFF8E6DB7),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Welcome to Pet Care & Profile!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF403152),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Keep your lovely pets information organized in one place.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF685B70),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // SUMMARY
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.pets,
                      title: 'My Pets',
                      value: '${pets.length}',
                      color: const Color(0xFFDCCBFF),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.favorite,
                      title: 'Healthy',
                      value: '$healthyPets',
                      color: const Color(0xFFFFC9D9),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.vaccines,
                      title: 'Vaccinated',
                      value: '$vaccinatedPets',
                      color: const Color(0xFFC8EFD9),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // INFORMATION CARD
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE2BE),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          color: Color(0xFFE68A36),
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Pets, Your Responsibility',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF403152),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'View your pets information and learn simple ways to keep them happy and healthy.',
                              style: TextStyle(
                                color: Color(0xFF706575),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onViewPets,
                  icon: const Icon(Icons.pets),
                  label: const Text('View My Pets'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8E7CC3),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// SUMMARY CARD
// =====================================================

class SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const SummaryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: const Color(0xFF554265),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color(0xFF403152),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF66596D),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// MY PETS PAGE
// =====================================================

class MyPetsPage extends StatelessWidget {
  final List<Pet> pets;
  final ValueChanged<Pet> onPetAdded;
  final ValueChanged<Pet> onPetDeleted;

  const MyPetsPage({
    super.key,
    required this.pets,
    required this.onPetAdded,
    required this.onPetDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1000,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Lovely Pets 🐾',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF403152),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${pets.length} pets in your collection',
                style: const TextStyle(
                  color: Color(0xFF766A79),
                ),
              ),

              const SizedBox(height: 18),

              // ADD PET BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final newPet = await showDialog<Pet>(
                      context: context,
                      builder: (context) {
                        return const AddPetDialog();
                      },
                    );

                    if (newPet != null) {
                      onPetAdded(newPet);
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Pet'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8E7CC3),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // EMPTY STATE
              if (pets.isEmpty)
                EmptyPetsState(
                  onAddPet: () async {
                    final newPet = await showDialog<Pet>(
                      context: context,
                      builder: (context) {
                        return const AddPetDialog();
                      },
                    );

                    if (newPet != null) {
                      onPetAdded(newPet);
                    }
                  },
                )
              else
                // RESPONSIVE GRID
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 1;

                    if (constraints.maxWidth >= 700) {
                      crossAxisCount = 3;
                    } else if (constraints.maxWidth >= 450) {
                      crossAxisCount = 2;
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      itemCount: pets.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 0.82,
                      ),
                      itemBuilder: (context, index) {
                        return PetCard(
                          pet: pets[index],
                          onDelete: () {
                            _showDeleteConfirmation(
                              context,
                              pets[index],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    Pet pet,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.delete_outline,
            color: Color(0xFFE57373),
            size: 35,
          ),
          title: const Text(
            'Delete Pet?',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Are you sure you want to remove ${pet.name} from your pet list?',
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                onPetDeleted(pet);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${pet.name} has been removed.',
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE57373),
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

// =====================================================
// EMPTY PETS STATE
// =====================================================

class EmptyPetsState extends StatelessWidget {
  final VoidCallback onAddPet;

  const EmptyPetsState({
    super.key,
    required this.onAddPet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE4D8EE),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 85,
            height: 85,
            decoration: const BoxDecoration(
              color: Color(0xFFF0E7FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.pets,
              size: 45,
              color: Color(0xFF9B83C6),
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'No pets yet 🐾',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF403152),
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Add your first pet to get started!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF766A79),
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton.icon(
            onPressed: onAddPet,
            icon: const Icon(Icons.add),
            label: const Text('Add My First Pet'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8E7CC3),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// PET CARD
// =====================================================

class PetCard extends StatelessWidget {
  final Pet pet;
  final VoidCallback onDelete;

  const PetCard({
    super.key,
    required this.pet,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: pet.color.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // PET ICON
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: pet.color.withOpacity(0.45),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.pets,
                size: 42,
                color: Color(0xFF725A86),
              ),
            ),

            const SizedBox(height: 6),

            // NAME
            Text(
              pet.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF403152),
              ),
            ),

            // TYPE
            Text(
              pet.type,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF7B6D80),
              ),
            ),

            const SizedBox(height: 7),

            // BASIC INFORMATION
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 5,
              runSpacing: 5,
              children: [
                PetMiniInfo(
                  icon: Icons.cake_outlined,
                  text: '${pet.age} yrs',
                ),
                PetMiniInfo(
                  icon: Icons.monitor_weight_outlined,
                  text: '${pet.weight} kg',
                ),
              ],
            ),

            const SizedBox(height: 7),

            // VACCINATION STATUS
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: pet.vaccinated
                    ? const Color(0xFFD7F2E2)
                    : const Color(0xFFFFE1E1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    pet.vaccinated
                        ? Icons.check_circle
                        : Icons.cancel,
                    size: 14,
                    color: pet.vaccinated
                        ? const Color(0xFF4E9A68)
                        : const Color(0xFFD66A6A),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    pet.vaccinated
                        ? 'Vaccinated'
                        : 'Not Vaccinated',
                    style: TextStyle(
                      fontSize: 10,
                      color: pet.vaccinated
                          ? const Color(0xFF4E795A)
                          : const Color(0xFF9B5A5A),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // VIEW DETAILS
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PetDetailPage(pet: pet);
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.visibility_outlined,
                  size: 16,
                ),
                label: const Text(
                  'Details',
                  style: TextStyle(fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: pet.color,
                  foregroundColor: const Color(0xFF403152),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),

            // DELETE
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete_outline,
                  size: 16,
                ),
                label: const Text(
                  'Delete',
                  style: TextStyle(fontSize: 12),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFD66A6A),
                  side: const BorderSide(
                    color: Color(0xFFF0B0B0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// PET MINI INFO
// =====================================================

class PetMiniInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const PetMiniInfo({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF4EFF8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 13,
            color: const Color(0xFF806B91),
          ),
          const SizedBox(width: 3),
          Text(
            text,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF5F5268),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// ADD PET DIALOG
// =====================================================

class AddPetDialog extends StatefulWidget {
  const AddPetDialog({super.key});

  @override
  State<AddPetDialog> createState() => _AddPetDialogState();
}

class _AddPetDialogState extends State<AddPetDialog> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _foodController = TextEditingController();
  final _activityController = TextEditingController();

  bool _vaccinated = false;

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _foodController.dispose();
    _activityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(
            Icons.pets,
            color: Color(0xFF8E7CC3),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text('Add New Pet'),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Pet Name',
                icon: Icons.badge_outlined,
              ),
              _buildTextField(
                controller: _typeController,
                label: 'Pet Type',
                icon: Icons.pets,
              ),
              _buildTextField(
                controller: _ageController,
                label: 'Age',
                icon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                controller: _weightController,
                label: 'Weight (kg)',
                icon: Icons.monitor_weight_outlined,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              _buildTextField(
                controller: _foodController,
                label: 'Favorite Food',
                icon: Icons.restaurant_outlined,
              ),
              _buildTextField(
                controller: _activityController,
                label: 'Favorite Activity',
                icon: Icons.sports_esports_outlined,
              ),

              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Vaccinated'),
                value: _vaccinated,
                activeColor: const Color(0xFF8E7CC3),
                onChanged: (value) {
                  setState(() {
                    _vaccinated = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _addPet,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8E7CC3),
            foregroundColor: Colors.white,
          ),
          child: const Text('Add Pet'),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please fill in this field';
          }
          return null;
        },
      ),
    );
  }

  void _addPet() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final int? age = int.tryParse(
      _ageController.text,
    );

    final double? weight = double.tryParse(
      _weightController.text,
    );

    if (age == null || weight == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter valid age and weight.',
          ),
        ),
      );
      return;
    }

    final newPet = Pet(
      name: _nameController.text.trim(),
      type: _typeController.text.trim(),
      age: age,
      weight: weight,
      vaccinated: _vaccinated,
      favoriteFood: _foodController.text.trim(),
      favoriteActivity: _activityController.text.trim(),
      healthStatus: 'Healthy',
      color: const Color(0xFFD6C8F5),
    );

    Navigator.pop(context, newPet);
  }
}

// =====================================================
// PET DETAIL PAGE
// =====================================================

class PetDetailPage extends StatelessWidget {
  final Pet pet;

  const PetDetailPage({
    super.key,
    required this.pet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${pet.name}\'s Profile'),
        backgroundColor: pet.color,
        foregroundColor: const Color(0xFF403152),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 800,
            ),
            child: Column(
              children: [
                // PROFILE HEADER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        pet.color.withOpacity(0.7),
                        const Color(0xFFFFEAF1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.pets,
                          size: 55,
                          color: Color(0xFF8E6DA8),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        pet.name,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF403152),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          pet.type,
                          style: const TextStyle(
                            color: Color(0xFF6C5780),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // BASIC INFO
                Row(
                  children: [
                    Expanded(
                      child: DetailInfoCard(
                        icon: Icons.cake_outlined,
                        title: 'Age',
                        value: '${pet.age} years',
                        color: const Color(0xFFE2D4FF),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DetailInfoCard(
                        icon: Icons.monitor_weight_outlined,
                        title: 'Weight',
                        value: '${pet.weight} kg',
                        color: const Color(0xFFFFE0A8),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DetailInfoCard(
                        icon: Icons.vaccines_outlined,
                        title: 'Vaccine',
                        value:
                            pet.vaccinated ? 'Done' : 'Not Yet',
                        color: const Color(0xFFCDEEDC),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                InfoCard(
                  icon: Icons.restaurant_outlined,
                  title: 'Favorite Food',
                  value: pet.favoriteFood,
                  color: const Color(0xFFFFDDBB),
                ),

                const SizedBox(height: 12),

                InfoCard(
                  icon: Icons.sports_esports_outlined,
                  title: 'Favorite Activity',
                  value: pet.favoriteActivity,
                  color: const Color(0xFFCDE8F8),
                ),

                const SizedBox(height: 12),

                InfoCard(
                  icon: Icons.favorite,
                  title: 'Health Status',
                  value: pet.healthStatus,
                  color: const Color(0xFFFFD3E0),
                ),

                const SizedBox(height: 18),

                // DESCRIPTION
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFEBDFFF),
                        Color(0xFFFFE2EE),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'A Little About This Pet 🐾',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF51405E),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${pet.name} is a ${pet.type.toLowerCase()} who enjoys ${pet.favoriteActivity.toLowerCase()} and loves ${pet.favoriteFood.toLowerCase()}.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          height: 1.5,
                          color: Color(0xFF6D6071),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // BACK BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back to My Pets'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8E7CC3),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================
// DETAIL INFO CARD
// =====================================================

class DetailInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const DetailInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xFF675277),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6E6174),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF403152),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// INFO CARD
// =====================================================

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6F587B),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF756778),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF403152),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// CARE TIPS PAGE
// =====================================================

class CareTipsPage extends StatelessWidget {
  const CareTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tips = [
      {
        'icon': Icons.restaurant,
        'title': 'Healthy Food',
        'description':
            'Give your pet nutritious food and provide clean drinking water every day.',
        'color': const Color(0xFFFFDDBB),
      },
      {
        'icon': Icons.cleaning_services,
        'title': 'Regular Grooming',
        'description':
            'Keep your pet clean and comfortable with regular grooming.',
        'color': const Color(0xFFE3D5FF),
      },
      {
        'icon': Icons.directions_run,
        'title': 'Stay Active',
        'description':
            'Give your pet enough time to play and exercise according to their needs.',
        'color': const Color(0xFFCDE8F8),
      },
      {
        'icon': Icons.favorite,
        'title': 'Health Check',
        'description':
            'Pay attention to changes in behavior and keep vaccinations up to date.',
        'color': const Color(0xFFFFD3E0),
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 850,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFDCCBFF),
                      Color(0xFFFFDDE8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.lightbulb,
                      size: 42,
                      color: Color(0xFF8E7CC3),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Simple Pet Care Tips',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF403152),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Small habits can make a big difference for your pet.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF6E6172),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              ...tips.map(
                (tip) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TipCard(
                    icon: tip['icon'] as IconData,
                    title: tip['title'] as String,
                    description: tip['description'] as String,
                    color: tip['color'] as Color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// TIP CARD
// =====================================================

class TipCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const TipCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF665273),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF403152),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF706474),
                      height: 1.4,
                    ),
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

// =====================================================
// ABOUT PAGE
// =====================================================

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800,
          ),
          child: Column(
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFD9C7FF),
                      Color(0xFFFFC9DC),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.pets,
                  size: 58,
                  color: Color(0xFF735B8B),
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'Pet Care & Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF403152),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'A simple Flutter application for organizing pet information.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF756879),
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 20),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      const Text(
                        'What can you do here?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF403152),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const AboutFeature(
                        icon: Icons.pets,
                        text: 'View your pet profiles',
                      ),
                      const AboutFeature(
                        icon: Icons.add_circle_outline,
                        text: 'Add a new pet',
                      ),
                      const AboutFeature(
                        icon: Icons.delete_outline,
                        text: 'Remove a pet from the list',
                      ),
                      const AboutFeature(
                        icon: Icons.favorite_border,
                        text: 'Check basic pet information',
                      ),
                      const AboutFeature(
                        icon: Icons.lightbulb_outline,
                        text: 'Read simple pet care tips',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0E7FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Made as a Flutter application project for learning widgets, layouts, state management, and responsive design.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF665773),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// ABOUT FEATURE
// =====================================================

class AboutFeature extends StatelessWidget {
  final IconData icon;
  final String text;

  const AboutFeature({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const SizedBox(width: 5),
          Icon(
            icon,
            color: const Color(0xFF8E7CC3),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF5F5268),
              ),
            ),
          ),
        ],
      ),
    );
  }
}