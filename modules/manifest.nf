// Function to read in a CSV and return a Channel
def read_manifest(manifest_file){
    def manifest_dir = file(params.manifest).parent
    manifest_file.splitCsv(
        header: true, 
        sep: ","
    ).map { it ->
        if (it.R1 != null && it.R1 != "") it.R1 = "${manifest_dir}/${it.R1}"
        if (it.R2 != null && it.R2 != "") it.R2 = "${manifest_dir}/${it.R2}"
        if (it.I1 != null && it.I1 != "") it.I1 = "${manifest_dir}/${it.I1}"
        if (it.I2 != null && it.I2 != "") it.I2 = "${manifest_dir}/${it.I2}"
    ).branch{
        valid_paired_indexed:  (it.specimen != null) && (it.R1 != null ) && (it.R1 != "" ) && (!file(it.R1).isEmpty()) && (it.R2 != null ) && (it.R2 != "") && (!file(it.R2).isEmpty()) && (it.I1 != null ) && (it.I1 != "" ) && (!file(it.I1).isEmpty()) && (it.I2 != null ) && (it.I2 != "") && (!file(it.I2).isEmpty())
        valid_paired:  (it.specimen != null) && (it.R1 != null ) && (it.R1 != "" ) && (!file(it.R1).isEmpty()) && (it.R2 != null ) && (it.R2 != "") && (!file(it.R2).isEmpty())
        valid_unpaired:  (it.specimen != null) && (it.R1 != null ) && (it.R1 != "" ) && (!file(it.R1).isEmpty())
        other: true
    }
}
