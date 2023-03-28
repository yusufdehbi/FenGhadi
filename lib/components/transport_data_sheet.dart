import 'package:fen_ghadi/components/item_list_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/transport_data.dart';
import '../utils/fen_ghadi_icons_icons.dart';
import '../utils/style.dart';

class TransportDataSheet extends StatelessWidget {
  final List<TransportData> transportData;
  const TransportDataSheet({super.key, required this.transportData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: transportData[0].color,
      child: Column(children: [
        Expanded(
            flex: 2,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bus Station Medina',
                      style: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.white),
                    ),
                    Icon(
                      transportData[0].icon,
                      size: 70,
                      color: secondaryColor.withOpacity(0.2),
                    ),
                  ],
                ))),
        Expanded(
          flex: 4,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Column(
                children: transportData
                    .map((data) => ItemListSheet(
                        name: data.name,
                        price: data.price,
                        duration: data.duration))
                    .toList(),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
