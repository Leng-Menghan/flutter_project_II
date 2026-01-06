import 'package:flutter/material.dart';
import '../../data/share_reference.dart';
import '../../data/sqlite.dart';
import '../../l10n/app_localization.dart';
import '../../utils/animations_util.dart';
import '../app_root.dart';
import '../widgets/cus_textfield.dart';
import '../widgets/input_decoration.dart';
import '../../models/user.dart';

class NameScreen extends StatefulWidget {
  final ValueChanged<Language> onSelectLanguage;
  const NameScreen({super.key, required this.onSelectLanguage});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  AmountType? amountType;


  void onPress() async{
    if (_formKey.currentState!.validate()) {
      String name = "${firstNameController.text.trim()} ${lastNameController.text.trim()}".trim();
      await ShareReference.setName(name);
      await ShareReference.setAmountType(amountType!);
      await ShareReference.setImage("");
      Map<String, dynamic> userInfo = await ShareReference.readUserInfo();
      await Sqlite.initDatabase();
      User user = User(
        name: name,
        profileImage: "",
        preferredLanguage: userInfo['language'],
        preferredAmountType: amountType!,
        transactions: [],
        budgetGoals: [],
      );

      Navigator.pushReplacement(
        context,
        AnimationUtils.scaleWithFade(AppRoot(user: user, onChangeLanguage: widget.onSelectLanguage,))
      );
    }
  } 

  String? validateName(String? value, AppLocalizations language) {
    if (value == null || value.trim().isEmpty) {
      return language.nameRequired;
    }
    if (value.length > 15) {
      return language.nameLength;
    }
    if (value.trim().contains(' ')) {
      return language.noSpace;
    }
    return null;
  }
  
  String? validateAmountType(AmountType? amountType, AppLocalizations language) {
    if (amountType == null) {
      return language.amountTypeRequired;
    }
    return null;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
          final language = AppLocalizations.of(context)!;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Column(
                children: [
                  Center(child: Text("Smart Finance", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF2F7E79), fontSize: 30, fontWeight: FontWeight.w900),)),
                  SizedBox(height: 25),
                  Center(child: Image.asset("assets/logo.png", height: 150,)),
                  SizedBox(height: 30),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(label: language.firstName, hintText: language.enterYourFirstName, text: firstNameController, validator: (value) => validateName(value, language),),
                          const SizedBox(height: 20),
                          CustomTextField(label: language.lastName, hintText: language.enterYourFirstName, text: lastNameController, validator: (value) => validateName(value, language)),
                          const SizedBox(height: 20),
                          Text(language.amountType.toUpperCase(), style:TextStyle(color: colorTheme.onSurface),),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<AmountType>(
                            initialValue: amountType,
                            validator: (value) => validateAmountType(value, language),
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(Icons.keyboard_arrow_down),
                            ),
                            decoration: customInputDecoration(),
                            hint: Text(language.selectAmountType, style:const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 14),),
                            items: AmountType.values.map((at) {
                              return DropdownMenuItem<AmountType>(
                                value: at,
                                child: Row(
                                  children: [
                                    Image.asset(at.imageAsset, height: 20,),
                                    const SizedBox(width: 10),
                                    Text(at.name, style: textTheme.titleMedium),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  amountType = value;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),          
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor:  Color(0xFF2F7E79),
                        backgroundColor: Color(0xFF2F7E79),
                        padding: EdgeInsets.all(18),
                        shadowColor: Color(0xFF63B5AF),
                        elevation: 10
                      ),
                      onPressed: onPress, 
                      child: Text(language.getStarted, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))
                    ),
                  ),
                ],
              ),
            ),
    );
  }

}