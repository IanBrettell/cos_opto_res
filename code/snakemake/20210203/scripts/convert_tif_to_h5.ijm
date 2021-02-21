#@String input_tif
#@String output_h5
print("Arguments:");
print(input_tif);
print(output_h5);

function convert_tif_to_h5(input, output) {
        open(input);
        export_args = "select=" + output + " exportpath=" + output + " datasetname=data compressionlevel=0 input=" + input;
        run("Export HDF5", export_args);
        close();
}

convert_tif_to_h5(input_tif, output_h5)
