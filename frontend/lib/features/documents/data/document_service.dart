import 'package:dio/dio.dart';
import 'package:doc_query/config/api_config.dart';

class DocumentService {
  final Dio _dio = Dio();

  Future<String> uploadDocument({
    required String filePath,
    required String fileName,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath, filename: fileName),
      });

      final response = await _dio.post(
        ApiConfig.uploadDocument,
        data: formData,
      );

      final responseData = response.data as Map<String, dynamic>;

      return responseData['message']?.toString() ?? "Upload Succcesful";
    } catch (e) {
      if (e is DioException) {
        final serverMessage = e.response?.data['detail']?.toString();
        throw Exception(
          serverMessage ?? 'Failed to upload document: ${e.message}',
        );
      }
      throw Exception('Unexpected Error Uploading Document: $e');
    }
  }
}
