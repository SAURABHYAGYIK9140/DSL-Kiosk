import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dsl_kiosk/controllers/ServiceController.dart';
import '../../controllers/ProfessionalController.dart';
import '../../utils/route_pages/page_name.dart';
import 'package:intl/intl.dart';

class ProfessionalSelectionScreen extends StatefulWidget {
  @override
  _ProfessionalSelectionScreenState createState() => _ProfessionalSelectionScreenState();
}

class _ProfessionalSelectionScreenState extends State<ProfessionalSelectionScreen> {
  int _selectedIndex = -1; // -1 means no selection
  final ProfessionalController controller = Get.put(ProfessionalController());
  final ServiceController serviceController = Get.put(ServiceController());

  void _onTileTap(int index) {

    print("object"+index.toString());
    setState(() {
      _selectedIndex = index;
    });
    if(index>0)
    {
      index=  index-1;
    }
    print("object"+index.toString());
    // print("Index out of bounds"+serviceController.subservices.length.toString());

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    DateTime tomorrow = now.add(Duration(days: 1));
    String tomorrowformattedDate = DateFormat('yyyy-MM-dd').format(tomorrow);

      controller.profession_id = controller.professionals.value[index].id.toString();
      // print("Selected Service ID: " + serviceController.subservices[index].id);
      controller.get_next_slots(controller.profession_id,formattedDate);
      controller.get_latter_slots(controller.profession_id, tomorrowformattedDate);
      Get.toNamed(MyPagesName.Chooseappointmenttime);

  }
@override
  void initState() {
    // TODO: implement initState
  controller.fetchProfessionals(serviceController.selectedcatis.value);
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Professional'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: OptionTile(
                      icon: Icons.group,
                      title: 'Any Professional',
                      subtitle: 'For maximum availability',
                      isSelected: _selectedIndex == 0,
                      onTap: () => _onTileTap(0),
                    ),
                  ),
                ],
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.professionals.length,
                    itemBuilder: (context, index) {
                      return ProfessionalTile(
                        imageUrl: controller.professionals[index].id.toString(),
                        name: controller.professionals[index].proName,
                        specialty: controller.professionals[index].proProfession,
                        pro_designation: controller.professionals[index].proDesignation,
                        rating: double.parse(controller.professionals[index].rating.toString()),
                        isSelected: _selectedIndex == index + 1,
                        onTap: () => _onTileTap(index + 1),
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  OptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.black54),
            SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (subtitle.isNotEmpty)
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
          ],
        ),
      ),
    );
  }
}

class ProfessionalTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String pro_designation;
  final String specialty;
  final double rating;
  final bool isSelected;
  final VoidCallback onTap;

  ProfessionalTile({
    required this.imageUrl,
    required this.name,
    required this.specialty,
    required this.pro_designation,
    required this.rating,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        SizedBox(width: 4),
                        Text(
                          '$rating',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              specialty,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              pro_designation,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
