# simple_shared_pref

helper package for easily access to shared preference

## Getting Started

Fast and easy use for it create enum file and use it's values as keys
Example
```groovy

enum SharedPrefEnum{
  name, id, selected, price, namesList
}

```

Methods to set
Example
```groovy

    await SimpleSharedPref()
        .setInt(value: 2, key: SharedPrefEnum.id.toString());
    await SimpleSharedPref().setDouble(
        value: 2.2,
        key: SharedPrefEnum.price.toString());
    await SimpleSharedPref()
        .setBool(value: true, key: SharedPrefEnum.selected.toString());
    await SimpleSharedPref()
        .setString(value: 'Product', key: SharedPrefEnum.name.toString());
    await SimpleSharedPref().setStringList(
        value: ['Product1', 'Product2', 'Product3'],
        key: SharedPrefEnum.namesList.toString());

```

Methods to get
Example
```groovy

  SimpleSharedPref().getInt(key: SharedPrefEnum.id.toString())!.toString();
  SimpleSharedPref().getDouble(key: SharedPrefEnum.price.toString())!.toString();
  SimpleSharedPref().getString(key: SharedPrefEnum.name.toString())!.toString();
  SimpleSharedPref().getBool(key: SharedPrefEnum.selected.toString())!.toString();
  SimpleSharedPref().getStringList(key: SharedPrefEnum.namesList.toString())!.toString();

```

Methods others methods
Example
```groovy

  SimpleSharedPref().contain(key: SharedPrefEnum.namesList.toString());
  SimpleSharedPref().pref // return shared preference object 

```