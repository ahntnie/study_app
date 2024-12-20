import 'package:flutter/material.dart';
import 'package:quizlet_xspin/constants/app_fontsize.dart';

class UserInfo extends StatelessWidget {
  final String nameUser;
  final String phone;
  final String uidUser;
  UserInfo(
      {required this.nameUser, required this.phone, required this.uidUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipOval(
                  child: Icon(
                Icons.person,
                size: 50,
              )),
              SizedBox(width: 15),
              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameUser,
                      style: TextStyle(
                        fontSize: AppFontSize.sizeLarge,
                        fontWeight: FontWeight.bold,
                        // color: AppColor.darkColor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      phone,
                      style: TextStyle(
                        fontSize: AppFontSize.sizeSmall,
                        // color: AppColor.darkColor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'ID: $uidUser',
                      style: TextStyle(
                        fontSize: AppFontSize.sizeSmall,
                        // color: AppColor.darkColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow icon
              Icon(
                Icons.arrow_forward_ios,
                // color: AppColor.darkColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
