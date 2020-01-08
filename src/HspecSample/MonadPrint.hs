{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE UndecidableInstances #-}

module HspecSample.MonadPrint where

import Control.Monad.IO.Class

class Monad m => MonadPrint m where
    print' :: Show a => a -> m ()

instance (Monad m, MonadIO m) => MonadPrint m where
    print' = liftIO . print
