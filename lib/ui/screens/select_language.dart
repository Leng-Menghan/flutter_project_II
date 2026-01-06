import 'package:flutter/material.dart';
import '../../data/share_reference.dart';
import '../../models/user.dart';
import '../../utils/animations_util.dart';
import 'inpute_name.dart';

class LanguageScreen extends StatelessWidget {
  final ValueChanged<Language> onSelectLanguage;
  const LanguageScreen({
    super.key,
    required this.onSelectLanguage
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF63B5AF),
              Color(0xFF438883),
            ],),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset("assets/logo.png", height: 150,)),
            Center(child: Text("Smart Finance", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900),)),
            SizedBox(height: 40),
            Text("ភាសា / LANGUAGE", style: TextStyle(color: Colors.white),),
            SizedBox(height: 10),
            ...Language.values.map((l) => 
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    side: BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),
                  onPressed: () async {
                      await ShareReference.setLanguage(l);
                      onSelectLanguage(l);

                      Navigator.pushReplacement(
                        context,
                        AnimationUtils.slideTBWithFade(NameScreen(onSelectLanguage: onSelectLanguage,))
                      );
                  }, 
                  child: Row(
                    children: [
                      Image.asset(l.imageAsset, width: 43,),
                      SizedBox(width: 10),
                      Text(l.name, style: TextStyle(color: Colors.white, fontSize: 14))
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

