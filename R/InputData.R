#' Get Relevant Data For ArchR Tutorials
#' 
#' This function will download data for a given tutorial and return the input files required for ArchR.
#' 
#' @param tutorial The name of the available tutorial for which to retreive the tutorial data. The main option is "Hematopoiesis".
#' "Hematopoiesis" is a small scATAC-seq dataset that spans the hematopoieitic hierarchy from stem cells to differentiated cells.
#' This dataset is made up of cells from peripheral blood, bone marrow, and CD34+ sorted bone marrow. The second option is "Test"
#' which is downloading a small test PBMC fragments file mainly used to test the url capabilities of this function.
#' @param threads The number of threads to be used for parallel computing.
#'
#' @examples
#'
#' # Get Tutorial Fragments using `test` since its smaller
#' fragments <- getTutorialData(tutorial = "test")
#' 
#' @export
getTutorialData <- function(
  tutorial = "hematopoiesis", 
  threads = getArchRThreads()
  ){
  
  #Validate
  ArchR:::.validInput(input = tutorial, name = "tutorial", valid = "character")
  ArchR:::.validInput(input = threads, name = "threads", valid = c("integer"))
  #########
  
  #Make Sure URL doesnt timeout
  oldTimeout <- getOption('timeout')
  options(timeout=100000)
  
  if(tolower(tutorial) %in% c("heme","hematopoiesis")){
    
    pathDownload <- "HemeFragments"
    
    filesUrl <- data.frame(
      fileUrl = c(
        "https://jeffgranja.s3.amazonaws.com/ArchR/TestData/HemeFragments/scATAC_BMMC_R1.fragments.tsv.gz",
        "https://jeffgranja.s3.amazonaws.com/ArchR/TestData/HemeFragments/scATAC_CD34_BMMC_R1.fragments.tsv.gz",
        "https://jeffgranja.s3.amazonaws.com/ArchR/TestData/HemeFragments/scATAC_PBMC_R1.fragments.tsv.gz"
      ),
      md5sum = c(
        "77502e1f195e21d2f7a4e8ac9c96e65e",
        "618613b486e4f8c0101f4c05c69723b0",
        "a8d5ae747841055ef230ba496bcfe937"
      ),
      stringsAsFactors = FALSE
    )
    
    dir.create(pathDownload, showWarnings = FALSE)
    
    downloadFiles <- .downloadFiles(filesUrl = filesUrl, pathDownload = pathDownload, threads = threads)
    
    inputFiles <- list.files(pathDownload, pattern = "\\.gz$", full.names = TRUE)
    names(inputFiles) <- gsub(".fragments.tsv.gz", "", list.files(pathDownload, pattern = "\\.gz$"))
    inputFiles <- inputFiles[!grepl(".tbi", inputFiles)]
    
  }else if(tolower(tutorial) %in% c("multiome")){
    
    filesUrl <- data.frame(
      fileUrl = c(
        "https://jeffgranja.s3.amazonaws.com/ArchR/TestData/Multiome/pbmc_sorted_3k.fragments.tsv.gz",
        "https://jeffgranja.s3.amazonaws.com/ArchR/TestData/Multiome/pbmc_sorted_3k.filtered_feature_bc_matrix.h5",
        "https://jeffgranja.s3.amazonaws.com/ArchR/TestData/Multiome/pbmc_unsorted_3k.fragments.tsv.gz",
        "https://jeffgranja.s3.amazonaws.com/ArchR/TestData/Multiome/pbmc_unsorted_3k.filtered_feature_bc_matrix.h5"
      ),
      md5sum = c(
        "d49f4012ff65d9edfee86281d6afb286",
        "e326066b51ec8975197c29a7f911a4fd",
        "5737fbfcb85d5ebf4dab234a1592e740",
        "bd4cc4ff040987e1438f1737be606a27"
      ),
      stringsAsFactors = FALSE
    )
    
    pathDownload <- "Multiome"
    
    dir.create(pathDownload, showWarnings = FALSE)
    
    downloadFiles <- .downloadFiles(filesUrl = filesUrl, pathDownload = pathDownload, threads = threads)
      
    fragFiles <- list.files(pathDownload, pattern = "\\.gz$", full.names = TRUE)
    names(fragFiles) <- gsub(".fragments.tsv.gz", "", list.files(pathDownload, pattern = "\\.gz$"))
    fragFiles <- fragFiles[!grepl(".tbi", fragFiles)]
    geneFiles <- list.files(pathDownload, pattern = "\\.h5$", full.names = TRUE)
    names(geneFiles) <- gsub(".fragments.tsv.gz", "", list.files(pathDownload, pattern = "\\.gz$"))
    
    inputFiles <- c(fragFiles, geneFiles)
    
  }else if(tolower(tutorial) == "test"){

    filesUrl <- data.frame(
      fileUrl = c(
        "https://jeffgranja.s3.amazonaws.com/ArchR/TestData/PBMCSmall.tsv.gz"
      ),
      md5sum = c(
        "0a7a7052b83218667e525127c684aa83"
      ),
      stringsAsFactors = FALSE
    )

    pathDownload <- "TestFragments"

    dir.create(pathDownload, showWarnings = FALSE)
    
    downloadFiles <- .downloadFiles(filesUrl = filesUrl, pathDownload = pathDownload, threads = threads)
    
    inputFiles <- list.files(pathDownload, pattern = "\\.gz$", full.names = TRUE)
    names(inputFiles) <- gsub(".fragments.tsv.gz|.tsv.gz", "", list.files(pathDownload, pattern = "\\.gz$"))
    inputFiles <- inputFiles[!grepl(".tbi", inputFiles)]

  }else{
    
    stop("There is no tutorial data for : ", tutorial)
    
  }
  
  #Set back URL Options
  options(timeout=oldTimeout)
  
  inputFiles
  
}

