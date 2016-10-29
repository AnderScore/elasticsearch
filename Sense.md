POST _search
{
   "query": {
      "match_all": {}
   }
}
    
PUT /blog/post/1
{ 
    "user": "dilbert", 
    "postDate": "2011-12-15", 
    "body": "Search is hard. Search should be easy." ,
    "title": "On search"
}

PUT /blog/stuff/1
{ 
    "title": "one",
    "tag":  [ "one", "two", "three" ]
}

PUT /blog/stuff/2
{ 
    "title": "two",
    "tag":  [ "one", "two" ]
}

POST blog/_search
{
  "query": {
    "match": {
      "tag": "one" 
    }
  }
}

POST blog/_search
{
 "query": {
  "terms": {
        "tag": [ "one", "three" ],
        "minimum_should_match": 2
   }
 }
}