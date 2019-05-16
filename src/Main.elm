module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import List exposing (map)


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


renderFeed =
    div [ class "feed-toggle" ] [ text "todo later" ]


main =
    let
        tags =
            [ "elm", "tag2", "vier" ]
    in
    div [ class "home-page" ]
        [ div [] [ renderBanner ]
        , div [ class "container page" ]
            [ div [ class "row" ]
                [ div [ class "col-md-9" ] [ renderFeed ]
                , div [ class "col-md-3" ]
                    [ div [ class "sidebar" ]
                        [ p [] [ text "Popular Tags" ]
                        , viewTags tags
                        ]
                    ]
                ]
            ]
        ]
