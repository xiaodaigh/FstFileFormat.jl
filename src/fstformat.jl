__precompile__(true)
module fstformat

using RCall
using IterableTables # to enable conversion between table types
import DataFrames.DataFrame

export read, write, readmeta, install_fst, fst_installed

const FST_NOT_INSTALLED_ERR_MSG = "fst package not installed\n run 'install_fst()' or install fst manually in R using 'install.packages('fst')'"

"""
  
"""
function install_fst()
  R"""
    if(!require(fst)) {
      install.packages("fst")
    }
  """
end

function fst_installed()
  R"""
    fst_installed <- require(fst)
  """
  @rget fst_installed
  fst_installed
end

function read(path; columns = [], from = 1, to = [])
  if fst_installed()
    throw(ErrorException(FST_NOT_INSTALLED_ERR_MSG))
  end

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
  if fst_installed()
    throw(ErrorException(FST_NOT_INSTALLED_ERR_MSG))
  end

  xdf = DataFrame(x)
  @rput xdf
  R"""
    library(fst)
    dt <- fst::write.fst(xdf, $path, compress = $compress)
  """
  @rget dt
  return dt
end

function readmeta(path)
  if fst_installed()
    throw(ErrorException(FST_NOT_INSTALLED_ERR_MSG))
  end

  R"""
    library(fst)
    meta <- fst::fst.metadata($path)
  """
  @rget meta
  return meta
end

end # module
