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
    , MonadState MockState
    )

data MockState = MockState
    { asksState  :: [String]
    , printState :: [String]
    }

initialMockState :: MockState
initialMockState = MockState [] []

asksCalled :: String
asksCalled = "asks called"

instance {-# OVERLAPS #-} Monad m => MonadAsk MockState (Mock m) String where
    asks' _ = do
        modify $ \s -> s { asksState = asksCalled : asksState s }
        return $ Just asksCalled

instance {-# OVERLAPS #-} Monad m => MonadPrint (Mock m) String where
    print' a = do
        modify $ \s -> s { printState = a : printState s }
        return ()

instance Monad m => MonadApp MockState (Mock m) String
