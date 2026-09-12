import 'package:flutter/material.dart';

void main() {
  runApp(const ContadorApp());
}

class ContadorApp extends StatelessWidget {
  const ContadorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contador de Inspeção',
      home: TelaContador(),
    );
  }
}

class TelaContador extends StatefulWidget {
  const TelaContador({super.key});

  @override
  State<TelaContador> createState() => _TelaContadorState();
}

class _TelaContadorState extends State<TelaContador> {
  int _pecasAprovadas = 0;
  final _nomeController = TextEditingController();
  final List<String> _registros = [];

  void _aprovarPeca() {
    setState(() {
      _pecasAprovadas += 1;
    });
  }

  void _registrarEZerar() {
    final nome = _nomeController.text.trim().isEmpty
        ? 'Sem nome'
        : _nomeController.text.trim();

    setState(() {
      _registros.add('$nome - $_pecasAprovadas peça(s)');
      _pecasAprovadas = 0;
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspeção de Peças'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do inspetor',
                border: OutlineInputBorder(),
              ),
              onChanged: (texto) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            Text(
              _nomeController.text.trim().isEmpty
                  ? 'Responsável: Não informado'
                  : 'Responsável: ${_nomeController.text.trim()}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              'Peças aprovadas: $_pecasAprovadas',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.icon(
                  onPressed: _aprovarPeca,
                  icon: const Icon(Icons.add),
                  label: const Text('+1 Peça'),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _registrarEZerar,
                  icon: const Icon(Icons.save),
                  label: const Text('Registrar e Zerar'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Registros:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _registros.isEmpty
                  ? const Center(child: Text('Nenhum registro ainda.'))
                  : ListView.builder(
                      itemCount: _registros.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.history),
                            title: Text(_registros[index]),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}