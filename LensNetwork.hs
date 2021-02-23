{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE DataKinds #-}
module Lib
    (
    ) where
import Control.Lens
import Numeric.LinearAlgebra.Static as NLS
import Numeric.Backprop
import Debug.SimpleReflect as SR
data Network = Net { _weight1 :: NLS.L 20 100
                   , _bias1   :: NLS.R 20
                   , _weight2 :: NLS.L  5  20
                   , _bias2   :: NLS.R  5
                   }
Control.Lens.makeLenses ''Network
runNet :: Network -> NLS.R 100 -> NLS.R 5
runNet net x = z
  where
    y = logistic $ (net ^. weight1) #> x + (net ^. bias1)
    z = logistic $ (net ^. weight2) #> y + (net ^. bias2)
logistic :: Floating a => a -> a
logistic x = 1 / (1 + exp (-x))
myFun :: Floating a => a -> a -> a
myFun x y = x + y
myFunc :: Floating a => a -> a
myFunc x = sqrt (x*4)
{-
data Point = Point { _x :: Double, _y :: Double }deriving (Show) 
data Atom = Atom { _element :: String, _point :: Point } deriving (Show)
data Molecule = Molecule { _atoms :: [Atom] } deriving (Show)
Control.Lens.makeLenses ''Atom
Control.Lens.makeLenses ''Point
Control.Lens.makeLenses ''Molecule
shiftAtomX :: Atom -> Atom
shiftAtomX = over (point . x) (+ 1)
shiftMoleculeX :: Molecule -> Molecule
shiftMoleculeX = over (atoms . traverse . point . x) (+ 1)
atom1 = Atom { _element = "C", _point = Point { _x = 1.0, _y = 2.0 } }
atom2 = Atom { _element = "O", _point = Point { _x = 3.0, _y = 4.0 } }
molecule = Molecule { _atoms = [atom1, atom2] }
newMolecule = shiftMoleculeX molecule
t = atom1 ^. (point . x)
-}
