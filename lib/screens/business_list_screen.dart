import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/business_provider.dart';
import '../widgets/card_widget.dart';
import '../widgets/state_widgets.dart';

class BusinessListScreen extends StatefulWidget {
  const BusinessListScreen({super.key});

  @override
  State<BusinessListScreen> createState() => _BusinessListScreenState();
}

class _BusinessListScreenState extends State<BusinessListScreen> {
  @override
  void initState() {
    super.initState();
    // Load businesses when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BusinessProvider>().loadBusinesses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Businesses'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<BusinessProvider>().refresh();
            },
            tooltip: 'Refresh',
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'offline':
                  context.read<BusinessProvider>().loadCachedBusinesses();
                  break;
                case 'clear_cache':
                  context.read<BusinessProvider>().refresh();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'offline',
                child: Row(
                  children: [
                    Icon(Icons.offline_bolt),
                    SizedBox(width: 8),
                    Text('Load Offline'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear_cache',
                child: Row(
                  children: [
                    Icon(Icons.clear_all),
                    SizedBox(width: 8),
                    Text('Clear Cache'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<BusinessProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const LoadingWidget(message: 'Loading businesses...');
          }

          if (provider.hasError) {
            return ErrorStateWidget(
              message: provider.errorMessage,
              onRetry: () => provider.retry(),
            );
          }

          if (provider.isEmpty) {
            return EmptyWidget(
              message: 'No businesses found',
              icon: Icons.business_outlined,
              onRetry: () => provider.retry(),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.refresh(),
            child: ListView.builder(
              itemCount: provider.businesses.length,
              itemBuilder: (context, index) {
                final business = provider.businesses[index];
                return BusinessCard(
                  business: business,
                  onTap: () => _showBusinessDetails(context, business),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showBusinessDetails(BuildContext context, dynamic business) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(business.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(Icons.location_on, 'Location', business.location),
            const SizedBox(height: 8),
            _buildDetailRow(Icons.phone, 'Contact', business.contactNumber),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Here you could implement calling functionality
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Calling ${business.contactNumber}...'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.phone),
            label: const Text('Call'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(value),
            ],
          ),
        ),
      ],
    );
  }
}
