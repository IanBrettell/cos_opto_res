### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 1d8df6b4-63cc-11eb-17b6-2b16b6f277f2
using CSV, DataFrames, DataFramesMeta, Gadfly, PlutoUI, ColorSchemes

# ╔═╡ ae313fd0-63d5-11eb-0c93-4b619490c483
using Pkg

# ╔═╡ 087e122c-63cc-11eb-0bb8-dd0884814922
md"
# Test tracking and plotting
"

# ╔═╡ 16258d38-63cc-11eb-0a89-d51be717c094
md"
## Setup
"

# ╔═╡ a72d4d6e-63d5-11eb-320a-031679aa585e
Pkg.add("DataFramesMeta")

# ╔═╡ 6c60e2f6-63cc-11eb-0b71-17de2e445627
md"
## Read in data
"

# ╔═╡ 930129fc-63cc-11eb-0240-d18fa32bcfbe
data_path = "/Users/brettell/Documents/Repositories/cos_opto_res/data/20210108_OMR_Metal_halide_injured_Cab_MMStack_Default.ome_fiji-conv-data_CSV-Table.csv"

# ╔═╡ 73bfc454-63cc-11eb-0940-bf01298e080a
raw = DataFrame(CSV.File(data_path))

# ╔═╡ 20d8c37a-63cd-11eb-2da8-7183a5f5f36d
names(raw)

# ╔═╡ 28ee4a80-63cd-11eb-196c-ab0700a413ff
unique(raw[!, "trackId"])

# ╔═╡ 34f0d186-63cd-11eb-324d-c1aafc520d48
unique(raw[!, "labelimageId"])

# ╔═╡ 47285248-63cd-11eb-3340-8d5130f4e0e5
length(unique(raw[!, "frame"]))

# ╔═╡ 874db4a2-63ce-11eb-1c55-a332d5a39fb6
# Select target columns
df = @linq raw |>
			select(:frame, :trackId, :Object_Center_0, :Object_Center_1) |>
			where(:trackId .!= -1) |>
			transform(trackId = string.(:trackId)) 
			#where(:trackId !in("2"))

# ╔═╡ 9183e114-63d9-11eb-368f-3d853bc99a9e
unique(df[!, "trackId"])

# ╔═╡ 20756d28-63cf-11eb-02a8-9f8589e59888
md"
## Plot
"

# ╔═╡ 29f3cabe-6408-11eb-216c-2198cfabdb26
@bind target_ids MultiSelect(unique(df[!, "trackId"]))

# ╔═╡ 1f95b7b0-63dd-11eb-0023-ef8f41a49a66
df_filt = filter(row -> row.trackId in target_ids, df)

# ╔═╡ 0d056db4-640c-11eb-1051-9dd000646577
df[!, "trackId"] .== target_ids

# ╔═╡ 2ae80cec-640c-11eb-06c6-e9a00afa1a44
target_ids

# ╔═╡ b8e2e5ec-63d4-11eb-031c-d7a911886b05
@bind target_frames Slider(minimum(df[!, "frame"]):1:maximum(df[!, "frame"]),
						   default = maximum(df[!, "frame"]),
						   show_value = true)

# ╔═╡ 7bc253fa-6409-11eb-13c8-9f7dea063c74
df_plot = @linq filter(row -> row.frame <= target_frames, df) |>
				where(:trackId .!= target_ids)

# ╔═╡ 26f0312e-63cf-11eb-3713-1dd34b3087a9
plot(df_plot, 
	 Coord.cartesian(xmin = 0, xmax = 3365, ymin =0, ymax=1245, fixed = true),
	 x=:Object_Center_0,y=:Object_Center_1,Color=:trackId,
	 color = :trackId,
	 Geom.path)

# ╔═╡ Cell order:
# ╠═087e122c-63cc-11eb-0bb8-dd0884814922
# ╠═16258d38-63cc-11eb-0a89-d51be717c094
# ╠═1d8df6b4-63cc-11eb-17b6-2b16b6f277f2
# ╠═a72d4d6e-63d5-11eb-320a-031679aa585e
# ╠═ae313fd0-63d5-11eb-0c93-4b619490c483
# ╠═6c60e2f6-63cc-11eb-0b71-17de2e445627
# ╠═930129fc-63cc-11eb-0240-d18fa32bcfbe
# ╠═73bfc454-63cc-11eb-0940-bf01298e080a
# ╠═20d8c37a-63cd-11eb-2da8-7183a5f5f36d
# ╠═28ee4a80-63cd-11eb-196c-ab0700a413ff
# ╠═34f0d186-63cd-11eb-324d-c1aafc520d48
# ╠═47285248-63cd-11eb-3340-8d5130f4e0e5
# ╠═874db4a2-63ce-11eb-1c55-a332d5a39fb6
# ╠═1f95b7b0-63dd-11eb-0023-ef8f41a49a66
# ╠═9183e114-63d9-11eb-368f-3d853bc99a9e
# ╠═7bc253fa-6409-11eb-13c8-9f7dea063c74
# ╠═0d056db4-640c-11eb-1051-9dd000646577
# ╟─20756d28-63cf-11eb-02a8-9f8589e59888
# ╠═29f3cabe-6408-11eb-216c-2198cfabdb26
# ╠═2ae80cec-640c-11eb-06c6-e9a00afa1a44
# ╠═b8e2e5ec-63d4-11eb-031c-d7a911886b05
# ╠═26f0312e-63cf-11eb-3713-1dd34b3087a9
