port module Main exposing (main)

import Browser
import Html exposing (Html, button, div, h1, img, p, text, textarea)
import Html.Attributes exposing (class, height, src, style, value)
import Html.Events exposing (onClick, onInput)
import Markdown
import Time
import VitePluginHelper exposing (asset)


type alias Model =
    { markdown : String
    , html : Html Msg
    }


init : String -> ( Model, Cmd Msg )
init savedMarkdown =
    let
        markdown =
            if savedMarkdown == "" then
                "type markdown here"

            else
                savedMarkdown
    in
    ( { markdown = markdown
      , html = Markdown.toHtml [] markdown
      }
    , Cmd.none
    )


type Msg
    = MarkdownChanged String
    | DownloadMarkdown
    | Tick Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MarkdownChanged newMarkdown ->
            ( { model | markdown = newMarkdown, html = Markdown.toHtml [] newMarkdown }, Cmd.none )

        DownloadMarkdown ->
            ( model, downloadMarkdown model.markdown )

        Tick _ ->
            ( model, saveMarkdown model.markdown )


view : Model -> Html Msg
view model =
    div []
        [ img [ src <| asset "/src/assets/logotype.png", height 50 ] []
        , h1 [] [ text "Markdown Editor" ]
        , p [] [ text "This is a simple markdown editor. It will save your markdown every 30 seconds locally in your browser. You can download the markdown by pressing the download button." ]
        , div []
            [ textarea
                [ style "width" "100%"
                , style "height" "50vh"
                , value model.markdown
                , onInput MarkdownChanged
                ]
                []
            , button [ onClick DownloadMarkdown ] [ text "Download Markdown" ]
            , div [ class "markdown-output" ] [ model.html ]
            ]
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
