// Service Worker for Kitchen Portion Calculator
var CACHE_NAME = 'portion-calc-v2.17.13';
var URLS_TO_CACHE = [
  './',
  './index.html',
  './manifest.json',
  './icon-192.png',
  './icon-512.png',
  'https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap'
];

async function installCache() {
  try {
    const cache = await caches.open(CACHE_NAME);
    await cache.addAll(URLS_TO_CACHE);
  } catch (e) { /* ignore — install proceeds */ }
}

self.addEventListener('install', function (event) {
  event.waitUntil(installCache());
  self.skipWaiting();
});

async function clearStaleCaches() {
  const names = await caches.keys();
  await Promise.all(
    names
      .filter(function (name) { return name !== CACHE_NAME; })
      .map(function (name) { return caches.delete(name); })
  );
}

self.addEventListener('activate', function (event) {
  event.waitUntil(clearStaleCaches());
  self.clients.claim();
});

async function networkAndUpdateCache(request) {
  const response = await fetch(request);
  if (response && response.ok) {
    const clone = response.clone();
    const cache = await caches.open(CACHE_NAME);
    cache.put(request, clone);
  }
  return response;
}

self.addEventListener('fetch', function (event) {
  if (event.request.method !== 'GET') return;
  event.respondWith((async function () {
    const cached = await caches.match(event.request);
    const networkPromise = networkAndUpdateCache(event.request).catch(function () { return cached; });
    return cached || networkPromise;
  })());
});
