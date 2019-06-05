module Page.Article exposing (Article, Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List exposing (filter, map, member)


initialModel =
    { tags = tagList
    , selectedTag = "elm"
    , articlesFeed = feed
    }


tagList =
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


type Msg
    = ClickedTag String


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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedTag tag ->
            ( { model | selectedTag = tag }, Cmd.none )


viewTags : String -> List String -> Html Msg
viewTags selectedTag tags =
    let
        renderedTags =
            map (renderTag selectedTag) tags
    in
    div [ class "tag-list" ] renderedTags


renderTag : String -> String -> Html Msg
renderTag selectedTag tagName =
    let
        otherCssClass =
            if tagName == selectedTag then
                "tag-selected"

            else
                "tag-default"
    in
    button [ class ("tag-pill " ++ otherCssClass), onClick (ClickedTag tagName) ] [ text tagName ]


renderArticle : Article -> Html Msg
renderArticle article =
    div [ class "article-preview" ]
        [ h1 [] [ text article.title ]
        , p [] [ text article.description ]
        , span [] [ text "Read more..." ]
        ]



-- renderBanner : Html Msg
-- renderBanner =
--     div [ class "banner" ]
--         [ div [ class "container" ]
--             [ h1 [ class "logo-font" ] [ text "Conduit" ]
--             , p [] [ text "A place to share your knowledge" ]
--             ]
--         ]


view : Model -> Html Msg
view model =
    let
        articles =
            filter (\a -> member model.selectedTag a.tags) model.articlesFeed

        articleFeed =
            map renderArticle articles
    in
    div [ class "home-page" ]
        [ -- div [] [ renderBanner ],
          div [ class "container page" ]
            [ div [ class "row" ]
                [ div [ class "col-md-9" ] articleFeed
                , div [ class "col-md-3" ]
                    [ div [ class "sidebar" ]
                        [ p [] [ text "Popular Tags" ]
                        , viewTags model.selectedTag model.tags
                        ]
                    ]
                ]
            ]
        ]


init : Model
init =
    initialModel


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
