module HspecSample.MonadPrint where

class Monad m => MonadPrint m where
    print' :: Show a => a -> m ()
