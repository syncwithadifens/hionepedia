'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "3a8978cebaca0d2e2def16ce35ec5720",
"splash/img/light-2x.png": "63473b231740ed2c2217931987fcea41",
"splash/img/dark-4x.png": "c49b18c85507147d99bb7fbb70b18fe9",
"splash/img/light-3x.png": "fcdf5c0a4a37567c839d64a9f2fefea4",
"splash/img/dark-3x.png": "fcdf5c0a4a37567c839d64a9f2fefea4",
"splash/img/light-4x.png": "c49b18c85507147d99bb7fbb70b18fe9",
"splash/img/dark-2x.png": "63473b231740ed2c2217931987fcea41",
"splash/img/dark-1x.png": "b2ddf3f754d3fd5cd414179fb3073e4e",
"splash/img/light-1x.png": "b2ddf3f754d3fd5cd414179fb3073e4e",
"index.html": "b8df1975df1529afd5c11b929e1182c9",
"/": "b8df1975df1529afd5c11b929e1182c9",
"main.dart.js": "4eb522610640e8d2d771eeb9a3de7e47",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "7c595311b811c894368a823814cbe023",
"icons/icon-192.png": "5d44441e1ae95aaa8826e72e1a87992f",
"icons/icon-maskable-192.png": "cadafe2047ddf462886a38dd2e247604",
"icons/icon-maskable-512.png": "862201b46985ce56a657ab4afb0c0c82",
"icons/icon-512.png": "66039c063b653b39142d77cd2ba8c31a",
"manifest.json": "13bd95374afc56a1b95dcdc7c0090728",
"assets/AssetManifest.json": "0b72ba185390a176f9744e6d2d5b5fcc",
"assets/NOTICES": "9b3de7a01a99bbcc1c06f97258966612",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/packages/model_viewer_plus/assets/model-viewer.min.js": "fb3df9ef8e49b5e08b6afcb95521a52c",
"assets/packages/model_viewer_plus/assets/template.html": "8de94ff19fee64be3edffddb412ab63c",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.smcbin": "517dc56838a1616bcb994c8f95546985",
"assets/fonts/MaterialIcons-Regular.otf": "7aee80109ea8a4d6aec5bfc95ddb01fe",
"assets/assets/illustration/confuse.png": "2de43cc18e4c63dfedd50dbebc9f2bb6",
"assets/assets/illustration/splash.png": "316c90365d40a661c2bf8278ab6c0b9c",
"assets/assets/illustration/fury.png": "080f9a3c9331fb10a6ede1b02cbda171",
"assets/assets/illustration/error.png": "aac2d7d795a22d8f071d82deba945d1c",
"assets/assets/illustration/tryit.png": "5c7f913efd391bed0d165036dd05c9b3",
"assets/assets/illustration/vr.png": "c1dc73bb0af0d3c8c33eb06657de6608",
"assets/assets/illustration/favorite.png": "f63bbba1a8c3be8d28a8ef97ec80d30f",
"assets/assets/model/komodo_dragon.glb": "c477f22f57c2123ccfc315a4245d4ded",
"assets/assets/model/default_model.glb": "566d62f9e78c8378e1f1b63092e91046",
"assets/assets/model/badak_jawa.glb": "dd1a3640c1f16c86e8b520dd52444777",
"assets/assets/avatar/default_avatar.png": "732454a24782e38d7dfc19a47636c9ab",
"assets/assets/icon/sound.png": "9b8eccf9b91c0e2e85de5841a08b6894",
"assets/assets/icon/favorite.png": "e58f1696f5d0ea8b8e14c27632560b5b",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
