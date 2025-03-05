4. Handling No-Internet UI
   When the interceptor detects no internet, it rejects the request with an error. You can:

Catch the error at the repository or UI level and display a "No internet" message.
Or use ConnectivityListener in your Flutter UI to monitor when the user goes offline/online.
Example UI Handling
dart
Copy
Edit

```
try {
  final result = await ApiService.postForm('someEndpoint.php', {...});
  // process result
} catch (e) {
  if (e is DioError && e.error == 'No internet connection available') {
    // Show a SnackBar or a custom "No internet" UI
  } else {
    // Other errors
  }
}

```
