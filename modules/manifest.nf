// Function to read in a CSV and return a Channel
def read_manifest(manifest_file){
    def manifest_dir = file(params.manifest).parent
    manifest_file.splitCsv(
        header: true, 
        sep: ","
    ).map { row ->
        if (row.R1 != null && row.R1 != "") row.R1 = "${manifest_dir}/${row.R1}"
        if (row.R2 != null && row.R2 != "") row.R2 = "${manifest_dir}/${row.R2}"
        if (row.I1 != null && row.I1 != "") row.I1 = "${manifest_dir}/${row.I1}"
        if (row.I2 != null && row.I2 != "") row.I2 = "${manifest_dir}/${row.I2}"
    }.branch {
        valid_paired_indexed:  (it.specimen != null) && (it.R1 != null ) && (it.R1 != "" ) && (!file(it.R1).isEmpty()) && (it.R2 != null ) && (it.R2 != "") && (!file(it.R2).isEmpty()) && (it.I1 != null ) && (it.I1 != "" ) && (!file(it.I1).isEmpty()) && (it.I2 != null ) && (it.I2 != "") && (!file(it.I2).isEmpty())
        valid_paired:  (it.specimen != null) && (it.R1 != null ) && (it.R1 != "" ) && (!file(it.R1).isEmpty()) && (it.R2 != null ) && (it.R2 != "") && (!file(it.R2).isEmpty())
        valid_unpaired:  (it.specimen != null) && (it.R1 != null ) && (it.R1 != "" ) && (!file(it.R1).isEmpty())
        other: true
    }
}
