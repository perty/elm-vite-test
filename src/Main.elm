port module Main exposing (main)

import Browser
import Html exposing (Html, button, div, textarea, text)
import Html.Attributes exposing (class, style, value)
import Html.Events exposing (onClick, onInput)
import Markdown
import Time

type alias Model =
    { markdown : String
    , html : Html Msg
    }

init : String -> (Model, Cmd Msg)
init savedMarkdown =
    let
        markdown = if savedMarkdown == "" then "type markdown here" else savedMarkdown
    in
    ( { markdown = markdown
      , html = Markdown.toHtml [] markdown
      }, Cmd.none
    )

type Msg
    = MarkdownChanged String
    | DownloadMarkdown
    | SaveMarkdown
    | Tick Time.Posix

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        MarkdownChanged newMarkdown ->
            ( { model | markdown = newMarkdown, html = Markdown.toHtml [] newMarkdown }, Cmd.none )
        DownloadMarkdown ->
            ( model, downloadMarkdown model.markdown )
        SaveMarkdown ->
            ( model, saveMarkdown model.markdown )
        Tick _ ->
            ( model, saveMarkdown model.markdown )

view : Model -> Html Msg
view model =
    div []
        [ textarea 
            [ style "width" "100%"
            , style "height" "50vh"
            , value model.markdown
            , onInput MarkdownChanged 
            ] []
        , button [ onClick DownloadMarkdown ] [ text "Download Markdown" ]
        , div [class "markdown-output"] [ model.html ]
        ]

port downloadMarkdown : String -> Cmd msg
port saveMarkdown : String -> Cmd msg

subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 30000 Tick

main : Program String Model Msg
main =
    Browser.element 
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }