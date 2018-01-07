using Documenter, FstFileFormat

makedocs(modules=[FstFileFormat],
        doctest=true,
        format = :html,
	    sitename = "FstFileFormat.jl",
	    pages = [
		    "The FstFileFormat.jl package" => "index.md"])

deploydocs(deps = nothing,
    make = nothing,
    target = "build",
    repo = "github.com/xiaodaigh/FstFileFormat.jl.git",
    julia  = "0.6")
