# SimpleSharedPref

SimpleSharedPref is a Flutter package that provides easy access to shared preferences. 
It follows the singleton design pattern, allowing you to conveniently store and retrieve 
data in shared preferences. It also supports optional encryption and decryption of sensitive data using the `CryptoModule` class.

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  simple_shared_pref: ^2.0.0
```
## Usage

Import the package and the SimpleSharedPref class in your Dart file:

```groovy
import 'package:simple_shared_pref/simple_shared_pref.dart';
```

Create an instance of SimpleSharedPref:

```groovy
SimpleSharedPref sharedPref = SimpleSharedPref();
```

Initialize the shared preferences by calling the init method.
It's recommended to do this in the main function or at the start of your application:

```groovy
void main()

async {
    WidgetsFlutterBinding.ensureInitialized();
    await sharedPref.init();
    runApp(MyApp());
}
```

# Storing and Retrieving Values

You can store and retrieve various types of values in shared preferences:

```groovy
// Store an integer value
sharedPref.setValue < int > ('counter', 10 );

// Retrieve the integer value
int ? counterValue = sharedPref.getValue < int > ('counter');

// Store a string value
sharedPref.setValue <String> ('username', 'JohnDoe' );

// Retrieve the string value
String ? username = sharedPref.getValue <String> ('username');

// Store a boolean value
sharedPref.setValue <bool> ('isLoggedIn', true );

// Retrieve the boolean value
bool ? isLoggedIn = sharedPref.getValue <bool> ('isLoggedIn');
```

# Removing a Value

To remove a value from shared preferences, you can use the removeValue method:

```groovy

sharedPref.removeValue('counter');
```

# Checking if a Value Exists

You can check if a value exists in shared preferences using the containsKey method:

```groovy

bool isUsernameStored = sharedPref.containsKey('username');

```

# Clearing Shared Preferences

To clear all values stored in shared preferences, use the clear method:

```groovy

sharedPref.clear();

```

# Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements,
please create an issue or submit a pull request on
the [GitHub repository](https://github.com/georgesamirmansour/simple_shared_pref) .

# License

This package is released under the [MIT License](https://opensource.org/license/mit/). See
the [LICENSE](https://github.com/georgesamirmansour/simple_shared_pref/blob/master/LICENSE) file for more
details.
