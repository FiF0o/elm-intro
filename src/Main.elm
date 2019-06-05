module Main exposing (Model, Msg(..), Page(..), init, initialPage, main, setRouteWithModel, update, updatePage, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Decode exposing (Value)
import Layout exposing (ActivePage)
import Page.Article as Article
import Page.Register as Register
import Route exposing (..)
import Url exposing (Url)


type Page
    = Article Article.Model
    | Register Register.Model


type alias Model =
    { page : Page
    , key : Nav.Key
    , url : Url.Url
    }


type Msg
    = SetRouteMsg (Maybe Route)
    | ArticleMsg Article.Msg
    | RegisterMsg Register.Msg
    | ChangeUrl Url
    | ClickedLink Browser.UrlRequest


setRouteWithModel : Maybe Route -> Model -> ( Model, Cmd Msg )
setRouteWithModel maybeRoute model =
    case maybeRoute of
        Nothing ->
            ( model, Cmd.none )

        Just Route.Article ->
            ( { model | page = Article Article.init }, Cmd.none )

        Just Route.Register ->
            ( { model | page = Register Register.init }, Cmd.none )


updatePage : Page -> Msg -> Model -> ( Model, Cmd Msg )
updatePage page msg model =
    let
        toPage toModel toMsg subUpdate subMsg subModel =
            let
                ( newModel, newCmd ) =
                    subUpdate subMsg subModel
            in
            ( { model | page = toModel newModel }, Cmd.map toMsg newCmd )
    in
    case ( msg, page ) of
        ( SetRouteMsg maybeRoute, _ ) ->
            setRouteWithModel maybeRoute model

        ( ArticleMsg subMsg, Article subModel ) ->
            toPage Article ArticleMsg Article.update subMsg subModel

        ( RegisterMsg subMsg, Register subModel ) ->
            toPage Register RegisterMsg Register.update subMsg subModel

        ( _, _ ) ->
            -- model => Cmd.none
            ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case ( msg, model ) of
        ( ClickedLink urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    case url.fragment of
                        Nothing ->
                            ( model, Cmd.none )

                        Just _ ->
                            ( model
                            , Nav.pushUrl model.key (Url.toString url)
                            )


view : Model -> Browser.Document Msg
view model =
    let
        renderLayout =
            Layout.renderView
    in
    case model.page of
        Article subModel ->
            Article.view subModel
                |> renderLayout Layout.Article
                |> Html.map ArticleMsg

        Register subModel ->
            Register.view subModel
                |> renderLayout Layout.Register
                |> Html.map RegisterMsg


initialPage : Page
initialPage =
    Article Article.init


init : Url -> Nav.Key -> ( Model, Cmd Msg )
init url location =
    setRouteWithModel (Route.fromUrl location) (Model initialPage url location)


main : Program Url Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangeUrl
        , onUrlRequest = ClickedLink
        }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none
