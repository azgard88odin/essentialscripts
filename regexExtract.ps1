# This script was to help create a lookup sheet for dated files. Each photo filename has a date in it
# Essentially, there are thousands upon thousands of archived images but the dates on the subfolders, were incorrect
# Example: the Folder '2024-10-11' would contain photos from 2024-10-11,12 and, 13
# This made it difficult for me to see if photos from certain dates were even saved in the archive.
# With this I extracted a list of all the dates in the filenames so that I can quickly search a date range
# With that information it was easier to track down the possible subfolder in which it was contained, which avoided iterating through thousands of folders to find a set of files
$directory = "\path\to\directory"
$regex = '20240\d{3}'

$uniqueStrings = @()

Get-ChildItem -Path $directory -Recurse -File | ForEach-Object {
    $filename = [System.IO.Path]::GetFileName($_)
    $matches = [regex]::Matches($filename, $regex)
    foreach ($match in $matches) {
        if ($uniqueStrings -notcontains $match.Value) {
            $uniqueStrings += $match.Value
        }
    }
}

Write-Host $uniqueStrings