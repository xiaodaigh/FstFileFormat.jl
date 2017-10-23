__precompile__(true)
module fstformat

using RCall

function install_fst()
  R"""
    if(!require(fst)) {
      install.packages("fst")
    }
  """
end

function read(path)
  install_fst()
  R"""
    library(fst)
    fst::read.fst($path)
  """
end

function write(path)
  write(path, 0)
end

function write(path, compress)
  install_fst()
  R"""
    library(fst)
    fst::read.fst($path,compress = $compress)
  """
end

# package code goes here

end # module
