module Main exposing (main)

import Article as Articles
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List exposing (filter, map, member)


initialModel =
    { tags = Articles.tags
    , selectedTag = "elm"
    , articlesFeed = Articles.feed
    }


type alias Model =
    Articles.Model


type Msg
    = ClickedTag String


update msg model =
    case msg of
        ClickedTag tag ->
            ( { model | selectedTag = tag }, Cmd.none )


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
    button [ class ("tag-pill " ++ otherCssClass), onClick (ClickedTag tagName) ] [ text tagName ]


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


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, Cmd.none )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
