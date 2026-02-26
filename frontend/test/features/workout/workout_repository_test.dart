import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:frontend/features/workout/data/workout_repository.dart';

class MockDio implements Dio {
  late Response _mockResponse;

  void stubGetResponse(Response response) => _mockResponse = response;

  @override
  Future<Response<T>> get<T>(String path, {Object? data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onReceiveProgress}) async {
    return _mockResponse as Response<T>;
  }

  // Dummy overrides
  @override noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late WorkoutRepository repository;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    repository = WorkoutRepository(mockDio);
  });

  group('WorkoutRepository', () {
    test('getWorkoutsByLevel returns list of WorkoutModel', () async {
      // Arrange
      final mockResponseData = [
        {
          'id': 1,
          'title': 'Test Workout',
          'durationMin': 30,
          'calories': 300,
          'level': 'BEGINNER',
          'category': 'STRENGTH',
          'imageUrl': 'http://image.com',
          'videoUrl': 'http://video.com',
          'isAiGenerated': false,
          'sport': {'id': 1, 'name': 'Gym', 'category': 'STRENGTH'},
          'exercises': []
        }
      ];

      mockDio.stubGetResponse(Response(
        requestOptions: RequestOptions(path: '/workouts'),
        data: mockResponseData,
        statusCode: 200,
      ));

      // Act
      final workouts = await repository.getWorkouts(level: 'BEGINNER');

      // Assert
      expect(workouts.length, 1);
      expect(workouts.first.title, 'Test Workout');
      expect(workouts.first.level, 'BEGINNER');
    });

    test('getWorkoutById returns a WorkoutModel', () async {
      // Arrange
      final mockResponseData = {
        'id': 1,
        'title': 'Test Workout',
        'durationMin': 30,
        'calories': 300,
        'level': 'BEGINNER',
        'category': 'STRENGTH',
        'imageUrl': 'http://image.com',
        'videoUrl': 'http://video.com',
        'isAiGenerated': false,
        'sport': {'id': 1, 'name': 'Gym', 'category': 'STRENGTH'},
        'exercises': []
      };

      mockDio.stubGetResponse(Response(
        requestOptions: RequestOptions(path: '/workouts/1'),
        data: mockResponseData,
        statusCode: 200,
      ));

      // Act
      final workout = await repository.getWorkoutById('1');

      // Assert
      expect(workout.id, 1);
      expect(workout.title, 'Test Workout');
    });
  });
}
