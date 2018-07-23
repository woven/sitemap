import 'package:sitemap/sitemap.dart';

void main() {
  final sitemap = new Sitemap();

  sitemap.entries.add(new SitemapEntry()
    ..location = 'http://foo.bar/baz'
    ..priority = 0.75);

  print(sitemap.generate());
}
