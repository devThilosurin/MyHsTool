
import System.IO
import System.Directory
import System.Posix (isDirectory, getFileStatus)

readFileByName :: FilePath -> IO ()
readFileByName naming = do
    putStrLn $ "\n✨ Reading File : " ++ naming
    handle <- openFile naming ReadMode
    contents <- hGetContents handle  
    putStrLn contents
    hClose handle

readDirByName :: String -> [FilePath] -> IO ()
readDirByName _ [] = putStrLn "\n✅ Done!"
readDirByName naming (x:xs) = do
    readFileByName ("./"++naming++"/"++x)
    readDirByName naming xs

filterDefaultFiles :: [FilePath] -> [FilePath]
filterDefaultFiles = filter (`notElem` [".", ".."])

main = do
    theNameOfFile <- getLine
    fileStatus <- getFileStatus theNameOfFile
    if isDirectory fileStatus 
        then do 
            files <- getDirectoryContents ("./" ++ theNameOfFile)
            readDirByName theNameOfFile $ filterDefaultFiles files
        else readFileByName theNameOfFile
   