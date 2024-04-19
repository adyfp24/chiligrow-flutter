part of '../page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
    _tapGestureRecognizer.onTap = () {
      Navigator.pushNamed(context, '/regist');
    };
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xFF30E5D0),
      appBar: AppBar(
        title: Text(''),
        toolbarHeight: 20,
      ),
      body: Column(
        children: [
          SizedBox(height: 180),
          Padding(
            padding: EdgeInsets.only(left: 35),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Log in',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Username'),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Password'),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        if (_usernameController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Data harus lengkap')),
                          );
                          return;
                        };
                        final user = User(
                          idUser: 0, // Dummy ID, tidak diperlukan untuk login
                          username: _usernameController.text,
                          password: _passwordController.text,
                          alamat: '', // Tidak diperlukan untuk login
                          email: '', // Tidak diperlukan untuk login
                          noHP: '', // Tidak diperlukan untuk login
                          role: '', // Tidak diperlukan untuk login
                        );
                        Provider.of<UserProvider>(context, listen: false)
                            .loginUser(user)
                            .then((_) async {
                          final prefs = FlutterSecureStorage();
                          final token = await prefs.read(key: 'token');
                          print(token);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('User login successfully')),
                          );
                          Navigator.pushNamed(context, '/home');
                        }).catchError((error) {
                          print(error);
                          ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text('username atau password salah'))
                          );
                        });
                      },
                      child: Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF30E5D0),
                        // primary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        text: 'Belum memiliki akun? ',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                        children: [
                          TextSpan(
                              text: 'Daftar',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF30E5D0),
                              ),
                              recognizer: _tapGestureRecognizer),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
