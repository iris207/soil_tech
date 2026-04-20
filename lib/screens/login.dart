import 'package:flutter/material.dart';

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

    final background_color = const Color(0xfff7f5ef);
    final border_color = const Color(0xff4f6c46);
    final text_color = const Color(0xff355c30);

    final header_height = screen_height * 0.40;
    final body_top_position = screen_height * 0.33;
    final horizontal_padding = screen_width * 0.10;
    final button_width = screen_width * 0.58;

    return Scaffold(
      backgroundColor: background_color,
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
                        height: header_height,
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
                        top: body_top_position,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: background_color,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(88),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              horizontal_padding,
                              screen_height * 0.075,
                              horizontal_padding,
                              screen_height * 0.035,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _border_label_field(
                                  label_text: 'EMAIL',
                                  screen_width: screen_width,
                                  background_color: background_color,
                                  border_color: border_color,
                                  text_color: text_color,
                                ),
                                SizedBox(height: screen_height * 0.03),
                                _border_label_field(
                                  label_text: 'PASSWORD',
                                  screen_width: screen_width,
                                  background_color: background_color,
                                  border_color: border_color,
                                  text_color: text_color,
                                  is_password: true,
                                  is_password_hidden: is_password_hidden,
                                  on_toggle_visibility: () {
                                    setState(() {
                                      is_password_hidden = !is_password_hidden;
                                    });
                                  },
                                ),
                                SizedBox(height: screen_height * 0.018),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'forgot password',
                                    style: TextStyle(
                                      fontSize: screen_width * 0.033,
                                      color: border_color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: screen_height * 0.045),
                                Center(
                                  child: SizedBox(
                                    width: button_width,
                                    height: 46,
                                    child: ElevatedButton(
                                      onPressed: () {},
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
                                          fontSize: screen_width * 0.041,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff2f4f29),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: screen_height * 0.04),
                                Center(
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account ? ",
                                        style: TextStyle(
                                          fontSize: screen_width * 0.032,
                                          color: const Color(0xff707070),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'SIGN UP',
                                        style: TextStyle(
                                          fontSize: screen_width * 0.032,
                                          color: text_color,
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