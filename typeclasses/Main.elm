module Main exposing (..)

import Html.App as App
import Html exposing (..)


type Ord a
    = Ord { less : a -> a -> Bool }


ordInt =
    Ord { less = (<) }


ordChar =
    Ord { less = (<) }


max : Ord a -> a -> a -> a
max (Ord d) x y =
    if (.less d) x y then
        y
    else
        x


maximum : Ord a -> List a -> Maybe a
maximum d list =
    case list of
        [ x ] ->
            Just x

        x :: xs ->
            case maximum d xs of
                Just b ->
                    Just (max d x b)

                Nothing ->
                    Just x

        [] ->
            Nothing


typeclass =
    maximum ordInt [ 1, 3, 2 ]


view model =
    case typeclass of
        Just a ->
            div [] [ text (toString a) ]

        Nothing ->
            div [] [ text "shouldn't happen" ]


main =
    App.beginnerProgram
        { model = ()
        , view = view
        , update = (\_ _ -> ())
        }
