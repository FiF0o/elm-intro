module Layout exposing (ActivePage(..), renderView)

import Browser exposing (Document)
import Html exposing (Html, a, button, div, footer, i, img, li, nav, p, span, text, ul)
import Html.Attributes exposing (class, classList, href, style)
import Html.Events exposing (onClick)
import Route exposing (Route)


type ActivePage
    = Other
    | Home
    | Register
    | Article


renderView : ActivePage -> { title : String, content : Html msg } -> Document msg
renderView page { title, content } =
    { title = title ++ " - Conduit"
    , body = viewHeader page :: content :: [ viewFooter ]
    }


viewHeader : ActivePage -> Html msg
viewHeader page =
    nav [ class "navbar navbar-light" ]
        [ div [ class "container" ]
            [ a [ class "navbar-brand", Route.href Route.Home ]
                [ text "conduit" ]
            , ul [ class "nav navbar-nav pull-xs-right" ] <|
                navbarLink page Route.Home [ text "Home" ]
                    :: viewMenu page
            ]
        ]


navbarLink : ActivePage -> Route -> List (Html msg) -> Html msg
navbarLink page route linkContent =
    li [ classList [ ( "nav-item", True ), ( "active", isActive page route ) ] ]
        [ a [ class "nav-link", Route.href route ] linkContent ]


viewFooter : Html msg
viewFooter =
    footer []
        []


isActive : ActivePage -> Route -> Bool
isActive page route =
    case ( page, route ) of
        ( Home, Route.Home ) ->
            True

        ( Register, Route.Register ) ->
            True

        ( Article, Route.Article ) ->
            True

        _ ->
            False


viewMenu : ActivePage -> List (Html msg)
viewMenu page =
    let
        linkTo =
            navbarLink page
    in
    [ linkTo Route.Register [ text "Sign up" ]
    , linkTo Route.Article [ text "Articles" ]
    , linkTo Route.Home [ text "home" ]
    ]
