using Documenter, fstformat

makedocs(modules=["fstformat"],
        doctest=true)

deploydocs(deps   = Deps.pip("mkdocs", "python-markdown-math"),
    repo = "github.com/xiaodaigh/fstformat.jl.git",
    julia  = "0.6.1",
    osname = "windows")
