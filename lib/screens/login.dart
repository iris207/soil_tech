import 'package:flutter/material.dart';

void main() {
  runApp(const my_app());
}

class my_app extends StatelessWidget {
  const my_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const login_screen(),
    );
  }
}

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screen_state();
}

class _login_screen_state extends State<login_screen> {
  bool is_password_hidden = true;

  @override
  Widget build(BuildContext context) {
    final screen_size = MediaQuery.of(context).size;
    final screen_width = screen_size.width;
    final screen_height = screen_size.height;

    final horizontal_padding = screen_width * 0.08;
    final top_section_height = screen_height * 0.40;
    final button_width = screen_width * 0.58;

    return Scaffold(
      backgroundColor: const Color(0xfff8f6f1),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: top_section_height,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xffe3ffcc),
                              Color(0xffc8ff9f),
                              Color(0xff9bef73),
                              Color(0xff6fdd57),
                            ],
                            stops: [0.0, 0.3, 0.7, 1.0],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(80),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontal_padding,
                            vertical: screen_height * 0.025,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _label_text(
                                text: 'email',
                                font_size: screen_width * 0.045,
                              ),
                              SizedBox(height: screen_height * 0.01),
                              _custom_text_field(
                                hint_text: 'enter your email',
                                screen_width: screen_width,
                              ),
                              SizedBox(height: screen_height * 0.022),
                              _label_text(
                                text: 'password',
                                font_size: screen_width * 0.045,
                              ),
                              SizedBox(height: screen_height * 0.01),
                              _custom_text_field(
                                hint_text: 'enter your password',
                                screen_width: screen_width,
                                is_password: true,
                                is_password_hidden: is_password_hidden,
                                on_toggle_visibility: () {
                                  setState(() {
                                    is_password_hidden =
                                        !is_password_hidden;
                                  });
                                },
                              ),
                              SizedBox(height: screen_height * 0.012),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'forgot password',
                                  style: TextStyle(
                                    fontSize: screen_width * 0.034,
                                    color: const Color(0xff48693f),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: screen_height * 0.035),
                              Center(
                                child: SizedBox(
                                  width: button_width,
                                  height: screen_height * 0.065,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color(0xffaef27b),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'login',
                                      style: TextStyle(
                                        fontSize: screen_width * 0.043,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff2d4f28),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screen_height * 0.045),
                              Center(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Text(
                                      "don't have an account? ",
                                      style: TextStyle(
                                        fontSize: screen_width * 0.034,
                                        color: const Color(0xff6c6c6c),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'sign up',
                                      style: TextStyle(
                                        fontSize: screen_width * 0.034,
                                        color: const Color(0xff355c30),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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

class _label_text extends StatelessWidget {
  final String text;
  final double font_size;

  const _label_text({
    required this.text,
    required this.font_size,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: font_size,
        fontWeight: FontWeight.w700,
        color: const Color(0xff3d6035),
      ),
    );
  }
}

class _custom_text_field extends StatelessWidget {
  final String hint_text;
  final double screen_width;
  final bool is_password;
  final bool is_password_hidden;
  final VoidCallback? on_toggle_visibility;

  const _custom_text_field({
    required this.hint_text,
    required this.screen_width,
    this.is_password = false,
    this.is_password_hidden = false,
    this.on_toggle_visibility,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: is_password ? is_password_hidden : false,
      decoration: InputDecoration(
        hintText: hint_text,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: screen_width * 0.033,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: screen_width * 0.035,
          vertical: 14,
        ),
        filled: true,
        fillColor: const Color(0xfff8f6f1),
        suffixIcon: is_password
            ? IconButton(
                onPressed: on_toggle_visibility,
                icon: Icon(
                  is_password_hidden
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: const Color(0xff56734b),
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Color(0xff56734b),
            width: 1.4,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Color(0xff73dc59),
            width: 1.8,
          ),
        ),
      ),
    );
  }
}