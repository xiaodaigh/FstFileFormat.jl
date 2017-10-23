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
    dt = fst::read.fst($path)
  """
  @rget dt
  return dt
end

function write(x, path)
  write(x, path, 0)
end

function write(x, path, compress)
  install_fst()
  @rput x
  R"""
    library(fst)
    fst::read.fst(x, $path,compress = $compress)
  """
end

# package code goes here

end # module
