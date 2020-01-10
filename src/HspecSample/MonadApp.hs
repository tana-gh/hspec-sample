{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralisedNewtypeDeriving #-}
{-# LANGUAGE MonoLocalBinds             #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE UndecidableInstances       #-}

module HspecSample.MonadApp where

import Control.Monad.Reader
import HspecSample.MonadAsk
import HspecSample.MonadPrint

class (MonadAsk s m a, MonadPrint m a) => MonadApp s m a where
    askPrint :: (s -> a) -> m ()
    askPrint f =
        mapM_ print' =<< asks' f

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

instance Show a => MonadApp s (App s IO) a
