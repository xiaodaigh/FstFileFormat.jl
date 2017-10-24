using fstformat
using Base.Test
using DataBench, fstformat
# write your own tests here
@test 1 == 1

a = createIndexedTable(100*100, 100)

fstformat.write(a, "test2.fst")

fstformat.readmeta("test2.fst")

fstformat.read("test2.fst")

fstformat.read("test2.fst"; columns =["id6","v1"])

fstformat.read("test2.fst"; columns =["id6","v1"], to = 1000)

fstformat.read("test2.fst"; columns =["id6","v1"], from = 500, to = 1000)
