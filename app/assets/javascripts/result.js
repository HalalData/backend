/**
 * This file for showing the map in detail result
 *
 */
var ready = function() {

	// get the coordinate
	var placeName = $('#place-name').text();
	var cityName = $('#city-name').text();

	var process = function(placeName, cityName) {
		if (cityName === '') return false;

		$.getJSON('/map.json?city='+cityName+'&place='+placeName, function(res) {
			var map = L.map('map').setView([res.city_lat, res.city_lng], 10);

			// create the tile layer
			var osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
			var osmAttrib='Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors';
			var osm = new L.TileLayer(osmUrl, {minZoom: 8, maxZoom: 17, attribution: osmAttrib});

			map.addLayer(osm);

			// add geojson multipoint
			L.geoJson(res.venues).addTo(map);
		});
	};

	process(placeName, cityName);

};

$(document).ready(ready);
$(document).on('page:load', ready);