module CD.CRUD.Database (
  createConnectionPool
) where

import CD.CRUD.Types

import Data.Pool (Pool, createPool, withResource)
import Database.PostgreSQL.Simple

createConnectionPool :: ConnectInfo -> IO (Pool Connection)
createConnectionPool connectInfo = 
  createPool (connect connectInfo) close 1 60 3 -- 1 pool, open 60 seconds idle, 5 maximum connections at once



