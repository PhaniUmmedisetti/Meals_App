import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function(Map<String, bool>) saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.saveFilters, this.currentFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenfree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactosefree = false;

  @override
  void initState() {
    _glutenfree = widget.currentFilters['gluten'] ?? false;
    _lactosefree = widget.currentFilters['lactose'] ?? false;
    _vegan = widget.currentFilters['vegan'] ?? false;
    _vegetarian = widget.currentFilters['vegetarian'] ?? false;
    super.initState();
  }

  Widget _buildSwitchListTitle(
    String title,
    String description,
    bool currentValue,
    updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Filters',
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                final Map<String, bool> selectedFilters = {
                  'gluten': _glutenfree,
                  'lactose': _lactosefree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan,
                };
                widget.saveFilters(selectedFilters);
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTitle(
                  'Gluten-free',
                  'Only include gluten-free meals',
                  _glutenfree,
                  (newValue) {
                    setState(
                      () {
                        _glutenfree = newValue;
                      },
                    );
                  },
                ),
                if (_lactosefree != null)
                  _buildSwitchListTitle(
                    'Lactose-free',
                    'Only include lactose-free meals',
                    _lactosefree,
                    (newValue) {
                      setState(
                        () {
                          _lactosefree = newValue;
                        },
                      );
                    },
                  ),
                _buildSwitchListTitle(
                  'Vegetarian',
                  'Only include vegetarian meals',
                  _vegetarian,
                  (newValue) {
                    setState(
                      () {
                        _vegetarian = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTitle(
                  'Vegan',
                  'Only include vegan meals',
                  _vegan,
                  (newValue) {
                    setState(
                      () {
                        _vegan = newValue;
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
