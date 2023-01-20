module ColorRecord exposing (ColorRecord, HSVColorRecord)


type alias ColorRecord =
    { red : Int
    , green : Int
    , blue : Int
    }


type alias HSVColorRecord =
    { hue : Float
    , saturation : Float
    , value : Float
    }
