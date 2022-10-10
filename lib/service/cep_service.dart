
import 'package:desafio_busca_cep/model/cep_model.dart';

abstract class CepService {
  Future<CepModel> getCep(String cep);
}