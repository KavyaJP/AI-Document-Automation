import 'package:dio/dio.dart';
import 'package:doc_query/config/api_config.dart';

class ChatResponse {
  final String question;
  final String answer;
  final String contextUsed;

  ChatResponse({
    required this.question,
    required this.answer,
    required this.contextUsed,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      question: json['question']?.toString() ?? '',
      answer: json['answer']?.toString() ?? 'No answer generated',
      contextUsed: json['contextUsed']?.toString() ?? '',
    );
  }
}

class ChatService {
  final Dio _dio = Dio();

  Future<ChatResponse> askQuestion({
    required String query,
    required String modelName,
  }) async {
    try {
      final response = await _dio.post(
        ApiConfig.chatAsk,
        data: {'query': query, 'model_name': modelName},
      );

      return ChatResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      if (e is DioException) {
        final serverMessage = e.response?.data['detail'].toString();
        throw Exception(serverMessage ?? 'Failed to get answer: ${e.message}');
      }
      throw Exception('Unexpected error during chat: $e');
    }
  }
}
