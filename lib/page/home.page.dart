import 'package:flutter/material.dart';

import '../model/cep_model.dart';
import '../service/cep_service.dart';
import '../service/interface_cep_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CepService cepService = InterfaceCepService();
  CepModel? cepModel;

  final formKey = GlobalKey<FormState>();
  final cepController = TextEditingController();

  @override
  void dispose() {
    cepController.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Endeço'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 150, horizontal: 30),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Busca Endeço',
                        hintText: 'Cep',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(55),
                        ),
                      ),
                      controller: cepController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Cep Obrigatório';
                        }
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final valid =
                            formKey.currentState?.validate() ?? false;
                        if (valid) {
                          try {
                            final endereco =
                                await cepService.getCep(cepController.text);
                            setState(() {
                              cepModel = endereco;
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Erro ao Buscar Cep'),
                            ));
                          }
                        }
                      },
                      child: const Text('Buscar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Visibility(
              visible: cepModel != null,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Rua: ${cepModel?.logradouro} ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '    Bairro: ${cepModel?.bairro}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // ignore: prefer_const_constructors
                  Divider(
                    color: Colors.blue,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Cep: ${cepModel?.cep} ',
                      ),
                      Text(
                        'Cidade: ${cepModel?.localidade}',
                      ),
                      Text(
                        'Estado: ${cepModel?.uf}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
