module Route exposing (Route(..), fromUrl, href, replaceUrl, routeToString, urlToParser)

import Browser.Navigation as Nav
import Html exposing (Attribute)
import Html.Attributes as Attr
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, oneOf, s, string)


type Route
    = Home
    | Register
    | Article


urlToParser : Parser (Route -> a) a
urlToParser =
    oneOf
        [ Parser.map Home (s "")
        , Parser.map Register (s "register")
        , Parser.map Article (s "article")
        ]


href : Route -> Attribute msg
href targetRoute =
    Attr.href (routeToString targetRoute)


replaceUrl : Nav.Key -> Route -> Cmd msg
replaceUrl key route =
    Nav.replaceUrl key (routeToString route)


fromUrl : Url -> Maybe Route
fromUrl url =
    -- The RealWorld spec treats the fragment like a path.
    -- This makes it *literally* the path, so we can proceed
    -- with parsing as if it had been a normal path all along.
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> Parser.parse urlToParser



-- INTERNAL


routeToString : Route -> String
routeToString page =
    let
        pagePath =
            case page of
                Home ->
                    []

                Register ->
                    [ "register" ]

                Article ->
                    [ "article" ]
    in
    "#/" ++ String.join "/" pagePath
