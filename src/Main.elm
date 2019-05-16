module Main exposing (main)

import Article as Articles exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import List exposing (map)


initialModel =
    { tags = Articles.tags
    , selectedTag = "elm"
    , articlesFeed = Articles.feed
    }


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


main =
    let
        tags =
            initialModel.tags
    in
    div [ class "home-page" ]
        [ div [] [ renderBanner ]
        , div [ class "container page" ]
            [ div [ class "row" ]
                [ div [ class "col-md-9" ] [ renderArticles initialModel.articlesFeed ]
                , div [ class "col-md-3" ]
                    [ div [ class "sidebar" ]
                        [ p [] [ text "Popular Tags" ]
                        , viewTags tags
                        ]
                    ]
                ]
            ]
        ]
