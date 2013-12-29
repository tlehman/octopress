---
layout: post
title: "Country code TLDs using GeoJSON on Github"
date: 2013-12-28 17:17
comments: true
categories: [dataviz, GIS, standards, networking, vexillology]
---

There are more country code top-level domains (ccTLDs) than there are countries, that is because territories such as [Wallis and Futuna](https://en.wikipedia.org/wiki/Wallis_and_Futuna) has the ccTLD `.wf`, even though it's a French territory, not a country.

There are so many that I have a hard time remembering them, and given one it's hard to tell what country it belongs to, since [ISO 3166](http://www.iso.org/iso/country_codes) specifies that ccTLDs should be two characters long, that makes a maximum of 676 (26 squared) ccTLDs that could ever exist.

To solve the ccTLD→(Country/Territory)  problem, there is this great decoding table [here at iso.org](http://www.iso.org/iso/home/standards/country_codes/iso-3166-1_decoding_table.htm).

For the other problem, (Country/Territory)→ccTLD, I made the following map using [GeoJSON](http://geojson.org/)

<script src="https://gist.github.com/tlehman/8166180.js"></script>


