{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralisedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}

module HspecSample.Spec.Mock where

import Control.Monad.State
import HspecSample.Config
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
    , MonadState MockState
    )

data MockState = MockState
    { asksState  :: [String]
    , printState :: [String]
    }

initialMockState :: MockState
initialMockState = MockState [] []

config :: Config
config = ["config1", "config2"]

asksCalled :: String
asksCalled = "asks called"

instance Monad m => MonadAsk Config (Mock m) where
    asks' f = do
        modify $ \s -> s { asksState = asksCalled : asksState s }
        return . Just $ f config

instance Monad m => MonadPrint (Mock m) where
    print' a = do
        modify $ \s -> s { printState = show a : printState s }
        return ()

instance Monad m => MonadApp (Mock m)
