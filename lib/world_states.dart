import 'package:covid_19/Models/WorldSTateModels.dart';
import 'package:covid_19/details.dart';
import 'package:covid_19/services/stateServices.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: camel_case_types
class World_states extends StatefulWidget {
  const World_states({Key? key}) : super(key: key);

  @override
  State<World_states> createState() => _World_statesState();
}

// ignore: camel_case_types
class _World_statesState extends State<World_states>
    with TickerProviderStateMixin {
  StateServices stateservices = StateServices();
  late final controler =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              FutureBuilder(
                future: stateservices.getWorldStateRecords(),
                builder: (context, AsyncSnapshot<WorldSTateModels> snapshot) {
                  if (snapshot.hasData) {
                    return Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PieChart(
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "deaths":
                                double.parse(snapshot.data!.deaths.toString())
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          colorList: colorList,
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              useableRow(
                                  title: "Total",
                                  value: snapshot.data!.cases.toString()),
                              useableRow(
                                  title: "Deaths",
                                  value: snapshot.data!.deaths.toString()),
                              useableRow(
                                  title: "Recovered",
                                  value: snapshot.data!.recovered.toString()),
                              useableRow(
                                  title: "Active",
                                  value: snapshot.data!.active.toString()),
                              useableRow(
                                  title: 'Critical',
                                  value: snapshot.data!.critical.toString()),
                              useableRow(title: "Population", value: snapshot.data!.population.toString()),
                              useableRow(title: 'Tests', value: snapshot.data!.tests.toString())
                            ],
                          ),
                        ),
                      )
                    ]);
                  } else {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          controller: controler,
                          color: Colors.white,
                          size: 50.0,
                        ));
                  }
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Details(),
                        ));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.green, fixedSize: const Size(300, 50)),
                  child: const Text('Track Contries'))
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class useableRow extends StatelessWidget {
  String title, value;
  useableRow({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          const Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
