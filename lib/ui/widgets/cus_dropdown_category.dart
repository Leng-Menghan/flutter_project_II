import 'package:flutter/material.dart';
import '../../models/category.dart';
import '../../l10n/app_localization.dart';
class CustomDropdownCategory extends StatelessWidget {
  final List<Category> categoryList;
  final ValueChanged<Category> onSelectCategory;
  const CustomDropdownCategory({super.key, required this.categoryList, required this.onSelectCategory});

  @override
  Widget build(BuildContext context) {
    final language = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(language.category.toUpperCase(), style:const TextStyle(color: Colors.black),),
        const SizedBox(height: 10),
        DropdownButtonFormField<Category>(
          initialValue: null,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:const BorderSide(
                  color: Colors.grey, 
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:const BorderSide(color: Color(0xFF2F7E79), width: 2),
              ),
            contentPadding:const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          hint: Text(language.selectCategory, style:const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 14),),
          items: categoryList.map((c) {
            return DropdownMenuItem<Category>(
              value: c,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: c.backgroundColor,
                    child: Image.asset(
                      c.icon,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(c.label, style: textTheme.titleMedium),
                ],
              ),
            );
          }).toList(),
          selectedItemBuilder: (context) {
            return categoryList.map((c) {
              return Text(c.label, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.normal));
            }).toList();
          },
          onChanged: (value) {
            if (value != null) {
              onSelectCategory(value);
            }
          },
        ),
      ],
    );
  }
}
