import 'package:flutter/material.dart';

class RegisScreen extends StatefulWidget {
  const RegisScreen({super.key});

  @override
  State<RegisScreen> createState() => _RegisScreenState();
}

class _RegisScreenState extends State<RegisScreen> {
  bool is_password_hidden = true;
  bool is_confirm_password_hidden = true;

  final username_controller = TextEditingController();
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final confirm_password_controller = TextEditingController();

  @override
  void dispose() {
    username_controller.dispose();
    email_controller.dispose();
    password_controller.dispose();
    confirm_password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen_size = MediaQuery.of(context).size;
    final screen_width = screen_size.width;
    final screen_height = screen_size.height;

    final background_color = const Color(0xfff7f5ef);
    final border_color = const Color(0xff4f6c46);
    final text_color = const Color(0xff355c30);

    final header_height = screen_height * 0.18;
    final body_top_position = screen_height * 0.10;
    final horizontal_padding = screen_width * 0.07;
    final button_width = screen_width * 0.70;

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
                        clipBehavior: Clip.antiAlias,
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
                            bottomRight: Radius.circular(120),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screen_width * 0.05,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: const BoxDecoration(
                                  color: Color(0xff123f1a),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    size: 18,
                                    color: Color(0xffa8f07a),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'CREATE ACCOUNT',
                                    style: TextStyle(
                                      fontSize: screen_width * 0.07,
                                      fontWeight: FontWeight.w700,
                                      color: text_color,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 34),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: body_top_position,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: background_color,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(120),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              horizontal_padding,
                              screen_height * 0.10,
                              horizontal_padding,
                              screen_height * 0.04,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _border_label_field(
                                  label_text: 'USERNAME',
                                  controller: username_controller,
                                  screen_width: screen_width,
                                  background_color: background_color,
                                  border_color: border_color,
                                  text_color: text_color,
                                ),
                                SizedBox(height: screen_height * 0.025),
                                _border_label_field(
                                  label_text: 'EMAIL',
                                  controller: email_controller,
                                  screen_width: screen_width,
                                  background_color: background_color,
                                  border_color: border_color,
                                  text_color: text_color,
                                ),
                                SizedBox(height: screen_height * 0.025),
                                _border_label_field(
                                  label_text: 'PASSWORD',
                                  controller: password_controller,
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
                                SizedBox(height: screen_height * 0.025),
                                _border_label_field(
                                  label_text: 'CONFIRM PASSWORD',
                                  controller: confirm_password_controller,
                                  screen_width: screen_width,
                                  background_color: background_color,
                                  border_color: border_color,
                                  text_color: text_color,
                                  is_password: true,
                                  is_password_hidden: is_confirm_password_hidden,
                                  on_toggle_visibility: () {
                                    setState(() {
                                      is_confirm_password_hidden =
                                          !is_confirm_password_hidden;
                                    });
                                  },
                                ),
                                const Spacer(),
                                Center(
                                  child: SizedBox(
                                    width: button_width,
                                    height: 46,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xffa8f07a),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                      child: Text(
                                        'SIGN UP',
                                        style: TextStyle(
                                          fontSize: screen_width * 0.041,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff2f4f29),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: screen_height * 0.06),
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
  final TextEditingController controller;
  final double screen_width;
  final Color background_color;
  final Color border_color;
  final Color text_color;
  final bool is_password;
  final bool is_password_hidden;
  final VoidCallback? on_toggle_visibility;

  const _border_label_field({
    required this.label_text,
    required this.controller,
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
            controller: controller,
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