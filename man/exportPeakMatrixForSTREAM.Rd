% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Trajectory.R
\name{exportPeakMatrixForSTREAM}
\alias{exportPeakMatrixForSTREAM}
\title{Get a PeakMatrix stored in an ArchRProject and write out for STREAM}
\usage{
exportPeakMatrixForSTREAM(
  ArchRProj = NULL,
  useSeqnames = NULL,
  verbose = TRUE,
  binarize = FALSE,
  threads = getArchRThreads(),
  logFile = createLogFile("exportMatrixForSTREAM")
)
}
\arguments{
\item{ArchRProj}{An \code{ArchRProject} object to get data matrix from.}

\item{useSeqnames}{A character vector of chromosome names to be used to subset the data matrix being obtained.}

\item{verbose}{A boolean value indicating whether to use verbose output during execution of  this function. Can be set to FALSE for a cleaner output.}

\item{binarize}{A boolean value indicating whether the matrix should be binarized before return. This is often desired when working with insertion counts.}

\item{logFile}{The path to a file to be used for logging ArchR output.}
}
\description{
This function gets a PeakMatrix from an \code{ArchRProject} and writes it to a set of files for STREAM (https://github.com/pinellolab/STREAM)
}
\examples{

# Get Test ArchR Project
proj <- getTestProject()

# Export Matrix For Stream
exportPeakMatrixForSTREAM(proj)

}