#helper for file downloads
.downloadFiles <- function(filesUrl = NULL, pathDownload = NULL, threads = 1){
 
  if(is.null(filesUrl)) {
    stop("No value supplied to filesUrl in .downloadFiles()!")
  }

  if(is.null(pathDownload)) {
    stop("No value supplied to pathDownload in .downloadFiles()!")
  }

  if(length(which(c("fileUrl","md5sum") %ni% colnames(filesUrl))) != 0) {
    cat(colnames(filesUrl))
    stop("File download dataframe does not include columns named 'fileUrl' and 'md5sum' which are required!")
  }

  message(paste0("Downloading files to ",pathDownload,"..."))
 
  downloadFiles <- ArchR:::.safelapply(seq_along(filesUrl$fileUrl), function(x){
    
    if(file.exists(file.path(pathDownload, basename(filesUrl$fileUrl[x])))){
      if(tools::md5sum(file.path(pathDownload, basename(filesUrl$fileUrl[x]))) != filesUrl$md5sum[x]) {
        message(paste0("File ",basename(filesUrl$fileUrl[x])," exists but has an incorrect md5sum. Removing..."))
        file.remove(file.path(pathDownload, basename(filesUrl$fileUrl[x])))
      }
    }
    
    if(!file.exists(file.path(pathDownload, basename(filesUrl$fileUrl[x])))){
      message(paste0("Downloading file ", basename(filesUrl$fileUrl[x]),"..."))
      download.file(
        url = filesUrl$fileUrl[x], 
        destfile = file.path(pathDownload, basename(filesUrl$fileUrl[x]))
      ) 
    }else{
      message(paste0("File exists! Skipping file ", basename(filesUrl$fileUrl[x]),"..."))
    }

  }, threads = min(threads, nrow(filesUrl)))
  
  #check for success of file download
  if(!all(unlist(downloadFiles) == 0)) {
    stop("Some files did not download successfully. Please try again.")
  }
  
  downloadFiles 
  
}

#' Get PBMC Small Test Arrow file
#' 
#' V2 : This function will return a test arrow file in your cwd.
#' 
#' @param version version of test arrow to return
#'
#' @examples
#'
#' # Get Test Arrow
#' arrow <- getTestArrow()
#' 
#' @export
getTestArrow <- function(version = 2){

  if(version == 2){
    #Add Genome Return Arrow
    addArchRGenome("hg19test2")
    arrow <- file.path(system.file("testdata", package="ArchR"), "PBSmall.arrow")
    file.copy(arrow, basename(arrow), overwrite = TRUE)
    basename(arrow)
  }else{
    stop("test version doesnt exist!")
  }

}

#' Get PBMC Small Test Fragments
#' 
#' V1 : This function will download fragments for a small PBMC test dataset.
#' V2 : This function will return test fragments for a small PBMC test dataset in your cwd.
#' 
#' @param version version of test fragments to return
#'
#' @examples
#'
#' # Get Test Fragments
#' fragments <- getTestFragments()
#' 
#' @export
getTestFragments <- function(version = 2){

  if(version == 1){

    #Make Sure URL doesnt timeout
    oldTimeout <- getOption('timeout')
    options(timeout=100000)

    if(!file.exists("PBMCSmall.tsv.gz")){
      download.file(
        url = "https://jeffgranja.s3.amazonaws.com/ArchR/TestData/PBMCSmall.tsv.gz",
        destfile = "PBMCSmall.tsv.gz"
      )
    }
    #Set back URL Options
    options(timeout=oldTimeout)

    #Add Genome Return Name Vector
    addArchRGenome("hg19test")
    c("PBMC" = "PBMCSmall.tsv.gz")

  }else if(version == 2){

    #Add Genome Return Name Vector
    addArchRGenome("hg19test2")
    fragments <- file.path(system.file("testdata", package="ArchR"), "PBSmall.tsv.gz")
    file.copy(fragments, basename(fragments), overwrite = TRUE)
    c("PBMC" = basename(fragments))

  }else{
  
  stop("test version doesnt exist!")
  
  }

}


