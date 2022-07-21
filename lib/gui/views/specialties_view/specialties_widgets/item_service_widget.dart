import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';
import 'package:mr_fix_expert/data/models/service/service_model.dart';

import '../specialties_controller.dart';

class ItemService extends StatelessWidget {
  const ItemService({
    Key? key,
    required this.service,
  }) : super(key: key);

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<UserProvider>().user;
    return InkWell(
      onTap: () => SpecialtiesController(context).toogleSpecialties(service.reference!),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                service.image ??
                    'https://www.fixsos.co/wp-content/uploads/2021/06/Web_Electrodomestico_Aire_Acondicionado-80x80.png',
              ),
              radius: 26,
            ),
            const SizedBox(width: 25),
            Flexible(
              flex: 4,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  service.name,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            currentUser?.specialties != null && currentUser!.specialties!.contains(service.reference!)
                ? Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.done,
                      size: 18,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
