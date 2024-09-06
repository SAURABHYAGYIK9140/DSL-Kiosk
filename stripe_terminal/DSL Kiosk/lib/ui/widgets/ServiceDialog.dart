import 'package:dsl_kiosk/controllers/ServiceController.dart';
import 'package:dsl_kiosk/models/Service.dart';
import 'package:flutter/material.dart';

class ServiceDescriptionDialog extends StatefulWidget {
  final Service service;
  final bool isSelected;
  final ServiceController serviceController;
  final Function(Service service, bool isSelected) onSelect;

  ServiceDescriptionDialog({
    required this.service,
    required this.isSelected,
    required this.onSelect,
    required this.serviceController,
  });

  @override
  _ServiceDescriptionDialogState createState() =>
      _ServiceDescriptionDialogState();
}

class _ServiceDescriptionDialogState extends State<ServiceDescriptionDialog> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 10,
            top: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close),
            ),
          ),
          Container(
            height: _isExpanded ? 700 : 350,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.service.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: SingleChildScrollView(
                    child: Container(
                      child: _isExpanded
                          ? SingleChildScrollView(
                              child: Container(
                                height: 400,
                                child: Text(
                                  maxLines: _isExpanded ? null : 3,
                                  widget.service.description,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.service.description,
                                  maxLines: _isExpanded ? null : 3,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'more...',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.service.duration.toString() + " min",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  '£' + widget.service.price.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.04),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                        ),
                        backgroundColor: Colors.black,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                      ),
                      onPressed: () {

                        setState(() {
                          // print("selectedServices"+widget.selectedServices.toString());
                          if (widget.isSelected) {
                            widget.serviceController.selectedServices.removeWhere((s) => s.id == widget.service.id);
                          } else {
                            widget.serviceController.selectedServices.add(widget.service);
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        widget.isSelected
                            ? "Remove from booking"
                            : "Add to booking",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                    ),
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
