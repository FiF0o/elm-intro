module Main exposing (main)

import Article as Articles exposing (..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List exposing (filter, map, member)


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
    { title : String
    , description : String
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


viewTags selectedTag tags =
    let
        renderedTags =
            map (renderTag selectedTag) tags
    in
    div [ class "tag-list" ] renderedTags


renderTag selectedTag tagName =
    let
        otherCssClass =
            if tagName == selectedTag then
                "tag-selected"

            else
                "tag-default"
    in
    button [ class ("tag-pill " ++ otherCssClass), onClick { description = "ClickedTag", data = tagName } ] [ text tagName ]


renderBanner =
    div [ class "banner" ]
        [ div [ class "container" ]
            [ h1 [ class "logo-font" ] [ text "Conduit" ]
            , p [] [ text "A place to share your knowledge" ]
            ]
        ]


renderArticle article =
    div [ class "article-preview" ]
        [ h1 [] [ text article.title ]
        , p [] [ text article.description ]
        , span [] [ text "Read more..." ]
        ]


view model =
    let
        articles =
            filter (\a -> member model.selectedTag a.tags) model.articlesFeed

        articleFeed =
            map renderArticle articles
    in
    div [ class "home-page" ]
        [ div [] [ renderBanner ]
        , div [ class "container page" ]
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


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
