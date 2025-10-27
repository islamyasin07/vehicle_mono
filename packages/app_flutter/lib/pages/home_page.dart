import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import 'list_tab.dart';
import '../core/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _index = 0;
  static const _kAnimDuration = Duration(milliseconds: 450);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!mounted) return;
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      await context.read<AppState>().save();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Data saved.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const tabs = [
      ListTab(kind: TabKind.cars),
      ListTab(kind: TabKind.motorcycles),
      ListTab(kind: TabKind.trucks),
    ];

    final gradients = [
      const LinearGradient(
        colors: [Color(0xFF455A64), Color(0xFF1E88E5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      const LinearGradient(
        colors: [Color(0xFF6A1B9A), Color(0xFFFF7043)],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      const LinearGradient(
        colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ];

    final backgroundGradient = gradients[_index % gradients.length];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Manager'),
        backgroundColor: Theme.of(
          context,
        ).colorScheme.primary.withAlpha((0.92 * 255).round()),
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: _kAnimDuration,
            decoration: BoxDecoration(gradient: backgroundGradient),
          ),
          SafeArea(
            child: AnimatedSwitcher(
              duration: _kAnimDuration,
              transitionBuilder: (child, animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(0.0, 0.05),
                  end: Offset.zero,
                ).animate(animation);
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  ),
                );
              },
              child: Container(
                key: ValueKey<int>(_index),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Material(
                  color: const Color.fromRGBO(255, 255, 255, 0.85),
                  elevation: 0,
                  borderRadius: BorderRadius.circular(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: tabs[_index],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: _kAnimDuration,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.9),
          border: Border(top: BorderSide(color: Colors.black12, width: 0.5)),
        ),
        child: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.directions_car),
              label: 'Cars',
            ),
            NavigationDestination(
              icon: Icon(Icons.two_wheeler),
              label: 'Motos',
            ),
            NavigationDestination(
              icon: Icon(Icons.local_shipping),
              label: 'Trucks',
            ),
          ],
        ),
      ),
      floatingActionButton: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: _index * 0.4),
        duration: _kAnimDuration,
        builder: (context, angle, child) =>
            Transform.rotate(angle: angle, child: child),
        child: FloatingActionButton(
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.edit, arguments: null),
          tooltip: 'Add vehicle',
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
