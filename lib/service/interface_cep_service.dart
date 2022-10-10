import 'dart:developer';
import 'package:desafio_busca_cep/model/cep_model.dart';
import 'package:dio/dio.dart';
import './cep_service.dart';

class InterfaceCepService implements CepService {
  @override
  Future<CepModel> getCep(String cep) async {
    try {
      final result = await Dio().get('https://viacep.com.br/ws/$cep/json/');
      return CepModel.fromMap(result.data);
    } on DioError catch (e) {
      log('Erro ao buscar cep', error: e);
      throw Exception('Erro ao buscar cep');
    }
  }
}
