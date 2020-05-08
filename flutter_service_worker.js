'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "04599499e73adb28856aaf678f5dd735",
"assets/assets/fonts/NotoSerif-Regular.ttf": "d1c72e0e788cf2bbc1de53da57599bec",
"assets/FontManifest.json": "c3599b5a554bc5eefcd7b897774b68a8",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/LICENSE": "200ab728138221bb35ceedc9708a6c04",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "1b32834118e18d3d363ebc543a6f7e6d",
"/": "1b32834118e18d3d363ebc543a6f7e6d",
"main.dart.js": "24898aed1e5ffbedf6faa5e98224c880",
"manifest.json": "983c424a628286e02f546b063b853359"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
