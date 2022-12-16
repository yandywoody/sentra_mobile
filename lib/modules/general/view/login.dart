import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/general/controller/login_controller.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class Login extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: Get.height,
            maxWidth: Get.width,
          ),
          decoration: const BoxDecoration(
            color: AppTheme.bgColorLight,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppTheme.primaryColor
                      // image: DecorationImage(
                      //   fit: BoxFit.fitHeight,
                      //   colorFilter: ColorFilter.mode(
                      //       Colors.black.withOpacity(0.2), BlendMode.dstATop),
                      //   image: const AssetImage("assets/images/banner-1.png"),
                      // ),
                      ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 32, top: 20, right: 32),
                      child: Column(
                        children: [
                          SizedBox(height: 170),
                          Image(
                            height: 60,
                            image: AssetImage('assets/images/logo-smm__.png'),
                          ),
                          // SizedBox(height: 50),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     Image(
                          //       width: Get.width - 65,
                          //       image: AssetImage(
                          //           'assets/images/login-ilustration.png'),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: 20),
                          // Lottie.asset(
                          //   'assets/animations/security-system-animation.json',
                          // ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       "Login",
                          //       style: AppTheme.bigTitleLight,
                          //     ),
                          //     SizedBox(
                          //       width: 10.0,
                          //     ),
                          //   ],
                          // ),
                          // const SizedBox(height: 10.0),
                          // Row(
                          //   children: [
                          //     Text(
                          //       "Masukan Username dan Password",
                          //       style: AppTheme.bigSubTitleLight,
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          TextField(
                            controller: controller.userEditingController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color(0xFFe7edeb),
                                hintText: "Username",
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Color(0xFF27324c),
                                )),
                          ),
                          const SizedBox(height: 10.0),
                          Obx(
                            () => TextField(
                              controller: controller.passwordEditingController,
                              obscureText: !controller.passwordIsVisible.value,
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFe7edeb),
                                  hintText: "Password",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      controller.passwordIsVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      controller.visiblePassword();
                                      print(controller.passwordIsVisible.value);
                                    },
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.key,
                                    color: Color(0xFF27324c),
                                  )),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            children: [
                              Obx(
                                () => InkWell(
                                  onTap: controller.isPlay.value
                                      ? null
                                      : controller.toggleAnimation,
                                  child: Stack(
                                    children: [
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        width: controller.isPlay.value
                                            ? 70
                                            : Get.width * 0.83,
                                        height: 55,
                                        curve: Curves.fastOutSlowIn,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              controller.isPlay.value
                                                  ? 50.0
                                                  : 10.0),
                                          color: Color(0xFFf8b858),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            AnimatedOpacity(
                                              opacity: controller.opacity,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              child: Text(
                                                "Log In",
                                                style: AppTheme.titleLight,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        width: controller.isPlay.value
                                            ? 70
                                            : Get.width * 0.83,
                                        height: 55,
                                        curve: Curves.fastOutSlowIn,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              controller.isPlay.value
                                                  ? 50.0
                                                  : 30.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            AnimatedOpacity(
                                              opacity: controller.opacity == 0.0
                                                  ? 1.0
                                                  : 0.0,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              child: Padding(
                                                child: CircularProgressIndicator(
                                                    backgroundColor: AppTheme
                                                        .themeColor,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(controller
                                                                .isPlay.value
                                                            ? AppTheme
                                                                .bgColorLight
                                                            : AppTheme
                                                                .themeColor)),
                                                padding: EdgeInsets.all(1),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 71.0),
                          const Text(
                            "2022. Sarana Makin Mulia All Right Reserved",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
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
