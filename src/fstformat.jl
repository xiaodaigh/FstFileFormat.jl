__precompile__(true)
module fstformat

using RCall
using IterableTables # to enable conversion between table types
import DataFrames.DataFrame

export read, write, readmeta, install_fst

function install_fst()
  R"""
    if(!require(fst)) {
      install.packages("fst")
    }
  """
end

# function read(path)
#   #install_fst()
#   R"""
#     library(fst)
#     dt = fst::read.fst($path)
#   """
#   @rget dt
#   return dt
# end

function read(path; columns = [], from = 1, to = [])
  #install_fst()
  @rput columns
  @rput to
  R"""
    library(fst)
    if(length(columns) == 0) {
      columns = NULL
    }
    if(length(to) == 0) {
      to = NULL
    }
    dt = fst::read.fst($path, columns = columns, from = $from, to = to)
  """
  @rget dt
  return dt
end


function write(x, path)
  write(x, path, 0)
end

function write(x, path, compress)
  #install_fst()
  xdf = DataFrame(x)
  @rput xdf
  R"""
    library(fst)
    dt = fst::write.fst(xdf, $path, compress = $compress)
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
