POST _search
{
   "query": {
      "match_all": {}
   }
}

PUT /blog/recept/1
{ 
    "title": "one",
    "tag":  [ 
        {
            "name":"one",
            "alter": "ett"
        },
        {
            "name":"two"
        },
        {
            "name":"three"
        }
    ]
}

PUT /blog/recept/2
{ 
    "title": "two",
    "tag":  [ 
        {
            "name":"one",
            "alter": "ett"
        },
        {
            "name":"two"
        }
    ]
}

POST blog/_search
{
 "query": {
    "bool" : {
        "should" : [
            { "term" : { "tag.name" : "ett" } },
            { "term" : { "tag.name" : "three" } },
            { "term" : { "tag.alter" : "ett" } },
            { "term" : { "tag.alter" : "three" } }
        ],
        "minimum_should_match" : 2
   }
 }
}