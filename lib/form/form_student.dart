import 'package:dio/dio.dart';
import 'package:tutorados_app/config/config.dart';
import 'package:tutorados_app/form/form_error.dart';
import 'package:tutorados_app/mappers/mappers.dart';

class FormStudent {
  late final Dio dio;
  final String accessToken;

  FormStudent({required this.accessToken})
      : dio = Dio(BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {'Authorization': 'Bearer $accessToken'}));

  Future verifyTutor(String id) async {
    try {
      final response = await dio.get('/tutor/verify/$id');
      final tutor = TutorMapper.userJsonToEntity(response.data);
      return tutor;
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        throw FormError(error.response?.data['message'] ??
            'Todos los campos son requeridos');
      }
      if (error.response?.statusCode == 404) {
        throw FormError(
            error.response?.data['message'] ?? 'No se encontró el tutor');
      }
      if (error.response?.statusCode == 500) {
        throw FormError(
            error.response?.data['message'] ?? 'Se ha producido un error');
      }
      if (error.type == DioExceptionType.connectionError) {
        throw FormError('Revisa tu conexión a internet');
      }
      throw FormError('Algo malo pasó');
    } catch (error) {
      throw FormError('Algo malo pasó');
    }
  }
}
