module Article exposing (Article, Model, feed, tags)


type alias Model =
    { tags : List String
    , selectedTag : String
    , articlesFeed : List Article
    }


type alias Article =
    { title : String
    , description : String
    , tags : List String
    }


tags =
    [ "elm", "tag2", "vier" ]


feed =
    [ { title = "a title"
      , description = "some description"
      , tags = [ "elm" ]
      }
    , { title = "another title"
      , description = "some other description"
      , tags = [ "vier" ]
      }
    , { title = "title"
      , description = "some description"
      , tags = [ "elm" ]
      }
    , { title = "title"
      , description = "some description"
      , tags = [ "tag2" ]
      }
    ]
