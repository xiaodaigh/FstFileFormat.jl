# How to use
```julia
Pkg.clone("https://github.com/xiaodaigh/fstformat.jl.git")
using fstformat

# df can be any object that DataFrames.DataFrame(df) can make into a DataFrame 
# any IterableTables.jl compatible table like object is supported
fstformat.write(df, "c:/temp/df.fst")

# compression = 100; the highest
fstformat.write(df, "c:/temp/df.fst", 100) 

# read the metadata
fstformat.readmeta("c:/temp/df.fst")

# read the data
fstformat.read("c:/temp/df.fst")

# read some columns
fstformat.read("c:/temp/df.fst"; columns = ["col1", "col2"])

# read some rows
fstformat.read("c:/temp/df.fst"; from = 500, to = 1000)

# read some columns and rows up to 1000
fstformat.read("c:/temp/df.fst"; columns = ["col1", "col2"], to = 1000)

# read some columns and rows from 500
fstformat.read("c:/temp/df.fst"; columns = ["col1", "col2"], from = 500)

# read some columns and rows from 500 to 1000
fstformat.read("c:/temp/df.fst"; columns = ["col1", "col2"], from = 500, to = 1000)

```

# About
This is the Julia bindings for the fst format (http://www.fstpackage.org) although the format was originally designed to work with R it is language independent.
