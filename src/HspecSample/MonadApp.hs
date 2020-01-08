{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralisedNewtypeDeriving #-}
{-# LANGUAGE MonoLocalBinds             #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE UndecidableInstances       #-}

module HspecSample.MonadApp where

import Control.Monad.Reader
import HspecSample.MonadAsk
import HspecSample.MonadPrint

class (MonadAsk s m, MonadPrint m) => MonadApp s m where
    askPrint :: Show a => (s -> a) -> m ()
    askPrint = print' <=< asks'

newtype App s m a = App
    { runApp :: ReaderT s m a
    } deriving
    ( Functor
    , Applicative
    , Monad
    , MonadTrans
    , MonadIO
    , MonadReader s
    )

instance MonadApp s (App s IO)
