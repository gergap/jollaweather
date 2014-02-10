/* Project setting for wetter.com */
var project = "jollaweather";
var apikey = "1f96abed27a0e8e2c92b532a0cc4a79a";
//var project = "kde";
//var apiKey = "14747763f53dc0e27f42c945e96532ef";

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

