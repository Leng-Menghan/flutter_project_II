import 'package:flutter/material.dart';
import '../../l10n/app_localization.dart';
import '../widgets/cus_textfield.dart';
import '../../models/user.dart';
import '../widgets/input_decoration.dart';

class InputNameScreen extends StatefulWidget {
  const InputNameScreen({super.key});

  @override
  State<InputNameScreen> createState() => _InputNameScreenState();
}

class _InputNameScreenState extends State<InputNameScreen> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  AmountType? amountType;
  void onPress() async{
    if (_formKey.currentState!.validate()) {

    }
  } 

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your name";
    }
    if (value.length > 20) {
      return "Can not more than 20 characters";
    }
    return null;
  }
  
  String? validateAmountType(AmountType? amountType) {
    if (amountType == null) {
      return "Please select amount type";
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
            Center(child: Text("Smart Financial", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF2F7E79), fontSize: 30, fontWeight: FontWeight.w900),)),
            SizedBox(height: 25),
            Center(child: Image.asset("assets/onBoarding.png", height: 150,)),
            SizedBox(height: 30),
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(label: "FIRST NAME", hintText: "Enter your first name", text: firstNameController, validator: validateName,),
                    const SizedBox(height: 20),
                    CustomTextField(label: "LAST NAME", hintText: "Enter your last name", text: lastNameController, validator: validateName,),
                    const SizedBox(height: 20),
                    Text(language.amountType.toUpperCase(), style:TextStyle(color: colorTheme.onSurface),),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<AmountType>(
                      initialValue: null,
                      validator: validateAmountType,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.keyboard_arrow_down),
                      ),
                      decoration: customInputDecoration(),
                      hint: Text("Select Amount Type", style:const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 14),),
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
                child: Text("Get Started", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))
              ),
            ),
          ],
        ),
      ),
    );
  }
}