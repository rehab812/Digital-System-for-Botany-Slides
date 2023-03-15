
import 'package:flutter/material.dart';
import 'package:our_test_project/core/custom_widgets/plants_card_item.dart';
import 'package:our_test_project/core/styles/colors.dart';
import 'package:our_test_project/models/plants_models.dart';

class MobileHomeView extends StatefulWidget {
  static const String routeName = "MobileHomeView";

  MobileHomeView({super.key});

  @override
  State<MobileHomeView> createState() => _MobileHomeViewState();
}

class _MobileHomeViewState extends State<MobileHomeView> {
  final FocusNode _node = FocusNode();
  var _searchTextController = TextEditingController();
  List<String>? itemsListSearch;

  List<String> PlantsName=[
    'Diatoms',
    'Fucus',
    'Nitella',
    'Notoc',
    'Adiantum',
    'Dryopteris',
    'Marsilea',
    'Pilularia',
    'Pteris',
    'Riccia',
    'Sphangnum',
    'Cycas',
    'Pinus',
    'Canna',
    'Aloe',
    'Cyperus',
    'Iris',
    'Musa',
  ];

  List<PlantsModel> plantsList = [
    PlantsModel(
        plant_image: 'assets/images/myPlant.png', plant_name: 'Diatoms'),
    PlantsModel(plant_image: 'assets/images/myPlant.png', plant_name: 'Fucus'),
    PlantsModel(
        plant_image: 'assets/images/myPlant.png', plant_name: 'Nitella'),
    PlantsModel(plant_image: 'assets/images/myPlant.png', plant_name: 'Notoc'),
    PlantsModel(
        plant_image: 'assets/images/myPlant.png', plant_name: 'Adiantum'),
    PlantsModel(
        plant_image: 'assets/images/myPlant.png', plant_name: 'Dryopteris'),
    PlantsModel(
        plant_image: 'assets/images/myPlant.png', plant_name: 'Marsilea'),
    PlantsModel(
        plant_image: 'assets/images/myPlant.png', plant_name: 'Sphangnum'),
    PlantsModel(plant_image: 'assets/images/myPlant.png', plant_name: 'Pteris'),
    PlantsModel(
        plant_image: 'assets/images/myPlant.png', plant_name: 'Sphangnum'),
    PlantsModel(plant_image: 'assets/images/myPlant.png', plant_name: 'Cycas'),
    PlantsModel(
        plant_image: 'assets/images/myPlant.png', plant_name: 'Sphangnum'),
  ];

  void dispose() {
    super.dispose();
    _node.dispose();
    _searchTextController?.dispose();
  }

  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchTextController?.addListener(() {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7.0),
                          child: const Text(
                            "Let's Find \nYour Slide!",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),

                        ///New Code for Search
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: MyColors.lightGray),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  itemsListSearch = PlantsName
                                      .where((element) => element
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList();
                                  if (_searchTextController!.text.isNotEmpty &&
                                      itemsListSearch!.isEmpty) {
                                    print(
                                        'itemsListSearch legnth${itemsListSearch!.length}');
                                  }
                                });
                              },
                              controller: _searchTextController,
                              focusNode: _node,
                              decoration: InputDecoration(
                                  hintText: 'Find_Your_Slide ',
                                  hintStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed:
                                        _searchTextController!.text.isEmpty
                                            ? null
                                            : () {
                                                _searchTextController?.clear();
                                                _node.unfocus();
                                              },
                                    icon: Icon(
                                      Icons.cancel,
                                      color:
                                          _searchTextController!.text.isNotEmpty
                                              ? Colors.red
                                              : Colors.grey,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        _searchTextController!.text.isNotEmpty && itemsListSearch!.isEmpty
                            ? Column(
                              children: [
                                            Container(
                                              height: MediaQuery.of(context).size.height*0.65,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image:AssetImage('assets/images/noResult.jpg',),
                                                  fit: BoxFit.cover,
                                                )
                                              ),
                                            )
                              ],
                            )

                            :
                             /// plants Show
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.73,
                                child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 5,
                                      childAspectRatio: 1,
                                    ),
                                    itemCount:
                                        _searchTextController.text.isEmpty
                                            ? plantsList.length
                                            : itemsListSearch!.length,
                                    itemBuilder: (context, index) =>
                                        _searchTextController.text.isEmpty
                                            ? PlantsCardItem(
                                                plantsModel: plantsList[index])
                                            : PlantsCardItem(
                                                plantsModel:
                                                    plantsList[index])),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
