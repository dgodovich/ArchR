% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/IntegrativeAnalysis.R
\name{correlateTrajectories}
\alias{correlateTrajectories}
\title{Correlate Trajectories}
\usage{
correlateTrajectories(
  seTrajectory1 = NULL,
  seTrajectory2 = NULL,
  corCutOff = 0.5,
  varCutOff1 = 0.8,
  varCutOff2 = 0.8,
  removeFromName1 = c("underscore", "dash"),
  removeFromName2 = c("underscore", "dash"),
  useRanges = FALSE,
  fix1 = "center",
  fix2 = "start",
  maxDist = 250000,
  log2Norm1 = TRUE,
  log2Norm2 = TRUE,
  force = FALSE,
  logFile = createLogFile("correlateTrajectories")
)
}
\arguments{
\item{seTrajectory1}{A \code{SummarizedExperiment} object that results from calling \code{getTrajectory()}.}

\item{seTrajectory2}{A \code{SummarizedExperiment} object that results from calling \code{getTrajectory()}.}

\item{corCutOff}{A numeric describing the cutoff for determining correlated features.}

\item{varCutOff1}{The "Variance Quantile Cutoff" to be used for identifying the top variable features across \code{seTrajectory1}.
Only features with a variance above the provided quantile will be retained.}

\item{varCutOff2}{The "Variance Quantile Cutoff" to be used for identifying the top variable features across \code{seTrajectory2}.
Only features with a variance above the provided quantile will be retained.}

\item{removeFromName1}{A character vector describing how to filter names in matrix 1.
Options include "underscore", "dash", "numeric" and "dot". The string portion prior to these will be kept.}

\item{removeFromName2}{A character vector describing how to filter names in matrix 2.
Options include "underscore", "dash", "numeric" and "dot". The string portion prior to these will be kept.}

\item{useRanges}{A boolean describing whether to use range overlap matching for correlation analysis.}

\item{fix1}{A character describing where to resize the coordinates of \code{seTrajectory1}. Options include "start", "center", "end".}

\item{fix2}{A character describing where to resize the coordinates of \code{seTrajectory2}. Options include "start", "center", "end".}

\item{maxDist}{A integer specifying the maximum distance between the coordinates of \code{seTrajectory1} and \code{seTrajectory2} for
computing correlations.}

\item{log2Norm1}{A boolean describing whether to log2 normalize \code{seTrajectory1}.}

\item{log2Norm2}{A boolean describing whether to log2 normalize \code{seTrajectory2}.}

\item{force}{A boolean value that determines whether analysis should continue if resizing coordinates in \code{seTrajectory1} or
\code{seTrajectory2} does not align with the strandedness. Only when \code{useRanges = TRUE}.}

\item{logFile}{The path to a file to be used for logging ArchR output.}
}
\description{
This function will correlate 2 trajectory matrices from getTrajectory.
}
\examples{

# Get Test ArchR Project
proj <- getTestProject()

#Add Trajectory
proj <- addTrajectory(proj, trajectory = c("C1", "C2", "C3"), embedding = "UMAP", force = TRUE)

#Get Trajectories
seTraj1 <- getTrajectory(proj, useMatrix = "GeneScoreMatrix")
seTraj2 <- getTrajectory(proj, useMatrix = "GeneIntegrationMatrix")

#Correlate
corTraj <- correlateTrajectories(seTraj1, seTraj2, corCutOff = 0.35, varCutOff1 = 0.6, varCutOff2 = 0.6)

}
