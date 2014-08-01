/**
 * This file for showing the map in detail result
 *
 */
var ready = function() {

	// get the coordinate
	var placeName = $('#place-name').text();
	var cityName = $('#city-name').text();
	var countryName = $('#country-name').text();

	if (cityName) {
		var completeAddress = placeName + ', ' + cityName + ', ' + countryName;
	} else {
		var completeAddress = placeName + ', '  + countryName;
	}
	/*
	 * Deprecated: use `arcgis` instead 
	 */
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

	/*
	 * Find address using ArcGIS geocode
	 */
	var arcgis = function(completeAddress, placeName) {
		$.getJSON('http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/find?text='+completeAddress+'&f=json', function(res) {
			
			if(res.locations.length > 0) {
				var map = L.map('map').setView([res.locations[0].feature.geometry.y, res.locations[0].feature.geometry.x], 15);

				// create the tile layer
				var osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
				var osmAttrib='Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors';
				var osm = new L.TileLayer(osmUrl, {minZoom: 8, maxZoom: 17, attribution: osmAttrib});

				map.addLayer(osm);

				// add a marker in the given location, attach some popup content to it and open the popup
				L.marker([res.locations[0].feature.geometry.y, res.locations[0].feature.geometry.x]).addTo(map).bindPopup(placeName).openPopup();
			} else {
				$('#map').html('<p>Place location can\'t be found.</p>');
			}
		});
	};

	arcgis(completeAddress, placeName);
};

$(document).ready(ready);
$(document).on('page:load', ready);