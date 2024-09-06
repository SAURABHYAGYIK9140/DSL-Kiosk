import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ProfessionalController.dart';
import '../../utils/Colors.dart';

class CalendarAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CalendarAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(148.0);

  @override
  State<CalendarAppBar> createState() => _CalendarAppBarState();
}

class _CalendarAppBarState extends State<CalendarAppBar> {
  late int selectedIndex;
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    selectedIndex = now.day - 1; // Select current day
    _scrollController = ScrollController(
      initialScrollOffset: selectedIndex * 60.0, // Approximate item width
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProfessionalController controller = Get.put(ProfessionalController());

    return SingleChildScrollView(
      child: Container(
        color: Colors.white, // Add a background color to help with debugging
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              controller: _scrollController,
              child: Row(
                children: List.generate(
                  lastDayOfMonth.day,
                      (index) {
                    final currentDate = DateTime(now.year, now.month, index + 1);
                    final dayName = DateFormat('E').format(currentDate); // Mon, Tue, etc.
                    final dayNumber = DateFormat('d').format(currentDate); // 27
                    final monthName = DateFormat('MMMM').format(currentDate); // June
      
                    return Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? 16.0 : 8.0, right: 8.0),
                      child: GestureDetector(
                        onTap: () => setState(
                              () {
                                String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
                                controller.get_latter_slots(controller.profession_id, formattedDate);
                            selectedIndex = index;
                          },
                        ),
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: selectedIndex == index
                                ? buttoncolor2
                                : Colors.transparent,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 42.0,
                                width: 42.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                               
                                  borderRadius: BorderRadius.circular(44.0),
                                ),
                                child: Text(
                                  dayName.substring(0, 3), // First three letters of day
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 3.0),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    dayNumber, // Day number
                                    style:  TextStyle(
                                      fontSize: 19.0,
                                      color: selectedIndex == index
                                          ? Colors.white
                                          : Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    monthName, // Month name
                                    style:  TextStyle(
                                      fontSize: 16.0,
                                      color: selectedIndex == index
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                height: 2.0,
                                width: 28.0,
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
