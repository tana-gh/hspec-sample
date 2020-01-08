{-# LANGUAGE DeriveFunctor              #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralisedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE RankNTypes                 #-}

module HspecSample.Spec.Mock where

import Control.Monad.Reader
import Control.Monad.State
import HspecSample.MonadApp
import HspecSample.MonadAsk
import HspecSample.MonadPrint

newtype Mock m a = Mock
    { runMock :: StateT MockState m a
    } deriving
    ( Functor
    , Applicative
    , Monad
    , MonadTrans
    )

data MockState = MockState
    { asksState  :: [String]
    , printState :: [String]
    }

initialMockState :: MockState
initialMockState = MockState [] []

instance {-# OVERLAPS #-} Monad m => MonadAsk s (Mock m) where
    asks' _ = Mock . runMock . (`evalStateT` initialMockState) $ do
        modify $ \s -> s { asksState = show (Nothing :: Maybe ()) : asksState s }
        return Nothing

instance {-# OVERLAPS #-} Monad m => MonadPrint (Mock m) where
    print' a = Mock . runMock . (`evalStateT` initialMockState) $ do
        modify $ \s -> s { printState = show a : printState s }
        return ()

instance Monad m => MonadApp s (Mock m)
