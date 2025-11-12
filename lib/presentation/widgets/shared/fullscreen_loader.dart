import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220031/presentation/providers/movies/loading_progress_provider.dart';

class FullscreenLoader extends ConsumerWidget {
  const FullscreenLoader({super.key});
  
  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Estableciendo elementos de comunicación',
      'Conectando a la API de TheMovieDB',
      'Obteniendo las películas que actualmente se proyectan',
      'Obteniendo los próximos estrenos',
      'Obteniendo las películas mejor valoradas',
      'Obteniendo las mejores películas Mexicanas',
      'Todo listo... comencemos'
    ];
  
    return Stream.periodic(
      const Duration(milliseconds: 3000),
      (step) => messages[step % messages.length],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Monitoreamos el progreso de carga
    final progress = ref.watch(loadingProgressProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Bienvenid@ a Cinemapedia - 220031'),
          const SizedBox(height: 10),
          
          // Barra de progreso linear
          SizedBox(
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress / 100,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  progress < 50
                      ? Colors.blue
                      : progress < 80
                          ? Colors.amber
                          : Colors.green,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 15),
          
          // Porcentaje de progreso
          Text(
            '$progress%',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Círculo de progreso con porcentaje
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress / 100,
                  strokeWidth: 5,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progress < 50
                        ? Colors.blue
                        : progress < 80
                            ? Colors.amber
                            : Colors.green,
                  ),
                ),
                Text(
                  '$progress%',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Mensaje de carga
          StreamBuilder<String>(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('Cargando...');
              }
              return Text(snapshot.data!);
            }
          )
        ],
      ),
    );
  }
}