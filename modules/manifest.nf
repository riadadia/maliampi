// Function to read in a CSV and return a Channel
def read_manifest(manifest_file){
    def manifest_dir = file(params.manifest).parent

    manifest_file
        .splitCsv(header: true, sep: ",")
        .map { row ->
            if (row.R1 != null && row.R1 != "") row.R1 = "${manifest_dir}/${row.R1}"
            if (row.R2 != null && row.R2 != "") row.R2 = "${manifest_dir}/${row.R2}"
            if (row.I1 != null && row.I1 != "") row.I1 = "${manifest_dir}/${row.I1}"
            if (row.I2 != null && row.I2 != "") row.I2 = "${manifest_dir}/${row.I2}"
            return row
        }
        .branch { sample ->
            valid_paired_indexed:  (sample.specimen != null) && (sample.R1 != null ) && (sample.R1 != "" ) && (!file(sample.R1).isEmpty()) && (sample.R2 != null ) && (sample.R2 != "") && (!file(sample.R2).isEmpty()) && (sample.I1 != null ) && (sample.I1 != "" ) && (!file(sample.I1).isEmpty()) && (sample.I2 != null ) && (sample.I2 != "") && (!file(sample.I2).isEmpty())
            valid_paired:  (sample.specimen != null) && (sample.R1 != null ) && (sample.R1 != "" ) && (!file(sample.R1).isEmpty()) && (sample.R2 != null ) && (sample.R2 != "") && (!file(sample.R2).isEmpty())
            valid_unpaired:  (sample.specimen != null) && (sample.R1 != null ) && (sample.R1 != "" ) && (!file(sample.R1).isEmpty())
            other: true
        }
}
