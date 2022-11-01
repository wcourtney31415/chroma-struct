rm target/*
cp src/index.html target
elm make src/Main.elm --output=target/elm.js