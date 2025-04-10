% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/IterativeLSI.R
\name{addIterativeLSI}
\alias{addIterativeLSI}
\title{Add an Iterative LSI-based dimensionality reduction to an ArchRProject}
\usage{
addIterativeLSI(
  ArchRProj = NULL,
  useMatrix = "TileMatrix",
  name = "IterativeLSI",
  iterations = 2,
  clusterParams = list(resolution = c(2), sampleCells = 10000, maxClusters = 6, n.start =
    10),
  firstSelection = "top",
  depthCol = "nFrags",
  varFeatures = 25000,
  dimsToUse = 1:30,
  LSIMethod = 2,
  scaleDims = TRUE,
  corCutOff = 0.75,
  binarize = TRUE,
  outlierQuantiles = c(0.02, 0.98),
  filterBias = TRUE,
  sampleCellsPre = 10000,
  projectCellsPre = FALSE,
  sampleCellsFinal = NULL,
  selectionMethod = "var",
  scaleTo = 10000,
  totalFeatures = 5e+05,
  filterQuantile = 0.995,
  excludeChr = c(),
  keep0lsi = FALSE,
  saveIterations = TRUE,
  UMAPParams = list(n_neighbors = 40, min_dist = 0.4, metric = "cosine", verbose = FALSE,
    fast_sgd = TRUE),
  nPlot = 10000,
  outDir = getOutputDirectory(ArchRProj),
  threads = getArchRThreads(),
  seed = 1,
  verbose = TRUE,
  force = FALSE,
  logFile = createLogFile("addIterativeLSI")
)
}
\arguments{
\item{ArchRProj}{An \code{ArchRProject} object.}

\item{useMatrix}{The name of the data matrix to retrieve from the ArrowFiles associated with the \code{ArchRProject}. Valid options are
"TileMatrix" or "PeakMatrix".}

\item{name}{The name to use for storage of the IterativeLSI dimensionality reduction in the \code{ArchRProject} as a \code{reducedDims} object.}

\item{iterations}{The number of LSI iterations to perform.}

\item{clusterParams}{A list of additional parameters to be passed to \code{addClusters()} for clustering within each iteration.
These params can be constant across each iteration, or specified for each iteration individually. Thus each param must be of
length == 1 or the total number of \code{iterations} - 1. If you want to use \code{scran} for clustering, you would pass this as \code{method="scran"}.}

\item{firstSelection}{First iteration selection method for features to use for LSI. Either "Top" for the top accessible/average or "Var" for the top variable features.
"Top" should be used for all scATAC-seq data (binary) while "Var" should be used for all scRNA/other-seq data types (non-binary).}

\item{depthCol}{A column in the \code{ArchRProject} that represents the coverage (scATAC = unique fragments, scRNA = unique molecular identifiers) per cell.
These values are used to minimize the related biases in the reduction related. For scATAC we recommend "nFrags" and for scRNA we recommend "Gex_nUMI".}

\item{varFeatures}{The number of N variable features to use for LSI. The top N features will be used based on the \code{selectionMethod}.}

\item{dimsToUse}{A vector containing the dimensions to use in LSI. The total dimensions used in LSI will be \code{max(dimsToUse)}. If you set this too high,
it could impact downstream functionalities including increasing the time required to run \code{addClusters()}.}

\item{LSIMethod}{A number or string indicating the order of operations in the TF-IDF normalization.
Possible values are: 1 or "tf-logidf", 2 or "log(tf-idf)", and 3 or "logtf-logidf".}

\item{scaleDims}{A boolean that indicates whether to z-score the reduced dimensions for each cell. This is useful forminimizing the contribution
of strong biases (dominating early PCs) and lowly abundant populations. However, this may lead to stronger sample-specific biases since
it is over-weighting latent PCs.}

\item{corCutOff}{A numeric cutoff for the correlation of each dimension to the sequencing depth. If the dimension has a correlation to
sequencing depth that is greater than the \code{corCutOff}, it will be excluded from analysis.}

\item{binarize}{A boolean value indicating whether the matrix should be binarized before running LSI. This is often desired when working with insertion counts.}

\item{outlierQuantiles}{Two numerical values (between 0 and 1) that describe the lower and upper quantiles of bias (number of acessible regions per cell, determined
by \code{nFrags} or \code{colSums}) to filter cells prior to LSI. For example a value of c(0.02, 0.98) results in the cells in the bottom 2 percent and upper 98 percent to be
filtered prior to LSI. These cells are then projected back in the LSI subspace. This prevents spurious 'islands' that are identified based on being extremely biased.
These quantiles are also used for sub-sampled LSI when determining which cells are used.}

\item{filterBias}{A boolean indicating whether to drop bias clusters when computing clusters during iterativeLSI.}

\item{sampleCellsPre}{An integer specifying the number of cells to sample in iterations prior to the last in order to perform a sub-sampled LSI and
sub-sampled clustering. This greatly reduced memory usage and increases speed for early iterations.}

\item{projectCellsPre}{A boolean indicating whether to reproject all cells into the sub-sampled LSI (see \code{sampleCellsPre}). Setting this to \code{FALSE}
allows for using the sub-sampled LSI for clustering and variance identification. If \code{TRUE} the cells are all projected into the sub-sampled LSI
and used for cluster and variance identification.}

\item{sampleCellsFinal}{An integer specifying the number of cells to sample in order to perform a sub-sampled LSI in final iteration.}

\item{selectionMethod}{The selection method to be used for identifying the top variable features. Valid options are "var" for
log-variability or "vmr" for variance-to-mean ratio.}

\item{scaleTo}{Each column in the matrix designated by \code{useMatrix} will be normalized to a column sum designated by \code{scaleTo} prior to
variance calculation and TF-IDF normalization.}

\item{totalFeatures}{The number of features to consider for use in LSI after ranking the features by the total number of insertions.
These features are the only ones used throught the variance identification and LSI. These are an equivalent when using a \code{TileMatrix} to a defined peakSet.}

\item{filterQuantile}{A number \link{0,1} that indicates the quantile above which features should be removed based on insertion counts prior
to the first iteration of the iterative LSI paradigm. For example, if \code{filterQuantile = 0.99}, any features above the 99th percentile in
insertion counts will be ignored for the first LSI iteration.}

\item{excludeChr}{A string of chromosomes to exclude for iterativeLSI procedure.}

\item{keep0lsi}{A boolean whether to keep cells with no reads in features used for LSI.}

\item{saveIterations}{A boolean value indicating whether the results of each LSI iterations should be saved as compressed \code{.rds} files in
the designated \code{outDir}.}

\item{UMAPParams}{The list of parameters to pass to the UMAP function if "UMAP" if \code{saveIterations=TRUE}. See the function \code{uwot::umap()}.}

\item{nPlot}{If \code{saveIterations=TRUE}, how many cells to sample make a UMAP and plot for each iteration.}

\item{outDir}{The output directory for saving LSI iterations if desired. Default is in the \code{outputDirectory} of the \code{ArchRProject}.}

\item{threads}{The number of threads to be used for parallel computing.}

\item{seed}{A number to be used as the seed for random number generation. It is recommended to keep track of the seed used so that you can
reproduce results downstream.}

\item{verbose}{A boolean value that determines whether standard output includes verbose sections.}

\item{force}{A boolean value that indicates whether or not to overwrite relevant data in the \code{ArchRProject} object.}

\item{logFile}{The path to a file to be used for logging ArchR output.}
}
\description{
This function will compute an iterative LSI dimensionality reduction on an ArchRProject.
}
\examples{

# Get Test ArchR Project
proj <- getTestProject()

# Iterative LSI
proj <- addIterativeLSI(proj, dimsToUse = 1:5, varFeatures=1000, iterations = 2, force=TRUE)

}
