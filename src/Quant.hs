module Lib
    (
      find,
      forsome,
      forevery,
      findBool,
      argsup,
      arginf,
      J,
      K
    ) where

type J r x = (x -> r) -> x -- selection
type K r x = (x -> r) -> r -- quantifier

overline :: J r x -> K r x
overline e = \p -> p $ e p -- transforms selection to quantifier
-- \p -> p(e p)
-- \p -> p (((x -> r) -> x ) p)

find :: [x] -> J Bool x
find []     p = undefined
find [x]    p = x
find (x:xs) p = if p x then x else find xs p

forsome, forevery :: [x] -> K Bool x
forsome = overline.find
forevery xs p = not(forsome xs (not.p))

findBool :: J Bool Bool
findBool p = p True

findnot :: [x] -> J Bool x
findnot []     p = undefined
findnot [x]    p = x
findnot (x:xs) p = if p x then findnot xs p else x

argsup, arginf :: [x] -> J Int x
argsup [] p = undefined
argsup [x] p = x
argsup (x:y:zs) p = if p x < p y
                    then argsup (y:zs) p
                    else argsup (x:zs) p

arginf [] p = undefined
arginf [x] p = x
arginf (x:y:zs) p = if p x > p y
                    then arginf (y:zs) p
                    else arginf (x:zs) p

