'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-192.png": "2506c347f81408b5fd9683626646defd",
"icons/logo.png": "28e89bd8ec9d23c7c322d3b3ef2652f5",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"assets/packages/syncfusion_flutter_datagrid/assets/font/FilterIcon.ttf": "b8e5e5bf2b490d3576a9562f24395532",
"assets/packages/syncfusion_flutter_datagrid/assets/font/UnsortIcon.ttf": "acdd567faa403388649e37ceb9adeb44",
"assets/AssetManifest.bin": "37293087965ae7593547a883d0dcf7ec",
"assets/fonts/MaterialIcons-Regular.otf": "3c76511e3526fa5298716d72d6394906",
"assets/AssetManifest.json": "55f0241c3f6aeee904f89c1c212f8247",
"assets/FontManifest.json": "6bf336df0398e988fcea0edf135a0499",
"assets/assets/icons/cross.svg": "f0a987ba8c4cb46e011af9ac32d64f9f",
"assets/assets/icons/cabinets.svg": "139a8b89668030ee3f54821d6c35fbac",
"assets/assets/icons/notification.svg": "488553207b0f016f6f0f6341b044a864",
"assets/assets/icons/menu.svg": "d35e4af8319c31969018c9f5674f1259",
"assets/assets/icons/light.svg": "0a682feaa724702f428bf9d9a769d841",
"assets/assets/icons/teacher.svg": "10235728c7f6997a83f6a05c78c6509c",
"assets/assets/icons/success.svg": "5db055d3659acfeb568f7cad54fd5639",
"assets/assets/icons/debug.svg": "345a1d35a324881d19bd6afd1e3b4ade",
"assets/assets/icons/book.svg": "50ac7027126eeeb1baa37dfa959f96ab",
"assets/assets/icons/warning.svg": "f175e0da0424656437543de2145eccfb",
"assets/assets/icons/error.svg": "751e498af6471dbcb560e25a1f26cf63",
"assets/assets/icons/eye_closed.svg": "85115598e42a3504bc09068ffbd301ed",
"assets/assets/icons/calendar.svg": "fca432a60934c5e7857f75093bd23481",
"assets/assets/icons/edit.svg": "48e44a2c0eb3c1c0033781cdae3d17bf",
"assets/assets/icons/eye_open.svg": "f974608b0c2a498aebe0ef48ca5bf17e",
"assets/assets/icons/refresh.svg": "94e36ff8d5530f82b1a5cdae9ddeecd2",
"assets/assets/icons/arrow_left.svg": "d15018dd81ac27168a063c9e92c4e65b",
"assets/assets/icons/persons.svg": "9dbfe2265b97e102043f247a25ec5eda",
"assets/assets/icons/test.svg": "ec8547377c7a4ee1ce583b032179fd3c",
"assets/assets/icons/arrow_right.svg": "a0625584f7ff802849dcfe80b226d1cb",
"assets/assets/icons/home.svg": "f0ff94391648d645fed66700ce8f6e3a",
"assets/assets/icons/plus.svg": "b7d6d41ba2c2c4ff0e9fc2da2c3df37c",
"assets/assets/icons/settings.svg": "bf5e3c669b53daa2ff3524dd33c66fed",
"assets/assets/icons/clear.svg": "0d936413f06506879c450360153ac4db",
"assets/assets/icons/dark.svg": "30bd719be69d1d34868cd48360451963",
"assets/assets/icons/info.svg": "3aeda2da8c9205841ae9a9de3bd9845e",
"assets/assets/icons/admin.svg": "39d34d7f8cba6284cb6a5868ff9dd681",
"assets/assets/images/logo.png": "28e89bd8ec9d23c7c322d3b3ef2652f5",
"assets/NOTICES": "caf1d8494b2af646e5e6d4cf785c83aa",
"assets/AssetManifest.bin.json": "438848ca15fe2271cbaf033c0a57d427",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"manifest.json": "1e6a10be38424a3d64275ca1d3714a18",
"index.html": "9c7d45df7e9ea465c044e50e1d314ab2",
"/": "9c7d45df7e9ea465c044e50e1d314ab2",
"version.json": "9ce91addfdad4642e476c67244b98219",
"flutter_bootstrap.js": "803b5074ae67cf61bc9629ad621f4509",
"main.dart.js": "88833386ac00b40565dfeb17859b6780",
"favicon.png": "0edcf9b037910956712c5221731e7895"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
