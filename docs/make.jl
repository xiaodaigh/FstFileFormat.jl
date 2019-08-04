using Documenter, FstFileFormat

makedocs(modules=[FstFileFormat],
        doctest=true,
	    sitename = "FstFileFormat.jl",
	    pages = [
		    "The FstFileFormat.jl package" => "index.md"])

deploydocs(
    repo = "github.com/xiaodaigh/FstFileFormat.jl.git"
)
