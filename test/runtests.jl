using FstFileFormat, DataFrames
using Base.Test

import DataFrames.DataFrame

println("STEP A")
# install fst if not allready
if !FstFileFormat.fst_installed()
    println("STEP B")
    FstFileFormat.install_fst()
    println("STEP C")
end
println("STEP D")

# test writing and reading from a DataFrame
df = DataFrame(col1 = rand(1:5,1_000_000),
    col2 = rand(1:100, 1_000_000),
    col3 = rand(Bool, 1_000_000))

# df can be any object that DataFrames.DataFrame(df) can make into a DataFrame
# any IterableTables.jl compatible table like object is supported
@testset "general read write" begin
println("STEP E")
    FstFileFormat.write(df, "__test_fstformat.jl__.fst")
println("STEP F")
    @test isfile("__test_fstformat.jl__.fst")
    rm("__test_fstformat.jl__.fst")

    # compression = 100; the highest
    FstFileFormat.write(df, "__test_fstformat.jl__c.fst", 100)
    @test isfile("__test_fstformat.jl__c.fst")

    # read the metadata
    __df_meta__ = FstFileFormat.readmeta("__test_fstformat.jl__c.fst")
    @test __df_meta__[:nrOfRows] == 1_000_000

    # read the data
    __tmp_df__ = FstFileFormat.read("__test_fstformat.jl__c.fst")
    @test nrow(__tmp_df__) == 1_000_000

    # read some columns
    __tmp_df__ = FstFileFormat.read("__test_fstformat.jl__c.fst"; columns = ["col1", "col2"])
    @test ncol(__tmp_df__) == 2

    # read some rows
    __tmp_df__ = FstFileFormat.read("__test_fstformat.jl__c.fst"; from = 500, to = 1000)
    @test nrow(__tmp_df__) == 501

    # read some columns and rows up to 1000
    __tmp_df__ = FstFileFormat.read("__test_fstformat.jl__c.fst"; columns = ["col1", "col2"], to = 1000)
    @test ncol(__tmp_df__) == 2 && nrow(__tmp_df__) == 1000

    # read some columns and rows from 500
    __tmp_df__ = FstFileFormat.read("__test_fstformat.jl__c.fst"; columns = ["col1", "col2"], from = 500)
    @test ncol(__tmp_df__) == 2 && nrow(__tmp_df__) == 1_000_000 - 500 + 1

    # read some columns and rows from 500 to 1000
    __tmp_df__ = FstFileFormat.read("__test_fstformat.jl__c.fst"; columns = ["col1", "col2"], from = 500, to = 1000)
    @test ncol(__tmp_df__) == 2 && nrow(__tmp_df__) == 501

    rm("__test_fstformat.jl__c.fst")
end
