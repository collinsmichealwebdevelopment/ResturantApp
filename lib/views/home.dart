import 'package:first/models/recipe.api.dart';
import 'package:first/models/recipe.dart';
import 'package:first/views/widgets/recipe_card.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> _recipes;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();

    getRecipes();
  }

  Future<void> getRecipes() async{
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.restaurant_menu),
          SizedBox(width: 10),
          Text('The prestige lounge')
        ],),
      ),
        body: _isLoading
    ? Center(child: CircularProgressIndicator())
    : ListView.builder(
    itemCount: _recipes.length,
    itemBuilder: (context, index) {
      return RecipeCard(
      title: _recipes[index].name,
      cookTime: _recipes[index].totalTime,
    rating: _recipes[index].rating.toString(),
    thumbnailUrl: _recipes[index].images);
    },
        ));

  }
}