import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      "Cargando películas",
      "Comprando palomitas",
      "Cargando Populares",
      "Esto está tardando más de lo esperado :(",
    ];

    return Stream.periodic(Duration(milliseconds: 2000), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Espere por favor"),
          const SizedBox(height: 10),
          const CircularProgressIndicator.adaptive(),
          const SizedBox(height: 10),
          StreamBuilder(stream: getLoadingMessages(), builder: (context, snapshot){
            if(!snapshot.hasData) return const Text('Cargando...');
            return Text(snapshot.data!);
          })
        ],
      ),
    );
  }
}
