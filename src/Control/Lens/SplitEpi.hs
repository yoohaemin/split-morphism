{-# LANGUAGE Rank2Types #-}

module Control.Lens.SplitEpi where

import Control.Lens

{- | A split epimorphism, which we can think of as a weaker `Iso a b` where `b` is a "smaller" type.
So `get . reverseGet` remains an identity but `reverseGet . get` is merely idempotent (i.e., it normalizes values in `a`).

The following statements hold:
  * `reverseGet` is a "section" of `get`,
  * `get` is a "retraction" of `reverseGet`,
  *  - `b` is a "retract" of `a`,
  *  - the pair `(get, reverseGet)` is a "splitting" of the idempotent `reverseGet . get`.
-}
data SplitEpi a b = SplitEpi
    { get :: a -> b
    , reverseGet :: b -> a
    }

-- | `reverseGet . get`, yielding a normalized formatted value. Subsequent get/reverseGet cycles are idempotent.
normalize :: SplitEpi a b -> a -> a
normalize (SplitEpi f g) = g . f

-- | An Isomorphism is trivially a SplitEpi.
fromIso :: Iso' a b -> SplitEpi a b
fromIso i = SplitEpi (f i) (g i)
  where
    f :: Iso' a b -> a -> b
    f p x = x ^. p
    g :: Iso' a b -> b -> a
    g = review

