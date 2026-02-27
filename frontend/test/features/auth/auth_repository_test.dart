import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/features/auth/data/auth_repository.dart';

class MockDio implements Dio {
  late Response _mockResponse;
  late Response _mockGetResponse;
  late Object _mockError;

  void stubPostResponse(Response response) => _mockResponse = response;
  void stubGetResponse(Response response) => _mockGetResponse = response;
  void stubPostError(Object error) => _mockError = error;

  @override
  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (_mockError.toString().isNotEmpty) {
      throw _mockError;
    }
    return _mockResponse as Response<T>;
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _mockGetResponse as Response<T>;
  }

  // Dummy overrides for rest
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockFlutterSecureStorage implements FlutterSecureStorage {
  final Map<String, String> _storage = {};

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value != null) _storage[key] = value;
  }

  // Dummy overrides
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late AuthRepository repository;
  late MockDio mockDio;
  late MockFlutterSecureStorage mockStorage;

  setUp(() {
    mockDio = MockDio();
    mockDio._mockError = '';
    mockStorage = MockFlutterSecureStorage();
    repository = AuthRepository(mockDio, mockStorage);
  });

  group('AuthRepository', () {
    test('login returns UserModel and saves token on success', () async {
      // Arrange
      final mockResponseData = {
        'token': 'fake_jwt_token',
        'user': {
          'id': 1,
          'email': 'test@example.com',
          'role': 'USER',
          'level': 'BEGINNER',
          'currentStreak': 5,
        },
      };

      mockDio.stubPostResponse(
        Response(
          requestOptions: RequestOptions(path: '/auth/login'),
          data: mockResponseData,
          statusCode: 200,
        ),
      );
      mockDio.stubGetResponse(
        Response(
          requestOptions: RequestOptions(path: '/users/me'),
          data: mockResponseData['user'],
          statusCode: 200,
        ),
      );

      // Act
      final user = await repository.login('test@example.com', 'password');

      // Assert
      expect(user.email, 'test@example.com');
      expect(user.role, 'USER');
      expect(user.level, 'BEGINNER');
      expect(mockStorage._storage['jwt_token'], 'fake_jwt_token');
    });

    test('login throws Exception on Dio failure', () async {
      // Arrange
      mockDio.stubPostError(
        DioException(
          requestOptions: RequestOptions(path: '/auth/login'),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: '/auth/login'),
            statusCode: 401,
            data: {'message': 'Unauthorized'},
          ),
        ),
      );

      // Act & Assert
      expect(
        () => repository.login('wrong@example.com', 'badpass'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
