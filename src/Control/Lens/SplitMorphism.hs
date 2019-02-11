module Control.Lens.SplitMorphism (
    reverseEpi
  , reverseMono
  ) where

import Control.Lens.SplitEpi (SplitEpi (..))
import Control.Lens.SplitMono (SplitMono (..))
import Control.Lens.Wedge (Wedge (..))

-- |  Swapping `get` and `reverseGet` yields a `SplitMono.
reverseEpi :: SplitEpi a b -> SplitMono b a
reverseEpi (SplitEpi x y) = SplitMono y x

-- |  Swapping `get` and `reverseGet` yields a `SplitEpi.
reverseMono :: SplitMono a b -> SplitEpi b a
reverseMono (SplitMono x y) = SplitEpi y x

-- | Composition between SplitMono and SplitEpi.
composeSplitMonoEpi :: SplitMono a b -> SplitEpi b c -> Wedge a c
composeSplitMonoEpi (SplitMono x y) (SplitEpi q w) =
    Wedge (q . x) (y . w)

-- | Composition between SplitEpi and SplitMono.
composeSplitEpiMono :: SplitEpi a b -> SplitMono b c -> Wedge a c
composeSplitEpiMono (SplitEpi x y) (SplitMono q w) =
    Wedge (q . x) (y . w)

