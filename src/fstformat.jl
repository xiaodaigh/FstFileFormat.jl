__precompile__(true)
module fstformat

using RCall

export read, write, readmeta, install_fst

function install_fst()
  R"""
    if(!require(fst)) {
      install.packages("fst")
    }
  """
end

function read(path)
  #install_fst()
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
  #install_fst()
  @rput x
  R"""
    library(fst)
    dt = fst::read.fst(x, $path,compress = $compress)
  """
  @rget dt
  return dt
end

function readmeta(path)
  #install_fst()
  R"""
    library(fst)
    meta <- fst::fst.metadata($path)
  """
  @rget meta
  return meta
end

# package code goes here

end # module
