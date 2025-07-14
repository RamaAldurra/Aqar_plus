import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  bool get isFormValid => formKey.currentState?.validate() ?? false;

  Future<void> login() async {
    if (isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("جاري التحقق ..."),
          backgroundColor: Color(0xFF0073CF),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));
      // هنا يمكنك الانتقال إلى صفحة أخرى أو عرض نجاح
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Image.asset("images/Logo.jpg"),
              const SizedBox(height: 20),
              Form(
                key: formKey,
                onChanged: () => setState(() {}),
                child: Column(
                  children: [
                    // حقل الاسم
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: nameController,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "الاسم",
                          labelStyle: const TextStyle(color: Color(0xFF757575)),
                          prefixIcon: const Icon(Icons.person, color: Color(0xFF757575)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Color(0xFF0073CF)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Color(0xFF0073CF), width: 1.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'يرجى إدخال الاسم';
                          }
                          if (value.trim().length < 2) {
                            return 'يرجى إدخال اسم صحيح';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    // حقل كلمة المرور
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: passwordController,
                        textAlign: TextAlign.left,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "كلمة المرور",
                          labelStyle: const TextStyle(color: Color(0xFF757575)),
                          prefixIcon:
                              const Icon(Icons.lock, color: Color(0xFF757575)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xFF757575),
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Color(0xFF0073CF)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Color(0xFF0073CF), width: 1.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'يرجى إدخال كلمة المرور';
                          }
                          if (value.length < 6) {
                            return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    MaterialButton(
                      elevation: 5.0,
                      color: isFormValid ? const Color(0xFF0073CF) : Colors.grey,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 80),
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      onPressed: isFormValid ? login : null,
                      child: const Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "إنشاء حساب",
                  style: TextStyle(
                    color: Color(0xFF0073CF),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
