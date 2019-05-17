module Main exposing (main)

import Article as Articles exposing (..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List exposing (map)


type alias Model =
    { tags : List String
    , selectedTag : String
    , articlesFeed : List Article
    }


initialModel =
    { tags = Articles.tags
    , selectedTag = "elm"
    , articlesFeed = Articles.feed
    }


type alias Article =
    { description : String
    , tags : List String
    }


type alias Msg =
    { description : String
    , data : String
    }


update msg model =
    if msg.description == "ClickedTag" then
        { model | selectedTag = msg.data }

    else
        model


viewTags tags =
    let
        renderedTags =
            map renderTag tags
    in
    div [ class "tag-list" ] renderedTags


renderTag tagName =
    button [ class "tag-pill tag-default" ] [ text tagName ]


renderBanner =
    div [ class "banner" ]
        [ div [ class "container" ]
            [ h1 [ class "logo-font" ] [ text "Conduit" ]
            , p [] [ text "A place to share your knowledge" ]
            ]
        ]


renderArticles articles =
    let
        renderedArticles =
            map renderArticle articles
    in
    ul [ class "some class" ] renderedArticles


renderArticle article =
    li []
        [ text article.description

        -- render tags later--
        ]


view model =
    div [ class "home-page" ]
        [ div [] [ renderBanner ]
        , div [ class "container page" ]
            [ div [ class "row" ]
                [ div [ class "col-md-9" ] [ renderArticles model.articlesFeed ]
                , div [ class "col-md-3" ]
                    [ div [ class "sidebar" ]
                        [ p [] [ text "Popular Tags" ]
                        , viewTags model.tags
                        ]
                    ]
                ]
            ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
