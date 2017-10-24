using fstformat
using Base.Test
using DataBench, fstformat
# write your own tests here
@test 1 == 1

a = createIndexedTable(100*100, 100)

fstformat.write(a, "c:/temp/test2.fst")
