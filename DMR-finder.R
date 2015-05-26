mtbrlist <- list( HP = "/home/cjch/projects/ShujuanShao/HYS_peri-tumour/Rdepot/mtbr_cg/",
                  HT = "/home/cjch/projects/ShujuanShao/HYS_tumour/Rdepot/mtbr_cg/",
                  WP = "/home/cjch/projects/ShujuanShao/WYB_peri-tumour/Rdepot/mtbr_cg/",
                  WT = "/home/cjch/projects/ShujuanShao/WYB_tumour/Rdepot/mtbr_cg/")
samplename.list <- c("HP", "HT", "WP", "WT")


## Function read sample R data
readSampleRdata <- function(mtbrdir="/home/cjch/projects/ShujuanShao/HYS_peri-tumour/Rdepot/mtbr_cg/"){
  mtbrfile <- dir(mtbrdir)
  tmp.chrom = tmp.posi = tmp.posi = tmp.rC_n = tmp.rC_p = tmp.rT_n = tmp.rT_p <- c()
  
  for(chr in mtbrfile) {
    mtbr <- paste(mtbrdir,chr,sep = "")
    chrname <- unlist(strsplit(x = chr, split = ".", fixed = T))[1]
    message("Reading Rdata : ", chrname)
    load(mtbr)
    assign(chrname,cg.mtbr)
    tmp.chrom <- c(tmp.chrom, get(chrname)$chrom)
    tmp.posi  <- c(tmp.posi,  get(chrname)$posi)
    tmp.rC_n  <- c(tmp.rC_n,  get(chrname)$rC_n)
    tmp.rC_p  <- c(tmp.rC_p,  get(chrname)$rC_p)
    tmp.rT_n  <- c(tmp.rT_n,  get(chrname)$rT_n)
    tmp.rT_p  <- c(tmp.rT_p,  get(chrname)$rT_p)
  }
  mtbr.storage <- data.frame(chrom = tmp.chrom, 
                             posi  = tmp.posi, 
                             rC_n  = tmp.rC_n, 
                             rC_p  = tmp.rC_p, 
                             rT_n  = tmp.rT_n, 
                             rT_p  = tmp.rT_p)
  return(mtbr.storage)
}

# load all sample data
for(sample in samplename.list){
  message("++++++++++++++")
  message("Geting ",sample," Rdata" )
  assign(sample, readSampleRdata(mtbrlist[[sample]]))
  message("++++++++++++++")
}