#' Get PBMC Small Test Project
#' 
#' V1 : This function will download an ArchRProject for a small PBMC test dataset.
#' V2 : This function will return an ArchRProject for a small PBMC test dataset in your cwd.
#' 
#' @param version version of test fragments to return
#'
#' @examples
#'
#' # Get Test Project
#' proj <- getTestProject()
#' 
#' @export
getTestProject <- function(version = 2){

  if(version == 1){

  #Make Sure URL doesnt timeout
  oldTimeout <- getOption('timeout')
  options(timeout=100000)
  #Download
  if(!dir.exists("PBMCSmall")){
    download.file(
      url = "https://jeffgranja.s3.amazonaws.com/ArchR/TestData/PBMCSmall.zip",
      destfile = "PBMCSmall.zip"
    )
    unzip("PBMCSmall.zip", exdir = getwd())
    file.remove("PBMCSmall.zip")
  }
  #Set back URL Options
  options(timeout=oldTimeout)
  #Load
  addArchRGenome("hg19test")
  loadArchRProject("PBMCSmall")


  }else if(version == 2){

    #Add Genome Return Name Vector
    addArchRGenome("hg19test2")
    archrproj <- file.path(system.file("testdata", package="ArchR"), "PBSmall.zip")
    file.copy(archrproj, basename(archrproj), overwrite = TRUE)
    unzip(basename(archrproj), overwrite = TRUE)
    file.remove(basename(archrproj))
    loadArchRProject("PBSmall")

  }else{
  
  stop("test version doesnt exist!")
  
  }

}

#' Get Input Files from paths to create arrows
#' 
#' This function will look for fragment files and bam files in the input paths and return the full path and sample names.
#' Only files that match ".fragments.tsv.gz" and ".bam" will be captured. This function requires there to be a prefix
#' before ".fragments.tsv.gz" or ".bam" because this prefix will be used as the sample name. For example, "Sample1.fragments.tsv.gz"
#' would be imported with the name "Sample1".
#' 
#' @param paths A character vector of paths to search for usable input files.
#' @export
getInputFiles <- function(
  paths = NULL
  ){ 

  #Validate
  .validInput(input = paths, name = "paths", valid = "character")
  #########

  v <- lapply(paths, function(x){
    
    #Fragments
    inputFrags <- list.files(x, pattern = ".fragments.tsv.gz", full.names = TRUE)
    names(inputFrags) <- gsub(".fragments.tsv.gz", "", list.files(x, pattern = ".fragments.tsv.gz"))
    inputFrags <- inputFrags[!grepl(".tbi", inputFrags)]
    
    #Bams
    inputBams <- list.files(x, pattern = ".bam", full.names = TRUE)
    names(inputBams) <- gsub(".bam", "", list.files(x, pattern = ".bam"))
    inputBams <- inputBams[!grepl(".bai", inputBams)]
    
    c(inputFrags, inputBams)

  }) %>% unlist

  if(any(duplicated(names(v)))){
    names(v) <- paste0(names(v), "_", seq_along(v))
  }

  v

}

#' Get Valid Barcodes from 10x Cell Ranger output to pre-filter barcodes
#' 
#' This function will read in processed 10x cell ranger files and identify barcodes that are associated with a cell that passed QC.
#' 
#' @param csvFiles A character vector of names from 10x CSV files to be read in for identification of valid cell barcodes.
#' @param sampleNames A character vector containing the sample names to be associated with each individual entry in `csvFiles`.
#' @export
getValidBarcodes <- function(
  csvFiles = NULL, 
  sampleNames = NULL
  ){

  #Validate
  .validInput(input = csvFiles, name = "csvFiles", valid = "character")
  .validInput(input = sampleNames, name = "sampleNames", valid = "character")
  #########

  if(length(sampleNames) != length(csvFiles)){
    stop("csvFiles and sampleNames must exist!")
  }

  if(!all(file.exists(csvFiles))){
    stop("Not All csvFiles exists!")
  }

  barcodeList <- lapply(seq_along(csvFiles), function(x){
    df <- ArchR:::.suppressAll(data.frame(readr::read_csv(csvFiles[x])))
    if("cell_id" %in% colnames(df)){
      as.character(df[which(paste0(df$cell_id) != "None"),]$barcode)
    }else if("is__cell_barcode" %in% colnames(df)){
      as.character(df[which(paste0(df$is__cell_barcode) == 1),]$barcode)
    }else{
      stop("cell_id and is__cell_barcode not in colnames of 10x singlecell.csv file! Are you sure inut is correct?")
    }
  }) %>% SimpleList
  names(barcodeList) <- sampleNames

  barcodeList

}



