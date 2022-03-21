library sitemap;

import 'package:intl/intl.dart';
import 'package:xml/xml.dart';

/// Represents an entire Sitemap file.
class Sitemap {
  String? stylesheetPath;

  List<SitemapEntry> entries = [];

  String generate() {
    final dateFormatter = new DateFormat('yyyy-MM-dd');

    final root = new XmlElement(new XmlName('urlset'), [
      new XmlAttribute(
          new XmlName('xmlns'), 'http://www.sitemaps.org/schemas/sitemap/0.9'),
      new XmlAttribute(
          new XmlName('xmlns:xhtml'), 'http://www.w3.org/1999/xhtml')
    ]);

    for (final entry in entries) {
      final url = new XmlElement(new XmlName('url'));

      final location = new XmlElement(new XmlName('loc'));
      location.children.add(new XmlText(entry.location));
      url.children.add(location);

      url.children.addAll(entry.alternates
          .map<String, XmlNode>((String language, String location) =>
              new MapEntry<String, XmlNode>(
                  language,
                  new XmlElement(new XmlName('xhtml:link'), [
                    new XmlAttribute(new XmlName('rel'), 'alternate'),
                    new XmlAttribute(new XmlName('hreflang'), language),
                    new XmlAttribute(new XmlName('href'), location)
                  ])))
          .values);

      final lastMod = new XmlElement(new XmlName('lastmod'));
      lastMod.children
          .add(new XmlText(dateFormatter.format(entry.lastModified)));
      url.children.add(lastMod);

      final changeFrequency = new XmlElement(new XmlName('changefreq'));
      changeFrequency.children.add(new XmlText(entry.changeFrequency));
      url.children.add(changeFrequency);

      final priority = new XmlElement(new XmlName('priority'));
      priority.children.add(new XmlText(entry.priority.toString()));
      url.children.add(priority);

      root.children.add(url);
    }

    String stylesheet = '';
    if (stylesheetPath != null) {
      stylesheet = '<?xml-stylesheet type="text/xsl" href="$stylesheetPath"?>';
    }

    return '<?xml version="1.0" encoding="UTF-8"?>$stylesheet$root';
  }
}

/// Represents a single Sitemap entry.
class SitemapEntry {
  String location = '';
  DateTime lastModified = new DateTime.now();
  String changeFrequency = 'monthly';
  num priority = 0.5;
  final Map<String, String> _alternates = {};
  Map<String, String> get alternates => _alternates;
  void addAlternate(String language, String location) =>
      _alternates[language] = location;
}
