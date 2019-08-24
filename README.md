# About
This is the Julia bindings for the fst format (http://www.fstpackage.org) although the format was originally designed to work with R it is language independent.

# How to use

Install the package via the julia package manager:

```julia
]add FstFileFormat
```

or press `]` to enter `pkg` mode

```julia
pkg> add FstFileFormat
```

Then use it to read and write fst files:

```julia
using FstFileFormat
using DataFrames

# install the R fst package if not already installed
if !fst_installed()
    install_fst()
end


df = DataFrame(col1 = rand(1:5,1_000_000),
    col2 = rand(1:100, 1_000_000),
    col3 = rand(Bool, 1_000_000))


# df can be any object that DataFrames.DataFrame(df) can make into a DataFrame
# any IterableTables.jl compatible table like object is supported
FstFileFormat.write(df, "df.fst")

# compression = 100; the highest
FstFileFormat.write(df, "df.fst", 100)

# read the metadata
FstFileFormat.readmeta("df.fst")

# read the data
FstFileFormat.read("df.fst")

# read some columns
FstFileFormat.read("df.fst"; columns = ["col1", "col2"])

# read some rows
FstFileFormat.read("df.fst"; from = 500, to = 1000)

# read some columns and rows up to 1000
FstFileFormat.read("df.fst"; columns = ["col1", "col2"], to = 1000)

# read some columns and rows from 500
FstFileFormat.read("df.fst"; columns = ["col1", "col2"], from = 500)

# read some columns and rows from 500 to 1000
FstFileFormat.read("df.fst"; columns = ["col1", "col2"], from = 500, to = 1000)

```
