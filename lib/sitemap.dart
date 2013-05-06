library sitemap;

import 'package:intl/intl.dart';
import 'package:xml/xml.dart';

/**
 * Represents an entire Sitemap file.
 */
class Sitemap {
  String stylesheetPath;

  List<SitemapEntry> entries = [];

  String generate() {
    var dateFormatter = new DateFormat('yyyy-mm-dd');

    var root = new XmlElement('urlset');
    root.attributes['xmlns'] = 'http://www.sitemaps.org/schemas/sitemap/0.9';

    entries.forEach((entry) {
      var url = new XmlElement('url');

      var location = new XmlElement('loc');
      location.addChild(new XmlText(entry.location));
      url.addChild(location);

      var lastMod = new XmlElement('lastmod');
      lastMod.addChild(new XmlText(dateFormatter.format(entry.lastModified)));
      url.addChild(lastMod);

      var changeFrequency = new XmlElement('changefreq');
      changeFrequency.addChild(new XmlText(entry.changeFrequency));
      url.addChild(changeFrequency);

      var priority = new XmlElement('priority');
      priority.addChild(new XmlText(entry.priority.toString()));
      url.addChild(priority);

      root.addChild(url);
    });

    var stylesheet = '';
    if (stylesheetPath != null) {
      stylesheet = '<?xml-stylesheet type="text/xsl" href="$stylesheetPath"?>';
    }

    return '<?xml version="1.0" encoding="UTF-8"?>$stylesheet$root';
  }
}

/**
 * Represents a single Sitemap entry.
 */
class SitemapEntry {
  String location = '';
  DateTime lastModified = new DateTime.now();
  String changeFrequency = 'yearly';
  num priority = 0.5;
}