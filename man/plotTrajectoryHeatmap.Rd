% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Trajectory.R
\name{plotTrajectoryHeatmap}
\alias{plotTrajectoryHeatmap}
\title{Plot a Heatmap of Features across a Trajectory}
\usage{
plotTrajectoryHeatmap(
  seTrajectory = NULL,
  varCutOff = 0.9,
  maxFeatures = 25000,
  scaleRows = TRUE,
  limits = c(-1.5, 1.5),
  grepExclude = NULL,
  pal = NULL,
  colorColumns = FALSE,
  columnPal = NULL,
  labelMarkers = NULL,
  labelTop = 50,
  labelRows = FALSE,
  rowOrder = NULL,
  useSeqnames = NULL,
  returnMatrix = FALSE,
  force = FALSE,
  logFile = createLogFile("plotTrajectoryHeatmap")
)
}
\arguments{
\item{seTrajectory}{A \code{SummarizedExperiment} object that results from calling \code{getTrajectory()}.}

\item{varCutOff}{The "Variance Quantile Cutoff" to be used for identifying the top variable features across the given trajectory.
Only features with a variance above the provided quantile will be retained.}

\item{maxFeatures}{The maximum number of features, ordered by variance, to consider from \code{useMatrix} when generating a trajectory.
This prevents smoothing a large number number of features which can be very time consuming.}

\item{scaleRows}{A boolean value that indicates whether row-wise z-scores should be computed on the matrix provided by \code{seTrajectory}.}

\item{limits}{A numeric vector of two numbers that represent the lower and upper limits of the heatmap color scheme.}

\item{grepExclude}{A character vector or string that indicates the \code{rownames} or a specific pattern that identifies
rownames from \code{seTrajectory} to be excluded from the heatmap.}

\item{pal}{A custom continuous palette (see \code{paletteContinuous()}) used to override the default continuous palette for the heatmap.}

\item{colorColumns}{A boolean value that indicates whether a color bar should be added to label the columns. The color for each column
will represent the most common label observed in the corresponding trajectory quantile as the heatmap is divided into quantile bins
and thus does not display information for each cell. \code{colorColumns} can only be set to \code{TRUE} if the \code{trajectoryLabel} parameter was used
in \code{getTrajectory()}.}

\item{columnPal}{A discrete palette (see \code{paletteDiscrete()}) that maps the different labels of the trajectory to a unique color. This
parameter is ignored unless \code{colorColumns = TRUE}. All labels shown in \code{unique(colData(seTrajectory)$label)} must be represented.}

\item{labelMarkers}{A character vector listing the \code{rownames} of \code{seTrajectory} that should be labeled on the side of the heatmap.}

\item{labelTop}{A number indicating how many of the top N features, based on variance, in \code{seTrajectory} should be labeled on the side of the heatmap.}

\item{labelRows}{A boolean value that indicates whether all rows should be labeled on the side of the heatmap.}

\item{rowOrder}{If wanting to set the order of rows to be plotted, the indices (integer or character correpsonding
to rownmaes) can be provided here.}

\item{useSeqnames}{A character vector that indicates which \code{seqnames} should be plotted in the heatmap. Features from
\code{seqnames} that are not listed will be ignored. In the context of a \code{Sparse.Assays.Matrix}, such as a matrix containing chromVAR
deviations, the \code{seqnames} do not correspond to chromosomes, rather they correspond to the sub-portions of the matrix, for example
raw deviations ("deviations") or deviation z-scores ("z") for a chromVAR deviations matrix.}

\item{returnMatrix}{A boolean value that indicates whether the final heatmap matrix should be returned in lieu of plotting the actual heatmap.}

\item{force}{If useSeqnames is longer than 1 if matrixClass is "Sparse.Assays.Matrix" to continue. This is not recommended because these matrices
can be in different units.}

\item{logFile}{The path to a file to be used for logging ArchR output.}
}
\description{
This function will plot a heatmap of the results from getTrajectory
}
\examples{

# Get Test ArchR Project
proj <- getTestProject()

#Add Trajectory
proj <- addTrajectory(proj, trajectory = c("C1", "C2", "C3"), embedding = "UMAP", force = TRUE)

#Get Trajectory
seTraj <- getTrajectory(proj)

#Plot Trajectory Heatmap
p <- plotTrajectoryHeatmap(seTraj)

#Plot PDF
plotPDF(p, name = "Trajectory-Heatmap", ArchRProj = proj)

}
