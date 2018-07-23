library sitemap;

import 'package:intl/intl.dart';
import 'package:xml/xml.dart';

/// Represents an entire Sitemap file.
class Sitemap {
  String stylesheetPath;

  List<SitemapEntry> entries = [];

  String generate() {
    final dateFormatter = new DateFormat('yyyy-MM-dd');

    final root = new XmlElement(new XmlName('urlset'), [
      new XmlAttribute(
          new XmlName('xmlns'), 'http://www.sitemaps.org/schemas/sitemap/0.9')
    ]);

    for (final entry in entries) {
      final url = new XmlElement(new XmlName('url'));

      final location = new XmlElement(new XmlName('loc'));
      location.children.add(new XmlText(entry.location));
      url.children.add(location);

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
  String changeFrequency = 'yearly';
  num priority = 0.5;
}
