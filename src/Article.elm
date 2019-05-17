module Article exposing (feed, tags)


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
