using CodecLz4
using CodecZstd

uncompress_cfst(path) = begin
	cfst_file = open(path, "r")

	# first few header bytes
	headerhash = read(cfst_file, UInt32)
	block_size = Int(read(cfst_file, UInt32))
	version = read(cfst_file, UInt32) |> Int
	compression_algorithm = read(cfst_file, UInt32) & 2147483647

	vec_length = read(cfst_file, UInt64)

	vec_length |> Int

	# calculate the number of blocks
	nr_of_blocks = Int(1 + div(vec_length - 1, block_size))

	block_hash = read(cfst_file, UInt64)

	block_offsets = Vector{UInt64}(undef, 1 + nr_of_blocks)
	# read block offsets
	read!(cfst_file, block_offsets)

	# the first number is the hash
	block_offsets_int = Int.(block_offsets)

	lo = block_offsets_int[1]
	hi = block_offsets_int[2]

	compressed_chunk = read(cfst_file, hi-lo)

	# LZ4
	if compression_algorithm == 1 
		fnl_res =  transcode(LZ4Decompressor, compressed_chunk)
		# Blosc.set_compressor("lz4hc")
		# fnl_res = Blosc.decompress(UInt8, compressed_chunk)
		return compressed_chunk
	else
		fnl_res =  transcode(ZstdDecompressor, compressed_chunk)
	end


	for (lo, hi) in zip(@view(block_offsets_int[2:end-1]), @view(block_offsets_int[3:end]))		
		compressed_chunk = read(cfst_file, hi-lo)
		if compression_algorithm == 1 
			fnl_res = vcat(fnl_res, Blosc.decompress(UInt8, compressed_chunk))
		else
			fnl_res = vcat(fnl_res, transcode(ZstdDecompressor, compressed_chunk))
		end
	end

	close(cfst_file)
	fnl_res
end
