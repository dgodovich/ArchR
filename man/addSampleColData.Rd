% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ProjectMethods.R
\name{addSampleColData}
\alias{addSampleColData}
\title{Add information to sampleColData in an ArchRProject}
\usage{
addSampleColData(
  ArchRProj = NULL,
  data = NULL,
  name = NULL,
  samples = NULL,
  force = FALSE
)
}
\arguments{
\item{ArchRProj}{An \code{ArchRProject} object.}

\item{data}{A vector containing the data to be added to \code{sampleColData}.}

\item{name}{The column header name to be used for this new data in \code{sampleColData}.
If a column with this name already exists, you may set \code{force} equal to \code{TRUE} to overwrite the data in this column.}

\item{samples}{The names of the samples corresponding to \code{data}. Typically new data is added to all samples but you may
use this argument to only add data to a subset of samples. Samples where \code{data} is not added are set to \code{NA}.}

\item{force}{A boolean value that indicates whether or not to overwrite data in a given column when the value passed to \code{name}
already exists as a column name in \code{sampleColData}.}
}
\description{
This function adds new data to sampleColData in an ArchRProject.
}
\examples{

# Get Test ArchR Project
proj <- getTestProject()

# Add Sample Column Data
addSampleColData(proj, data = 1, name = "Test", samples = "PBSmall")

}
