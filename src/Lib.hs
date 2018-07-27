module Lib
    where

import Data.List
import Data.Ord

someFunc :: IO ()
someFunc = putStrLn "someFunc"

p1 = [[4,5,6],[2,8,3],[3,9,2]] :: [[Int]]
p2 = transpose [[3,1,2],[1,4,6],[0,6,8]] :: [[Int]]
p3 = [[-1,0,1],[0,1,-1],[1,-1,0]] :: [[Int]]

matrixSize :: [[Int]] -> (Int,Int)
matrixSize a = (length a, length $ transpose a)

equalMatrixSize ::[[Int]] -> [[Int]] -> Bool
equalMatrixSize a b = (ar==br) && (ac == bc)
  where
    (ar,ac) = matrixSize a
    (br,bc) = matrixSize b

maxIndices :: Ord a => [a] -> (a,[Int])
maxIndices [x]    = (x,[0])
maxIndices (x:xs) =
  if x > xsMax then (x, [0])
  else if x == xsMax then (xsMax, [0] ++ (map (+1) xsMaxIndices))
       else (xsMax, (map (+1) xsMaxIndices))
  where (xsMax, xsMaxIndices) = maxIndices xs

maxRowIndices :: Ord a => [[a]] -> [(a,[Int])]
maxRowIndices = map maxIndices

maxColIndices :: Ord a => [[a]] -> [(a,[Int])]
maxColIndices = maxRowIndices . transpose

compound :: [[a]] -> [a]
compound xs = help xs []
  where
    help [] ys = ys
    help (x:xs) ys = help xs (ys++x)

removeDuplicates :: Eq a => [a] -> [a]
removeDuplicates [] = []
removeDuplicates (x:xs) = x : filter (/=x) (removeDuplicates xs)

setDiff :: Eq a => [a] -> [a] -> [a]
setDiff [] _ = []
setDiff (x:xs) ts =
  if elem x ts then setDiff xs ts
  else [x] ++ setDiff xs ts

nonDominatedStrategies :: [[Int]] -> [Int]
nonDominatedStrategies xs = sort (removeDuplicates . compound $ snd $ unzip $ maxColIndices xs)

dominatedStrategies :: [[Int]] -> [Int]
dominatedStrategies xs = setDiff [0..(length xs - 1)] (nonDominatedStrategies xs)

keepRows :: [[Int]] -> [Int] -> [[Int]]
keepRows xs rows = map (xs!!) rows

keepCols :: [[Int]] -> [Int] -> [[Int]]
keepCols xs cols = transpose $ keepRows (transpose xs) cols

deleteAllDominatedStrategies :: ([[Int]], [[Int]]) -> ([[Int]], [[Int]])
deleteAllDominatedStrategies input =
  if equalMatrixSize (fst input) (fst output) && equalMatrixSize (snd input) (snd output) then output
  else deleteAllDominatedStrategies output
  where
    output = deleteFromBothDominatedStrategies input

deleteFromBothDominatedStrategies :: ([[Int]], [[Int]]) -> ([[Int]], [[Int]])
deleteFromBothDominatedStrategies = swapPair . deleteDominatedStrategies . swapPair . deleteDominatedStrategies

deleteDominatedStrategies :: ([[Int]], [[Int]]) -> ([[Int]], [[Int]])
deleteDominatedStrategies (a, b) = (keepRows a i, keepCols b i)
  where
    i = nonDominatedStrategies a

swapPair :: (a,b) -> (b,a)
swapPair (a,b) = (b,a)
