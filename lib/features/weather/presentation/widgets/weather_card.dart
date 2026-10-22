import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rotina/features/weather/presentation/view_model/weather_view_model.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<WeatherViewModel>();
    final Widget content;
    if (vm.loading) {
      content = const Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 12),
          Text('Carregando clima...'),
        ],
      );
    } else if (vm.error != null) {
      content = Text(vm.error!);
    } else if (vm.weather != null) {
      final w = vm.weather!;
      content = Text(
        'São Paulo · ${w.temperature.round()}°C · ${w.description}',
      );
    } else {
      content = const SizedBox.shrink();
    }
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.wb_sunny_outlined),
            const SizedBox(width: 12),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}
