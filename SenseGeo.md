DELETE /my_locations

GET /my_locations/location/_mapping

PUT /my_locations
{
    "mappings": {
        "location": {
            "properties": {
                "pin": {
                    "properties": {
                        "location": {
                            "type": "geo_point"
                        },
                        "tag": {
                            "type": "string"
                         },
                         "title": {
                            "type": "string"
                         }
                    }
                }
            }
        }
    }
}

PUT /my_locations/location/1
{
    "pin" : {
        "location" : {
            "lat" : 59.317864,
            "lon" : 18.08589
        },
        "title": "Fotografiska",
        "tag": ["museum"]
    }
}

PUT /my_locations/location/2
{
    "pin" : {
        "location" : {
            "lat" : 59.326841,
            "lon" : 18.071651
        },
        "title": "Tre Kronor",
        "tag": ["castle"]
    }
}

POST /my_locations/location/_search
{
    "query": {
        "bool" : {
            "should" : [
                { "term" : { "pin.tag" : "museum" } }
            ],            
            "filter" : {
                "geo_distance" : {
                    "distance" : "3000m",
                    "pin.location" : {
                        "lat" : 59.332401,
                        "lon" : 18.064442
                    }
                }
            },
            "minimum_should_match" : 1
        }
    }
}