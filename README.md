###Sitemap

Generate Sitemaps easily:

```dart
var sitemap = new Sitemap();

var entry = new SitemapEntry()
  ..location = 'http://foo.bar/baz'
  ..priority = 0.75;

sitemap.entries.add(entry);

print(sitemap.generate());
```