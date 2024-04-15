part of './provider.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  List<User> get users => _users;

  final UserService _userService = UserService();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  String? _token;
  String? get token => _token;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> registerUser(User newUser) async {
    _isLoading = true;
    notifyListeners();
    try {
      final responseData = await _userService.registerUser(newUser);
      _users.add(User.fromJson(responseData));
    } catch (e) {
      print('Error registering user: $e');
      throw Exception('Failed to register user');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loginUser(User user) async {
    _isLoading = true;
    notifyListeners();
    try {
      final responseData = await _userService.loginUser(user);
      _users.clear();
      _users.add(User.fromJson(responseData['data']));
      _token = responseData['token'];
      await _secureStorage.write(key: 'token', value: _token!);
    } catch (e) {
      print('Error logging in: $e');
      throw Exception('Failed to login');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getProfile() async {
    _isLoading = true;
    notifyListeners();
    try {
      final storedToken = await _secureStorage.read(key: 'token');
      if (storedToken != null) {
        final responseData = await _userService.getProfile(storedToken);
        _users.clear(); 
        _users.add(User.fromJson(responseData));
      }
    } catch (e) {
      print('Error getting profile: $e');
      throw Exception('Failed to get profile');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfile(User user) async {
    _isLoading = true;
    notifyListeners();
    try {
      final storedToken = await _secureStorage.read(key: 'token');
      if (storedToken != null) {
        await _userService.updateProfile(storedToken, user);
      }
    } catch (e) {
      print('Error updating profile: $e');
      throw Exception('Failed to update profile');
    }
    _isLoading = false;
    notifyListeners();
  }
}
