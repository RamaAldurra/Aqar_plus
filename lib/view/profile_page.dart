import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/profile_controller.dart';

// صفحة عرض الصورة بالحجم الكامل
class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImagePage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("عرض الصورة", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    controller.getProfile(); // جلب البيانات عند فتح الصفحة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "الملف الشخصي",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0073CF),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xFF0073CF),
              strokeWidth: 5,
            ),
          );
        }

        if (controller.error.value.isNotEmpty) {
          return Center(
            child: Text(
              "حدث خطأ: ${controller.error.value}",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        }

        final profile = controller.profile.value;
        if (profile == null) {
          return Center(
            child: Text(
              "لا يوجد بيانات",
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),

              // صورة الملف الشخصي مع أيقونة التعديل
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FullScreenImagePage(imageUrl: profile.profilePhoto),
                        ),
                      );
                    },
                    child: ClipOval(
                      child: Image.network(
                        profile.profilePhoto,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: InkWell(
                      onTap: () {
                        print("تم الضغط على أيقونة التعديل");
                        // لاحقاً يمكنك استدعاء picker لاختيار صورة جديدة
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              Text(
                " ${profile.name}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                " ${profile.email}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "الرصيد: ${profile.balance} ل.س",
                style: TextStyle(fontSize: 18, color: Colors.green.shade700),
              ),
              SizedBox(height: 30),
              Divider(thickness: 1),
              SizedBox(height: 20),

              // زر ترقية لحساب بائع
              ElevatedButton.icon(
                onPressed: () {
                  // لاحقاً يتم ربطه بعملية الترقية
                },
                icon: Icon(Icons.upgrade, color: Colors.white),
                label: Text("ترقية لحساب بائع", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 50),
                  backgroundColor: Color(0xFF0073CF),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),

              SizedBox(height: 20),

              // زر تسجيل الخروج
              ElevatedButton.icon(
                onPressed: () {
                  // لاحقاً يتم ربطه بتسجيل الخروج الحقيقي
                },
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text("تسجيل الخروج", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0073CF),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),

              SizedBox(height: 15),
            ],
          ),
        );
      }),
    );
  }
}
