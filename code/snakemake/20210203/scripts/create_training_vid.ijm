#@String input_tif
#@String output_h5
#@String start
#@String end
print("ARGUMENTS:");
print("Input TIF: " + input_tif);
print("Output H5: " + output_h5);
print("Start frame: " + start);
print("End frame: " + end);

function convert_avi_to_h5(input, output, start_frame, end_frame) {
        start = parseInt(start_frame);
        end = parseInt(end_frame);
        import_args = "open=" + input + " first=" + start + " last=" + end + " use convert";
        run("AVI...", import_args);
        export_args = "select=" + output + " exportpath=" + output + " datasetname=data compressionlevel=0 input=" + input;
        run("Export HDF5", export_args);
        close();
}

convert_avi_to_h5(input_avi, output_h5, start, end);
