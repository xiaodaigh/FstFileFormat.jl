module FstFileFormat

using RCall
# using IterableTables # to enable conversion between table types
import DataFrames.DataFrame

export read, write, readmeta, install_fst, fst_installed

const FST_NOT_INSTALLED_ERR_MSG = "fst package not installed\n run 'FstFileFormat.install_fst()' or install fst manually in R using 'install.packages('fst')'"

"""
Install fst package if not already installed
"""
function install_fst()
  R"""
    if(!require(fst)) {
      install.packages("fst")
    }
  """
end

"""
Returns `true` if fst is installed and `false` otherwise
"""
function fst_installed()
  R"""
    memory.limit(1e10)
    fst_installed <- require(fst)
  """
  @rget fst_installed
  fst_installed
end

"""
Reads a fst file and return a DataFrame

**Arguments**
* `path` : path to the fst file
* `columns` : an array of strings return only these columns in the DataFrame
* `from`: read from which row; defaults from `1`
* `to` : read to which row; defaults to `[]` which reads all rows
"""
function read(path; columns = [], from = 1, to = [])
  if !fst_installed()
    throw(ErrorException(FST_NOT_INSTALLED_ERR_MSG))
  end

  @rput columns
  @rput to
  R"""
    if(length(columns) == 0) {
      columns = NULL
    }
    if(length(to) == 0) {
      to = NULL
    }
    dt = fst::read_fst($path, columns = columns, from = $from, to = to)
  """
  @rget dt
  return dt
end

"""
Write a fst file and return

**Arguments**
* `x` : a DataFrame or an object that can be turned into a DataFrame via DataFrame(x)
* `path` : path to the fst file
* `compress` : an integer from 0 to 100 indicating the compression level; higher means more compressed
"""
function write(x, path)
  write(x, path, 0)
end

function write(x, path, compress)
  if !fst_installed()
    throw(ErrorException(FST_NOT_INSTALLED_ERR_MSG))
  end

  xdf = DataFrame(x)
  @rput xdf
  R"""
    dt <- fst::write_fst(xdf, $path, compress = $compress)
  """
  @rget dt
  return dt
end

"""
Reads a fst file's metadata and returns a Dict of the attributes

**Arguments**
* `path` : path to the fst file
"""
function readmeta(path)
  if !fst_installed()
    throw(ErrorException(FST_NOT_INSTALLED_ERR_MSG))
  end

  R"""
    meta <- fst::fst.metadata($path)
  """
  @rget meta
  return meta
end

end # module
