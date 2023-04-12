import 'package:fintechdemo/src/blocs/login_bloc.dart';
import 'package:flutter/material.dart';
import './home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

bool showPass = true;

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HomePage(pageIndex: 0),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class _LoginPage extends State<LoginPage> {
  // new bloc
  LoginBloc bloc = new LoginBloc();
  // tạo biến lấy text để xử lí data
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  var _usernameError = "Tài khoản không hợp lệ";
  bool _usernameInvalid = false;
  bool _passwordInvalid = false;
  var _passwordError = "Mật khẩu không hợp lệ phải trên 6 kí tự";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue.shade600,
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Wrap(
          alignment: WrapAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: <Widget>[
            // hình ảnh Flutter
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
              child: Container(
                width: 90,
                height: 90,
                padding: EdgeInsets.all(15),
                child: FlutterLogo(),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffd8d8d8),
                ),
              ),
            ),
            // lời chào mừng
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 60),
              child: Text(
                "Xin chào \nFintech Of JunctionX Hanoi 2023",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30),
              ),
            ),
            // Input tên đăng nhập
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: StreamBuilder(
                  stream: bloc.userStream,
                  builder: (context, snapshot) => TextField(
                    controller: _usernameController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Tên đăng nhập",
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      labelStyle:
                          TextStyle(color: Color(0xff888888), fontSize: 15),
                    ),
                  ),
                )),
            // Input mật khẩu
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    StreamBuilder(
                      stream: bloc.passStream,
                      builder: ((context, snapshot) => TextField(
                            controller: _passwordController,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            obscureText: showPass,
                            decoration: InputDecoration(
                              labelText: "Mật Khẩu",
                              errorText: snapshot.hasError
                                  ? snapshot.error.toString()
                                  : null,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 15),
                            ),
                          )),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          showPass = !showPass;
                        });
                      },
                      child: Text(
                        showPass ? "Hiển thị" : "Ẩn",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (bloc.isValidInfo(
                        _usernameController.text, _passwordController.text)) {
                      Navigator.pushReplacement(context,
                      _createRoute());
                    }
                  },
                  child: Text(
                    "Đăng nhập",
                    // cho chữ đăng nhập to hơn
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Container(
                  height: 130,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Bạn chưa có Tài Khoản ?",
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Quên Mật Khẩu",
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            // thêm
          ],
        ),
      ),
    );
  }
}
