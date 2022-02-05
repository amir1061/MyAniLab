import 'package:flutter/material.dart';
import 'package:myanilab/Core/Models/chart_data.dart';
import 'package:myanilab/Core/Providers/token_provider.dart';
import 'package:myanilab/Core/Providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getUser();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            final scaffoldState =
                context.findRootAncestorStateOfType<ScaffoldState>()!;
            scaffoldState.openDrawer();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<TokenProvider>(
                context,
                listen: false,
              ).setToken(null);
              Provider.of<UserProvider>(
                context,
                listen: false,
              ).reset();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (_, userProvider, __) {
          if (userProvider.error != null) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                userProvider.error!.message,
                textAlign: TextAlign.center,
              ),
            );
          }
          if (userProvider.user == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final user = userProvider.user!;
          return ListView(
            children: [
              ExpansionTile(
                initiallyExpanded: true,
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryVariant,
                  backgroundImage:
                      user.picture != null ? NetworkImage(user.picture!) : null,
                  child: user.picture == null
                      ? const Icon(Icons.person, size: 30)
                      : null,
                ),
                title: Text(user.name),
                subtitle: Text('ID: ${user.id}'),
                expandedAlignment: Alignment.centerLeft,
                childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                children: [
                  if (user.gender != null) Text('Gender: ${user.gender!}'),
                  if (user.birthday != null)
                    Text(
                      'Birthday: ${user.birthday!.toIso8601String().split('T').first}',
                    ),
                  Text(
                    'Member since: ${user.joinedAt.toIso8601String().split('T').first}',
                  ),
                ],
              ),
              SfCircularChart(
                title: ChartTitle(
                  text: 'Anime stats',
                  alignment: ChartAlignment.near,
                ),
                series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(
                    dataSource: user.animeStatistics?.animeStatistics() ?? [],
                    xValueMapper: (data, _) => data.title,
                    yValueMapper: (data, _) => data.value,
                    dataLabelMapper: (data, _) =>
                        '${data.title}: ${data.value}',
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside,
                    ),
                  )
                ],
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                    widget: Text(
                      'Total: ${user.animeStatistics?.numItems ?? 0}',
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
