% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/InputData.R
\name{getTutorialData}
\alias{getTutorialData}
\title{Get Relevant Data For ArchR Tutorials}
\usage{
getTutorialData(tutorial = "hematopoiesis", threads = getArchRThreads())
}
\arguments{
\item{tutorial}{The name of the available tutorial for which to retreive the tutorial data. The main option is "Hematopoiesis".
"Hematopoiesis" is a small scATAC-seq dataset that spans the hematopoieitic hierarchy from stem cells to differentiated cells.
This dataset is made up of cells from peripheral blood, bone marrow, and CD34+ sorted bone marrow. The second option is "Test"
which is downloading a small test PBMC fragments file mainly used to test the url capabilities of this function.}

\item{threads}{The number of threads to be used for parallel computing.}
}
\description{
This function will download data for a given tutorial and return the input files required for ArchR.
}
\examples{

# Get Tutorial Fragments using `test` since its smaller
fragments <- getTutorialData(tutorial = "test")

}
