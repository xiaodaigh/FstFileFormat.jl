# How to use
```julia
Pkg.clone("https://github.com/xiaodaigh/fstformat.jl.git")
using fstformat.jl

# df can be any object that DataFrames.DataFrame(df) can make into a DataFrame 
# any IterableTables.jl compatible table like object is supported
fstformat.write(df, "c:/temp/df.fst")

# compression = 100; the highest
fstformat.write(df, "c:/temp/df.fst", 100) 

# read the data
fstformat.read("c:/temp/df.fst")

# read the metadata
fstformat.readmeta("c:/temp/df.fst")

```

# About
This is the Julia bindings for the fst format (http://www.fstpackage.org) although the format was originally designed to work with R it is language independent.
