block TestWeatherSource
	import SolarTherm.Sources.Weather.WeatherSource;
	parameter String file = "resources/tests/weatherfile1.motab";
	WeatherSource wea(file=file);
end TestWeatherSource;
