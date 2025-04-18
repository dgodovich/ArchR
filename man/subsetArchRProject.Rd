% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllClasses.R
\name{subsetArchRProject}
\alias{subsetArchRProject}
\title{Subset an ArchRProject for downstream analysis}
\usage{
subsetArchRProject(
  ArchRProj = NULL,
  cells = getCellNames(ArchRProj),
  outputDirectory = "ArchRSubset",
  dropCells = TRUE,
  logFile = NULL,
  threads = getArchRThreads(),
  force = FALSE
)
}
\arguments{
\item{ArchRProj}{An \code{ArchRProject} object.}

\item{cells}{A vector of cells to subset \code{ArchRProject} by. Alternatively can provide a subset \code{ArchRProject}.}

\item{outputDirectory}{A directory path to save all ArchR output and the subsetted \code{ArchRProject} to.}

\item{dropCells}{A boolean indicating whether to drop cells that are not in \code{ArchRProject} from corresponding Arrow Files.}

\item{logFile}{The path to a file to be used for logging ArchR output.}

\item{threads}{The number of threads to use for parallel execution.}

\item{force}{If output directory exists overwrite.}
}
\description{
This function will subset and ArchRProject by cells and save the output to a new directory and re-load the subsetted ArchRProject.
}
\examples{

# Get Small Test Project
proj <- getTestProject()

#Subset
proj <- subsetArchRProject(proj, cells = getCellNames(proj)[1:50])

}
