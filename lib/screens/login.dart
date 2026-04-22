import 'package:flutter/material.dart';
import 'regis.dart';
import 'menu.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screen_state();
}

class _login_screen_state extends State<login_screen> {
  bool is_password_hidden = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final backgroundColor = const Color(0xfff7f5ef);
    final borderColor = const Color(0xff4f6c46);
    final textColor = const Color(0xff355c30);

    final headerHeight = screenHeight * 0.40;
    final bodyTopPosition = screenHeight * 0.33;
    final horizontalPadding = screenWidth * 0.10;
    final buttonWidth = screenWidth * 0.58;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: constraints.maxHeight,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: headerHeight,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xffdfffc9),
                              Color(0xffc5f79d),
                              Color(0xff99eb6f),
                              Color(0xff73dd58),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(200),
                          ),
                        ),
                      ),
                      Positioned(
                        top: bodyTopPosition,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(88),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              horizontalPadding,
                              screenHeight * 0.075,
                              horizontalPadding,
                              screenHeight * 0.035,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _border_label_field(
                                  label_text: 'EMAIL',
                                  screen_width: screenWidth,
                                  background_color: backgroundColor,
                                  border_color: borderColor,
                                  text_color: textColor,
                                ),
                                SizedBox(height: screenHeight * 0.03),
                                _border_label_field(
                                  label_text: 'PASSWORD',
                                  screen_width: screenWidth,
                                  background_color: backgroundColor,
                                  border_color: borderColor,
                                  text_color: textColor,
                                  is_password: true,
                                  is_password_hidden: is_password_hidden,
                                  on_toggle_visibility: () {
                                    setState(() {
                                      is_password_hidden = !is_password_hidden;
                                    });
                                  },
                                ),
                                SizedBox(height: screenHeight * 0.018),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'forgot password',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.033,
                                      color: borderColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.045),
                                Center(
                                  child: SizedBox(
                                    width: buttonWidth,
                                    height: 46,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Menu(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xffa8f07a),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                      child: Text(
                                        'LOGIN',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.041,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff2f4f29),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.04),
                                Center(
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account ? ",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.032,
                                          color: const Color(0xff707070),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'SIGN UP',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.032,
                                            color: textColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _border_label_field extends StatelessWidget {
  final String label_text;
  final double screen_width;
  final Color background_color;
  final Color border_color;
  final Color text_color;
  final bool is_password;
  final bool is_password_hidden;
  final VoidCallback? on_toggle_visibility;

  const _border_label_field({
    required this.label_text,
    required this.screen_width,
    required this.background_color,
    required this.border_color,
    required this.text_color,
    this.is_password = false,
    this.is_password_hidden = false,
    this.on_toggle_visibility,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: background_color,
            border: Border.all(
              color: border_color,
              width: 1.5,
            ),
          ),
          child: TextField(
            obscureText: is_password ? is_password_hidden : false,
            style: TextStyle(
              fontSize: screen_width * 0.034,
              color: text_color,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: screen_width * 0.03,
                vertical: 11,
              ),
              suffixIcon: is_password
                  ? IconButton(
                      onPressed: on_toggle_visibility,
                      icon: Icon(
                        is_password_hidden
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: border_color,
                      ),
                    )
                  : null,
            ),
          ),
        ),
        Positioned(
          left: 12,
          top: -9,
          child: Container(
            color: background_color,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              label_text,
              style: TextStyle(
                fontSize: screen_width * 0.035,
                fontWeight: FontWeight.w700,
                color: text_color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}