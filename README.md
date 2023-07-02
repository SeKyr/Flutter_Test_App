# flutter_test_app

A new Flutter project to test the capabilities of the flutter framework.

## WEB

### Compile and Minify for Production (Canvas)

```sh
flutter build web --web-renderer canvaskit
```

### Compile and Minify for Production (HTML)

```sh
flutter build web --web-renderer html
```

### Run production build locally

```sh
npm install express --no-save
node webserver.js
```

URL: http://localhost:4200

## Android

### Build Android Release-APK

```sh
flutter run --release
```

