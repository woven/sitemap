import 'package:sitemap/sitemap.dart';

void main() {
  final sitemap = new Sitemap();

  sitemap.entries.add(new SitemapEntry()
    ..location = 'http://foo.bar/baz'
    ..priority = 0.75
    ..addAlternate('en', 'http://foo.bar/baz')
    ..addAlternate('fr', 'http://foo.bar/fr/baz')
    ..addAlternate('de', 'http://de.foo.bar/baz')
    ..addAlternate('pt-Br', 'http://brazilianfoo.bar/baz'));

  print(sitemap.generate());
}
