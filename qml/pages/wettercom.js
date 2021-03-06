/* Project setting for wetter.com */
var project = "jollaweather";
var apiKey = "1f96abed27a0e8e2c92b532a0cc4a79a";
var datadir = "/usr/share/harbour-jweather/";
var icondir = datadir+"icons/";

function mixedSearchUrl(search) {
    var input = project+apiKey+search;
    var md5 = Qt.md5(input);
    var url = "http://api.wetter.com/location/index/search/"+search+"/project/"+project+"/cs/"+md5;
    return url;
}

function nameSearchUrl(search) {
    var input = project+apiKey+search;
    var md5 = Qt.md5(input);
    var url = "http://api.wetter.com/location/name/search/"+search+"/project/"+project+"/cs/"+md5;
    return url;
}

function plzSearchUrl(search) {
    var input = project+apiKey+search;
    var md5 = Qt.md5(input);
    var url = "http://api.wetter.com/location/plz/search/"+search+"/project/"+project+"/cs/"+md5;
    return url;
}

function weatherUrl(city_code) {
    var input = project+apiKey+city_code;
    var md5 = Qt.md5(input);
    var url = "http://api.wetter.com/forecast/weather/city/"+city_code+"/project/"+project+"/cs/"+md5;
    return url;
}

