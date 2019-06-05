module Page.Register exposing (Form, Model, Msg(..), init, subscriptions, update, updateForm, view, viewForm)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { form : Form }


type alias Form =
    { email : String
    , username : String
    , password : String
    }


type Msg
    = EnteredEmail String
    | SubmittedForm


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        EnteredEmail email ->
            updateForm (\form -> { form | email = email }) model

        SubmittedForm ->
            -- Handel Success and Error here with cases --
            ( model
            , -- Http request later --
              Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


updateForm : (Form -> Form) -> Model -> ( Model, Cmd Msg )
updateForm transform model =
    ( { model | form = transform model.form }, Cmd.none )


viewForm : Form -> Html Msg
viewForm form =
    Html.form [ onSubmit SubmittedForm ]
        [ fieldset [ class "form-group" ]
            []
        , fieldset [ class "form-group" ]
            [ input
                [ class "form-control form-control-lg"
                , placeholder "Email"
                , onInput EnteredEmail
                , value form.email
                ]
                []
            ]
        , button [ class "btn btn-lg btn-primary pull-xs-right" ]
            [ text "Sign up" ]
        ]


init : Model
init =
    { form =
        { email = ""
        , username = ""
        , password = ""
        }
    }



-- used for Routing {} when the 'Msg' is sent to the complier --


view : Model -> { title : String, content : Html Msg }
view model =
    { title = "Register"
    , content =
        div [ class "cred-page" ]
            [ div [ class "container page" ]
                [ div [ class "row" ]
                    [ div [ class "col-md-6 offset-md-3 col-xs-12" ]
                        [ h1 [ class "text-xs-center" ] [ text "Sign up" ]
                        , p [ class "text-xs-center" ] []
                        , viewForm model.form
                        ]
                    ]
                ]
            ]
    }
